import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';
import 'edition_model.dart';

part 'edition_list_response.g.dart';

/// Response wrapper for list of editions.
@JsonSerializable()
class EditionListResponse extends BaseResponse<List<EditionModel>> {
  const EditionListResponse({
    required super.code,
    required super.status,
    super.data,
  });

  factory EditionListResponse.fromJson(Map<String, dynamic> json) =>
      _$EditionListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(List<EditionModel> _) _) =>
      _$EditionListResponseToJson(this);
}
