import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';
import 'sajda_model.dart';

part 'sajda_response.g.dart';

/// Response wrapper for Sajda.
@JsonSerializable()
class SajdaResponse extends BaseResponse<SajdaModel> {
  const SajdaResponse({
    required super.code,
    required super.status,
    super.data,
  });

  factory SajdaResponse.fromJson(Map<String, dynamic> json) =>
      _$SajdaResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(SajdaModel _) _) =>
      _$SajdaResponseToJson(this);
}
