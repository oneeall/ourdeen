import 'package:ourdeen/core/services/alquran_cloud/domain/entities/surah_entity.dart';
import 'package:ourdeen/core/services/network/api_response.dart';
import '../entities/surah_list_item.dart';

/// Use case for getting the list of all surahs.
class GetSurahsListUseCase {
  final Future<ApiResponse<List<SurahEntity>>> Function() _getSurahs;

  GetSurahsListUseCase(this._getSurahs);

  /// Returns a list of surah list items or throws an exception if failed.
  Future<List<SurahListItem>> call() async {
    final response = await _getSurahs();

    if (response.success && response.data != null) {
      return response.data!.map((surah) {
        return SurahListItem(
          number: surah.number,
          name: surah.name,
          englishName: surah.englishName,
          englishNameTranslation: surah.englishNameTranslation,
          revelationType: surah.revelationType,
          numberOfAyahs: surah.numberOfAyahs,
        );
      }).toList();
    }

    throw Exception(response.error ?? 'Failed to load surahs');
  }
}