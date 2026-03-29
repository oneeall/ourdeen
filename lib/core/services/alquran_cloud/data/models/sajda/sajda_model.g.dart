// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sajda_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SajdaModel _$SajdaModelFromJson(Map<String, dynamic> json) => SajdaModel(
  edition: EditionModel.fromJson(json['edition'] as Map<String, dynamic>),
  recommended: (json['recommended'] as List<dynamic>)
      .map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  obligatory: (json['obligatory'] as List<dynamic>)
      .map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SajdaModelToJson(SajdaModel instance) =>
    <String, dynamic>{
      'edition': instance.edition,
      'recommended': instance.recommended,
      'obligatory': instance.obligatory,
    };
