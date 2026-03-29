// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JuzModel _$JuzModelFromJson(Map<String, dynamic> json) => JuzModel(
  number: (json['number'] as num).toInt(),
  edition: EditionModel.fromJson(json['edition'] as Map<String, dynamic>),
  ayahs: (json['ayahs'] as List<dynamic>)
      .map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JuzModelToJson(JuzModel instance) => <String, dynamic>{
  'number': instance.number,
  'edition': instance.edition,
  'ayahs': instance.ayahs,
};
