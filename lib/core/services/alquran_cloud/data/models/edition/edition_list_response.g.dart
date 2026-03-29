// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edition_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditionListResponse _$EditionListResponseFromJson(Map<String, dynamic> json) =>
    EditionListResponse(
      code: (json['code'] as num).toInt(),
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => EditionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EditionListResponseToJson(
  EditionListResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'data': instance.data,
};
