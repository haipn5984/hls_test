import 'app_exception.dart';

class ExceptionWrapper {
  final AppException exception;
  final Function()? callBackAction;

  ExceptionWrapper({required this.exception, required this.callBackAction});
}
