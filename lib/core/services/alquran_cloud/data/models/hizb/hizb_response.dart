import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';
import 'hizb_model.dart';

part 'hizb_response.g.dart';

/// Response wrapper for Hizb.
@JsonSerializable()
class HizbResponse extends BaseResponse<HizbModel> {
  const HizbResponse({
    required super.code,
    required super.status,
    super.data,
  });

  factory HizbResponse.fromJson(Map<String, dynamic> json) =>
      _$HizbResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(HizbModel _) _) =>
      _$HizbResponseToJson(this);
}
