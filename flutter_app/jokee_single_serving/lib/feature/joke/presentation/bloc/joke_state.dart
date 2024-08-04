part of 'joke_bloc.dart';

@freezed
class JokeState extends BaseState with _$JokeState {
  const factory JokeState({
    @Default([]) List<JokeModel> jokes,
    JokeModel? joke,
  }) = _JokeState;
}
