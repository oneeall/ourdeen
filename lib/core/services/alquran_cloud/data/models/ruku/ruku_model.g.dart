// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruku_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RukuModel _$RukuModelFromJson(Map<String, dynamic> json) => RukuModel(
  number: (json['number'] as num).toInt(),
  edition: EditionModel.fromJson(json['edition'] as Map<String, dynamic>),
  ayahs: (json['ayahs'] as List<dynamic>)
      .map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RukuModelToJson(RukuModel instance) => <String, dynamic>{
  'number': instance.number,
  'edition': instance.edition,
  'ayahs': instance.ayahs,
};
