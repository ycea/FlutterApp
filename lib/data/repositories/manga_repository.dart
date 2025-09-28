import 'package:dio/dio.dart';
import 'package:flutter_test_app/data/dtos/mangas_dto.dart';
import 'package:flutter_test_app/data/mappers/MangaDtoToModelMapper.dart';
import 'package:flutter_test_app/data/mappers/MangasDtoToModel.dart';
import 'package:flutter_test_app/data/repositories/api_interface.dart';
import 'package:flutter_test_app/domain/models/card.dart';
import 'package:flutter_test_app/domain/models/home.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MangaRepository extends ApiInterface {
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));
  static const String _baseUrl = 'https://api.mangadex.org';

  @override
  Future<HomeData?> loadData({
    OnErrorCallback? onError,
    String? query,
    int page = 0,
    int limit = 5,
  }) async {
    try {
      final queryParams = {
        'limit': limit,
        'offset': page * limit,
        'includedTagsMode': 'AND',
        'excludedTagsMode': 'OR',
        'contentRating[]': ['safe'],
        "order[createdAt]": "desc",
        'includes[]': ['cover_art'],
        if (query != null && query.isNotEmpty) 'title': query,
      };

      var url = '$_baseUrl/manga';
      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
        url,
        queryParameters: queryParams,
      );
      final MangasDto dto = MangasDto.fromJson(
        response.data as Map<String, dynamic>,
      );
      final homeData = dto.toDomain();
      return homeData;
    } on DioException catch (e) {
      onError?.call(e.error?.toString());
      return null;
    }
  }
}
