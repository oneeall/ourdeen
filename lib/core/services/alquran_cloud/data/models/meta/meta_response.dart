import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';

part 'meta_response.g.dart';

/// Response wrapper for Meta data.
@JsonSerializable()
class MetaResponse extends BaseResponse<Map<String, dynamic>> {
  const MetaResponse({
    required super.code,
    required super.status,
    super.data,
  });

  factory MetaResponse.fromJson(Map<String, dynamic> json) =>
      _$MetaResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(Map<String, dynamic> _) _) =>
      _$MetaResponseToJson(this);
}
