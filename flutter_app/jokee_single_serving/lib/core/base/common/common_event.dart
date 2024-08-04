part of 'common_bloc.dart';

@freezed
class CommonEvent extends BaseEvent with _$CommonEvent {
  const factory CommonEvent.onExceptionEmitted({
    ExceptionWrapper? wrapper,
    @Default(true) buildWidgetError,
  }) = _OnExceptionEmitted;

  const factory CommonEvent.onLoadingVisibilityEmitted({
    required bool isLoading,
    String? loadingTitle,
    @Default(false) bool useSkeletonWidget,
  }) = _OnLoadingVisibilityEmitted;

  const factory CommonEvent.onBuildWidgetErrorChange(
    bool buildWidgetError,
  ) = _OnBuildWidgetErrorChange;
}
