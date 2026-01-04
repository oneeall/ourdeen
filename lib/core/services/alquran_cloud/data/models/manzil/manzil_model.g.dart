// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manzil_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManzilModel _$ManzilModelFromJson(Map<String, dynamic> json) => ManzilModel(
  number: (json['number'] as num).toInt(),
  edition: EditionModel.fromJson(json['edition'] as Map<String, dynamic>),
  ayahs: (json['ayahs'] as List<dynamic>)
      .map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ManzilModelToJson(ManzilModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'edition': instance.edition,
      'ayahs': instance.ayahs,
    };
