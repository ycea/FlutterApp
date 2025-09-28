import 'package:flutter_test_app/data/dtos/mangas_dto.dart';
import 'package:flutter_test_app/data/mappers/MangaDtoToModelMapper.dart';
import 'package:flutter_test_app/domain/models/home.dart';

extension MangasDtoToModel on MangasDto {
  HomeData toDomain() =>
      HomeData(data: data?.map((e) => e.toDomain()).toList(), offset: offset);
}
