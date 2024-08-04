import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../exception_wrapper/app_exception.dart';
import '../exception_wrapper/exception_handler.dart';

Future showErrorDialog(
  BuildContext context, {
  String? title,
  State? state,
  bool notExit = false,
  Color? trackColor,
  Color? backgroundColor,
  VoidCallback? onConfirm,
}) {
  final alert = Dialog(
    backgroundColor: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 7),
                  child: Text(
                    title ?? 'Có lỗi xảy ra, vui lòng thử lại sau...',
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm?.call();
            },
            child: const Text(
              'Đóng',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    ),
  );
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) async {
          if (notExit == true) return;
          if (state != null) {
            try {
              Navigator.of(context).pop();
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
              rethrow;
            }
          }
          return;
        },
        child: alert,
      );
    },
  );
}

Future<T?> runCatchingResponse<T>(
    Future<dynamic> Function() block, T Function(dynamic json) map) async {
  final Response response = await block();
  T? data;
  // if (response.statusCode == 200 || response.statusCode == 201) {
  try {
    data = map(response.data);
  } catch (e) {
    throw ExceptionHandler.catchingRemoteExeption(response);
    // throw ExceptionHandler.catchingRemoteExeption(e);
  }
  // } else {
  //   throw ExceptionHandler.catchingRemoteExeption(response);
  // }
  return data;
}

Future<E?> runCatchingModel<T, E>(
  Future<T> Function() block,
  E Function(T) map,
) async {
  try {
    final res = await block();
    return map(res);
  } catch (error) {
    throw error is AppException
        ? error
        : ExceptionHandler.catchingRemoteExeption(error);
  }
}
