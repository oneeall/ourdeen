// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahDetailResponse _$SurahDetailResponseFromJson(Map<String, dynamic> json) =>
    SurahDetailResponse(
      code: (json['code'] as num).toInt(),
      status: json['status'] as String,
      data: json['data'] == null
          ? null
          : SurahModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SurahDetailResponseToJson(
  SurahDetailResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'data': instance.data,
};
