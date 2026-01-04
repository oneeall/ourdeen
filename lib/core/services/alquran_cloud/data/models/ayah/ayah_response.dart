import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';
import 'ayah_model.dart';

part 'ayah_response.g.dart';

/// Response wrapper for a single ayah.
@JsonSerializable()
class AyahResponse extends BaseResponse<AyahModel> {
  const AyahResponse({
    required super.code,
    required super.status,
    super.data,
  });

  factory AyahResponse.fromJson(Map<String, dynamic> json) =>
      _$AyahResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(AyahModel _) _) =>
      _$AyahResponseToJson(this);
}

/// Response wrapper for multiple ayahs from multiple editions.
@JsonSerializable()
class AyahMultipleResponse extends BaseResponse<List<AyahModel>> {
  const AyahMultipleResponse({
    required super.code,
    required super.status,
    super.data,
  });

  factory AyahMultipleResponse.fromJson(Map<String, dynamic> json) =>
      _$AyahMultipleResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(List<AyahModel> _) _) =>
      _$AyahMultipleResponseToJson(this);
}
