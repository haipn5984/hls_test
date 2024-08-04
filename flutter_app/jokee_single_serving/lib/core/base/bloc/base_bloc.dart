import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../function/check_network.dart';
import '../entities/base_model.dart';
import '../common/common_bloc.dart';
import '../exception_wrapper/app_exception.dart';
import '../exception_wrapper/exception_wrapper.dart';
import '../exception_wrapper/remote_exception.dart';

part 'base_state.dart';
part 'base_event.dart';

abstract class BaseBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  final CommonBloc commonBloc = CommonBloc();
  BaseBloc(
    super.initialState,
  );

  @override
  void add(E event) {
    if (!isClosed) {
      super.add(event);
    } else if (kDebugMode) {
      log('Cannot add new event $event because $runtimeType was closed');
    }
  }

  void showLoading({String? loadingTitle, bool useSkeletonWidget = false}) {
    commonBloc.add(
      CommonEvent.onLoadingVisibilityEmitted(
        isLoading: true,
        loadingTitle: loadingTitle,
        useSkeletonWidget: useSkeletonWidget,
      ),
    );
  }

  void hideLoading() {
    commonBloc.add(
      const CommonEvent.onLoadingVisibilityEmitted(
        isLoading: false,
      ),
    );
  }

  void addException(ExceptionWrapper exception) {
    commonBloc.add(CommonEvent.onExceptionEmitted(wrapper: exception));
  }

  void clearException() {
    commonBloc.add(const CommonEvent.onExceptionEmitted(wrapper: null));
  }

  void checkBuildWidgetError(bool buildError) {
    if (buildError != commonBloc.state.buildWidgetError) {
      {
        commonBloc.add(
          CommonEvent.onBuildWidgetErrorChange(buildError),
        );
      }
    }
  }

  Future<void> blocResultCatching<T>({
    required Future<BaseModel<T>> action,
    Function(T?)? onSuccess,
    bool handleLoading = true,
    bool handleError = true,
    Function(dynamic)? doOnError,
    Function()? doOnRetry,
  }) async {
    if (handleLoading) {
      showLoading();
    }
    try {
      final result = await action;
      onSuccess?.call(result.data);
    } catch (e) {
      doOnError?.call(e);
    }
    if (handleLoading) {
      hideLoading();
    }
  }

  Future<void> blocCatching<T>({
    required Future<T> action,
    Function(T)? onSuccess,
    bool handleLoading = true,
    bool handleError = true,
    Function()? doOnError,
    Function()? doOnRetry,
    String? loadingTitle,
    bool useSkeletonLoading = false,
    bool buildWidgetError = true,
  }) async {
    checkBuildWidgetError(buildWidgetError);
    final networkConnect = await checkNetworkNoToast();
    if (!networkConnect) {
      addException(
        ExceptionWrapper(
          exception: RemoteException(
            kind: RemoteExceptionKind.noInternet,
          ),
          callBackAction: doOnError,
        ),
      );
      return;
    }
    if (handleLoading) {
      showLoading(
        useSkeletonWidget: useSkeletonLoading,
        loadingTitle: loadingTitle,
      );
    }
    try {
      final result = await action;
      clearException();
      hideLoading();
      onSuccess?.call(result);
    } catch (e) {
      if (handleError) {
        hideLoading();
        addException(
          ExceptionWrapper(
            exception: e is AppException ? e : UnCatchException(),
            callBackAction: doOnError,
          ),
        );
      }
    }
  }
}
