import 'package:dio/dio.dart';
import 'package:flutter_test_app/data/dtos/mangas_dto.dart';
import 'package:flutter_test_app/data/mappers/MangaDtoToModelMapper.dart';
import 'package:flutter_test_app/data/repositories/api_interface.dart';
import 'package:flutter_test_app/domain/models/card.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MangaRepository extends ApiInterface {
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));
  static const String _baseUrl = 'https://api.mangadex.org';

  @override
  Future<List<CardData>?> loadData({String? query}) async {
    try {
      var url =
          '$_baseUrl/manga?limit=10'
          '&includedTagsMode=AND'
          '&excludedTagsMode=OR'
          '&contentRating%5B%5D=safe'
          '&order%5BlatestUploadedChapter%5D=desc'
          '&includes%5B%5D=cover_art';

      if (query != null && query.isNotEmpty) {
        url += '&title=$query';
      }

      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
        url,
      );
      final MangasDto dto = MangasDto.fromJson(
        response.data as Map<String, dynamic>,
      );
      final List<CardData>? cards = dto.data?.map((e) => e.toDomain()).toList();
      return cards;
    } on Exception catch (e) {
      return null;
    }
  }
}
