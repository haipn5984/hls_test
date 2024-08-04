import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'base.dart';
import 'exception_wrapper/exception_wrapper.dart';
import 'exception_wrapper/remote_exception.dart';

class StateLayout<T extends BaseBloc> extends StatelessWidget {
  final Widget body;
  const StateLayout({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<T>().commonBloc,
      child: BlocBuilder<CommonBloc, CommonState>(
        builder: (BuildContext context, CommonState state) {
          if (state.wrapper != null && state.buildWidgetError) {
            return _buildErrorWidget(state.wrapper!);
          }
          return Stack(
            children: [
              body,
              Visibility(
                visible: state.isLoading,
                child: buildPageLoading(
                  title: state.loadingTitle,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(ExceptionWrapper wrapper) {
    if (wrapper.exception is RemoteException) {
      if ((wrapper.exception as RemoteException).kind ==
          RemoteExceptionKind.noInternet) {
        return TextButton(
          onPressed: () {
            wrapper.callBackAction?.call();
          },
          child: const Text('No network, click to try again'),
        );
      }
    }
    return TextButton(
      child: const Text(
        'Something went wrong, click to try again',
      ),
      onPressed: () {
        wrapper.callBackAction?.call();
      },
    );
  }

  Widget buildPageLoading({String? title}) => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2,
          sigmaY: 2,
        ),
        child: AlertDialog(
          backgroundColor: Colors.white,
          content: Row(
            children: [
              CircularProgressIndicator(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 7),
                  child: const Text('Loading'),
                ),
              ),
            ],
          ),
        ),
      );
}
