import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';
import 'juz_model.dart';

part 'juz_response.g.dart';

/// Response wrapper for Juz.
@JsonSerializable()
class JuzResponse extends BaseResponse<JuzModel> {
  const JuzResponse({
    required super.code,
    required super.status,
    super.data,
  });

  factory JuzResponse.fromJson(Map<String, dynamic> json) =>
      _$JuzResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(JuzModel _) _) =>
      _$JuzResponseToJson(this);
}
