import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';
import '../ayah/ayah_model.dart';

part 'search_response.g.dart';

/// Response wrapper for search results.
@JsonSerializable()
class SearchResponse extends BaseResponse<SearchDataModel> {
  const SearchResponse({
    required super.code,
    required super.status,
    super.data,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(SearchDataModel _) _) =>
      _$SearchResponseToJson(this);
}

/// Search result data.
@JsonSerializable()
class SearchDataModel extends Object {
  final int count;
  final List<AyahModel> matches;

  const SearchDataModel({
    required this.count,
    required this.matches,
  });

  factory SearchDataModel.fromJson(Map<String, dynamic> json) =>
      _$SearchDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDataModelToJson(this);
}
