// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hizb_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HizbResponse _$HizbResponseFromJson(Map<String, dynamic> json) => HizbResponse(
  code: (json['code'] as num).toInt(),
  status: json['status'] as String,
  data: json['data'] == null
      ? null
      : HizbModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HizbResponseToJson(HizbResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };
