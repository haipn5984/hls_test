abstract class AppException implements Exception {
  final AppExceptionType type;

  AppException(this.type);

  String get message;
}

class UnCatchException extends AppException {
  UnCatchException({this.overridMessage}) : super(AppExceptionType.unknown);
  final String? overridMessage;

  @override
  String get message {
    return overridMessage ?? 'Có lỗi xảy ra';
  }
}

enum AppExceptionType {
  remote,
  unknown,
}
