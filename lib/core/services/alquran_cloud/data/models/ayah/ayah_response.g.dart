// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayah_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AyahResponse _$AyahResponseFromJson(Map<String, dynamic> json) => AyahResponse(
  code: (json['code'] as num).toInt(),
  status: json['status'] as String,
  data: json['data'] == null
      ? null
      : AyahModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AyahResponseToJson(AyahResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };

AyahMultipleResponse _$AyahMultipleResponseFromJson(
  Map<String, dynamic> json,
) => AyahMultipleResponse(
  code: (json['code'] as num).toInt(),
  status: json['status'] as String,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AyahMultipleResponseToJson(
  AyahMultipleResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'data': instance.data,
};
