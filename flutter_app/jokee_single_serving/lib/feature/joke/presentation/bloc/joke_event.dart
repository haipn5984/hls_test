part of 'joke_bloc.dart';

@freezed
class JokeEvent extends BaseEvent with _$JokeEvent {
  const factory JokeEvent.fetched() = _OnFetched;
  const factory JokeEvent.onVoted({required bool agree}) = _OnVoted;
}
