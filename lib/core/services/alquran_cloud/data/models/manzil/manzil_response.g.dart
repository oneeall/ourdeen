// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manzil_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManzilResponse _$ManzilResponseFromJson(Map<String, dynamic> json) =>
    ManzilResponse(
      code: (json['code'] as num).toInt(),
      status: json['status'] as String,
      data: json['data'] == null
          ? null
          : ManzilModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ManzilResponseToJson(ManzilResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };
