import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';
import 'ruku_model.dart';

part 'ruku_response.g.dart';

/// Response wrapper for Ruku.
@JsonSerializable()
class RukuResponse extends BaseResponse<RukuModel> {
  const RukuResponse({
    required super.code,
    required super.status,
    super.data,
  });

  factory RukuResponse.fromJson(Map<String, dynamic> json) =>
      _$RukuResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(RukuModel _) _) =>
      _$RukuResponseToJson(this);
}
