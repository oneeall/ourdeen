import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

/// Base response wrapper for all Alquran.cloud API responses.
///
/// The API always returns responses in this format:
/// ```json
/// {
///   "code": 200,
///   "status": "OK",
///   "data": { ... }
/// }
/// ```
@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> extends Equatable {
  final int code;
  final String status;
  final T? data;

  const BaseResponse({
    required this.code,
    required this.status,
    this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);

  /// Returns true if the response indicates success.
  bool get isSuccess => code == 200 && status.toLowerCase() == 'ok';

  @override
  List<Object?> get props => [code, status, data];
}
