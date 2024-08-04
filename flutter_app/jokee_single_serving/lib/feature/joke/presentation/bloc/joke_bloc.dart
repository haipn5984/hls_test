import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jokee_single_serving/core/base/bloc/base_bloc.dart';
import 'package:jokee_single_serving/core/injection_container.dart';
import 'package:jokee_single_serving/core/usecases/usecase.dart';
import 'package:jokee_single_serving/feature/joke/domain/entities/joke_model.dart';
import 'package:jokee_single_serving/feature/joke/domain/use_cases/get_joke_usecase.dart';
import 'package:jokee_single_serving/feature/joke/domain/use_cases/save_joke_usecase.dart';

part 'joke_event.dart';
part 'joke_state.dart';
part 'joke_bloc.freezed.dart';

class JokeBloc extends BaseBloc<JokeEvent, JokeState> {
  final GetJokeUseCase _getJokeUseCase = getItInstance.get();
  final SaveJokeUseCase _saveJokeUseCase = getItInstance.get();

  JokeBloc() : super(const JokeState()) {
    on<_OnFetched>(_onFetched);
    on<_OnVoted>(_onVoted);
  }

  FutureOr<void> _onFetched(
    _OnFetched event,
    Emitter<JokeState> emit,
  ) async {
    showLoading();
    var listJoke = await _getJokeUseCase(NoParams());
    if (listJoke.isEmpty) {
      await _saveJokeUseCase(_jokeData);
    }
    listJoke = await _getJokeUseCase(NoParams());

    final unReadJokes =
        listJoke.where((element) => element.agree == null).toList();
    emit(
      state.copyWith(
        jokes: unReadJokes,
        joke: unReadJokes.firstOrNull,
      ),
    );
    hideLoading();
  }

  FutureOr<void> _onVoted(
    _OnVoted event,
    Emitter<JokeState> emit,
  ) async {
    if (state.joke != null) {
      final List<JokeModel> jokes = [...state.jokes]
        ..removeWhere((element) => element.id == state.joke?.id);
      jokes.add(
        state.joke!.copyWith(agree: event.agree),
      );
      await _saveJokeUseCase(jokes);
    }
    add(const _OnFetched());
  }
}

final _jokeData = [
  JokeModel(
    id: 1,
    joke: '''
A child asked his father, "How were people born?" So his father said, "Adam and Eve made babies, then their babies became adults and made babies, and so on."
\nThe child then went to his mother, asked her the same question and she told him, "We were monkeys then we evolved to become like we are now."
\nThe child ran back to his father and said, "You lied to me!" His father replied, "No, your mom was talking about her side of the family."
''',
  ),
  JokeModel(
    id: 2,
    joke: '''
Teacher: "Kids,what does the chicken give you?" Student: "Meat!" Teacher: "Very good! Now what does the pig give you?" Student: "Bacon!" Teacher: "Great! And what does the fat cow give you?" Student: "Homework!"
''',
  ),
  JokeModel(
    id: 3,
    joke: '''
The teacher asked Jimmy, "Why is your cat at school today Jimmy?" Jimmy replied crying, "Because I heard my daddy tell my mommy, 'I am going to eat that pussy once Jimmy leaves for school today!'"
''',
  ),
  JokeModel(
    id: 1,
    joke: '''
A housewife, an accountant and a lawyer were asked "How much is 2+2?" The housewife replies: "Four!". The accountant says: "I think it's either 3 or 4. Let me run those figures through my spreadsheet one more time." The lawyer pulls the drapes, dims the lights and asks in a hushed voice, "How much do you want it to be?"
''',
  ),
];
