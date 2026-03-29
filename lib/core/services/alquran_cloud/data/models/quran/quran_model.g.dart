// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranModel _$QuranModelFromJson(Map<String, dynamic> json) => QuranModel(
  edition: EditionModel.fromJson(json['edition'] as Map<String, dynamic>),
  surahs: (json['surahs'] as List<dynamic>?)
      ?.map((e) => SurahModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  ayahs: (json['ayahs'] as List<dynamic>?)
      ?.map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QuranModelToJson(QuranModel instance) =>
    <String, dynamic>{
      'edition': instance.edition,
      'surahs': instance.surahs,
      'ayahs': instance.ayahs,
    };
