// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranResponse _$QuranResponseFromJson(Map<String, dynamic> json) =>
    QuranResponse(
      code: (json['code'] as num).toInt(),
      status: json['status'] as String,
      data: json['data'] == null
          ? null
          : QuranModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuranResponseToJson(QuranResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };
