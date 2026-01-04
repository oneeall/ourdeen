// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juz_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JuzResponse _$JuzResponseFromJson(Map<String, dynamic> json) => JuzResponse(
  code: (json['code'] as num).toInt(),
  status: json['status'] as String,
  data: json['data'] == null
      ? null
      : JuzModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$JuzResponseToJson(JuzResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };
