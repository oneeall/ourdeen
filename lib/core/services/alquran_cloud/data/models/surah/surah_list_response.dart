import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';
import 'surah_model.dart';

part 'surah_list_response.g.dart';

/// Response wrapper for list of surahs.
@JsonSerializable()
class SurahListResponse extends BaseResponse<List<SurahModel>> {
  const SurahListResponse({
    required super.code,
    required super.status,
    super.data,
  });

  factory SurahListResponse.fromJson(Map<String, dynamic> json) =>
      _$SurahListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(List<SurahModel> _) _) =>
      _$SurahListResponseToJson(this);
}
