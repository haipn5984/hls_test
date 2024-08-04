class BaseModel<T> {
  int? code;
  String? message;
  T? data;

  BaseModel({
    this.code,
    this.data,
    this.message,
  });
}
