// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hizb_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HizbModel _$HizbModelFromJson(Map<String, dynamic> json) => HizbModel(
  number: (json['number'] as num).toInt(),
  edition: EditionModel.fromJson(json['edition'] as Map<String, dynamic>),
  ayahs: (json['ayahs'] as List<dynamic>)
      .map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$HizbModelToJson(HizbModel instance) => <String, dynamic>{
  'number': instance.number,
  'edition': instance.edition,
  'ayahs': instance.ayahs,
};
