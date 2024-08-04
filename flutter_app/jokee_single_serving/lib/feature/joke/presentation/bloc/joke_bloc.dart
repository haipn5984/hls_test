import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jokee_single_serving/core/base/bloc/base_bloc.dart';
import 'package:jokee_single_serving/core/injection_container.dart';
import 'package:jokee_single_serving/core/usecases/usecase.dart';
import 'package:jokee_single_serving/feature/joke/domain/entities/joke_model.dart';
import 'package:jokee_single_serving/feature/joke/domain/use_cases/get_joke_usecase.dart';

part 'joke_event.dart';
part 'joke_state.dart';
part 'joke_bloc.freezed.dart';

class JokeBloc extends BaseBloc<JokeEvent, JokeState> {
  final GetJokeUseCase _getJokeUseCase = getItInstance.get();

  JokeBloc() : super(const JokeState()) {
    on<_OnFetched>(_onFetched);
    on<_OnVoted>(_onVoted);
  }

  FutureOr<void> _onFetched(
    _OnFetched event,
    Emitter<JokeState> emit,
  ) async {
    final listJoke = await _getJokeUseCase(NoParams());
    final unReadJokes =
        listJoke.where((element) => element.agree == null).toList();
    emit(
      state.copyWith(
        jokes: unReadJokes,
        joke: unReadJokes.firstOrNull,
      ),
    );
  }

  FutureOr<void> _onVoted(
    _OnVoted event,
    Emitter<JokeState> emit,
  ) async {
    final readJoke = [
      ...state.read,
    ];
    if (state.joke?.id != null) readJoke.add(state.joke!.id!);
  }
}
