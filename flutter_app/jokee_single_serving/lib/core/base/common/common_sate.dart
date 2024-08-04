part of 'common_bloc.dart';

@freezed
class CommonState extends BaseState with _$CommonState {
  const factory CommonState({
    ExceptionWrapper? wrapper,
    @Default(false) bool isLoading,
    String? loadingTitle,
    @Default(false) bool useSkeletonWidget,
    @Default(false) boolShowNetworkError,
    @Default(true) buildWidgetError,
  }) = _CommonState;
}
