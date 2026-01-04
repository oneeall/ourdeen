import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';
import 'page_model.dart';

part 'page_response.g.dart';

/// Response wrapper for Page.
@JsonSerializable()
class PageResponse extends BaseResponse<PageModel> {
  const PageResponse({
    required super.code,
    required super.status,
    super.data,
  });

  factory PageResponse.fromJson(Map<String, dynamic> json) =>
      _$PageResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(PageModel _) _) =>
      _$PageResponseToJson(this);
}
