import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/page_entity.dart';
import '../edition/edition_model.dart';
import '../ayah/ayah_model.dart';

part 'page_model.g.dart';

/// Data transfer object for Page.
@JsonSerializable()
class PageModel extends Equatable {
  final int number;
  final EditionModel edition;
  final List<AyahModel> ayahs;

  const PageModel({
    required this.number,
    required this.edition,
    required this.ayahs,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) =>
      _$PageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PageModelToJson(this);

  /// Converts this model to a domain entity.
  PageEntity toEntity() {
    return PageEntity(
      number: number,
      edition: edition.toEntity(),
      ayahs: ayahs.map((a) => a.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [number, edition, ayahs];
}
