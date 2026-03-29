// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_with_ayahs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahWithAyahsModel _$SurahWithAyahsModelFromJson(Map<String, dynamic> json) =>
    SurahWithAyahsModel(
      number: (json['number'] as num).toInt(),
      name: json['name'] as String,
      englishName: json['englishName'] as String,
      englishNameTranslation: json['englishNameTranslation'] as String,
      revelationType: json['revelationType'] as String,
      numberOfAyahs: (json['numberOfAyahs'] as num).toInt(),
      ayahs: (json['ayahs'] as List<dynamic>)
          .map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SurahWithAyahsModelToJson(
  SurahWithAyahsModel instance,
) => <String, dynamic>{
  'number': instance.number,
  'name': instance.name,
  'englishName': instance.englishName,
  'englishNameTranslation': instance.englishNameTranslation,
  'revelationType': instance.revelationType,
  'numberOfAyahs': instance.numberOfAyahs,
  'ayahs': instance.ayahs,
};
