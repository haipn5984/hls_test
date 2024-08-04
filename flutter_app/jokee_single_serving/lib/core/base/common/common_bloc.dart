import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jokee_single_serving/core/base/base.dart';

import '../exception_wrapper/exception_wrapper.dart';
part 'common_bloc.freezed.dart';

part 'common_event.dart';
part 'common_sate.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  CommonBloc() : super(const CommonState()) {
    on<_OnLoadingVisibilityEmitted>(
      _onLoadingVisibilityEmitted,
    );

    on<_OnExceptionEmitted>(
      _onExceptionEmitted,
    );

    on<_OnBuildWidgetErrorChange>(_onBuildWidgetErrorChange);
  }

  FutureOr<void> _onLoadingVisibilityEmitted(
    _OnLoadingVisibilityEmitted event,
    Emitter<CommonState> emit,
  ) {
    emit(
      state.copyWith(
        isLoading: event.isLoading,
        loadingTitle: event.isLoading ? event.loadingTitle : null,
        useSkeletonWidget: event.useSkeletonWidget,
      ),
    );
  }

  FutureOr<void> _onExceptionEmitted(
    _OnExceptionEmitted event,
    Emitter<CommonState> emit,
  ) {
    emit(
      state.copyWith(
        wrapper: event.wrapper,
      ),
    );
  }

  FutureOr<void> _onBuildWidgetErrorChange(
    _OnBuildWidgetErrorChange event,
    Emitter<CommonState> emit,
  ) {
    emit(
      state.copyWith(
        buildWidgetError: event.buildWidgetError,
      ),
    );
  }
}
