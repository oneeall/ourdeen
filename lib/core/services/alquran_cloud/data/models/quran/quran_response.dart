import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';
import 'quran_model.dart';

part 'quran_response.g.dart';

/// Response wrapper for complete Quran.
@JsonSerializable()
class QuranResponse extends BaseResponse<QuranModel> {
  const QuranResponse({
    required super.code,
    required super.status,
    super.data,
  });

  factory QuranResponse.fromJson(Map<String, dynamic> json) =>
      _$QuranResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(QuranModel _) _) =>
      _$QuranResponseToJson(this);
}
