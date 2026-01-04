import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';
import 'surah_model.dart';

part 'surah_detail_response.g.dart';

/// Response wrapper for a single surah with ayahs.
@JsonSerializable()
class SurahDetailResponse extends BaseResponse<SurahModel> {
  const SurahDetailResponse({
    required super.code,
    required super.status,
    super.data,
  });

  factory SurahDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$SurahDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(SurahModel _) _) =>
      _$SurahDetailResponseToJson(this);
}
