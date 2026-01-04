// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruku_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RukuResponse _$RukuResponseFromJson(Map<String, dynamic> json) => RukuResponse(
  code: (json['code'] as num).toInt(),
  status: json['status'] as String,
  data: json['data'] == null
      ? null
      : RukuModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RukuResponseToJson(RukuResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };
