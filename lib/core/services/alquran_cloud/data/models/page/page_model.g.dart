// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageModel _$PageModelFromJson(Map<String, dynamic> json) => PageModel(
  number: (json['number'] as num).toInt(),
  edition: EditionModel.fromJson(json['edition'] as Map<String, dynamic>),
  ayahs: (json['ayahs'] as List<dynamic>)
      .map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PageModelToJson(PageModel instance) => <String, dynamic>{
  'number': instance.number,
  'edition': instance.edition,
  'ayahs': instance.ayahs,
};
