import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';
import 'manzil_model.dart';

part 'manzil_response.g.dart';

/// Response wrapper for Manzil.
@JsonSerializable()
class ManzilResponse extends BaseResponse<ManzilModel> {
  const ManzilResponse({
    required super.code,
    required super.status,
    super.data,
  });

  factory ManzilResponse.fromJson(Map<String, dynamic> json) =>
      _$ManzilResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(ManzilModel _) _) =>
      _$ManzilResponseToJson(this);
}
