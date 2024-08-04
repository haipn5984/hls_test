import 'package:json_annotation/json_annotation.dart';

import '../base.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
@JsonSerializable()
class BaseResponse<T> {
  int? code;
  String? message;
  T? data;

  BaseResponse({
    this.data,
    this.message,
    this.code,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T? value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);

  BaseModel<E> toModel<E>(E? Function(T?) mapObject) {
    return BaseModel(
      message: message,
      code: code,
      data: mapObject(data),
    );
  }
}
