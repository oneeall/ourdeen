// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahListResponse _$SurahListResponseFromJson(Map<String, dynamic> json) =>
    SurahListResponse(
      code: (json['code'] as num).toInt(),
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SurahModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SurahListResponseToJson(SurahListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };
