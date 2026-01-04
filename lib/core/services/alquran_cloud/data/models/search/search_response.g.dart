// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      code: (json['code'] as num).toInt(),
      status: json['status'] as String,
      data: json['data'] == null
          ? null
          : SearchDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };

SearchDataModel _$SearchDataModelFromJson(Map<String, dynamic> json) =>
    SearchDataModel(
      count: (json['count'] as num).toInt(),
      matches: (json['matches'] as List<dynamic>)
          .map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchDataModelToJson(SearchDataModel instance) =>
    <String, dynamic>{'count': instance.count, 'matches': instance.matches};
