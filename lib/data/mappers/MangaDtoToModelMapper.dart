import 'package:flutter_test_app/data/dtos/mangas_dto.dart';
import 'package:flutter_test_app/domain/models/card.dart';
import 'package:flutter_test_app/presentation/details_page/MangaDetails.dart';

extension MangaDtoToModelMapper on MangaDto {
  CardData toDomain() {
    return CardData(
      title ?? "UNKNOWN",
      imageUrl: "https://uploads.mangadex.org/covers/$id/$coverImage",
      description: description ?? "UNKNOWN",
    );
  }
}
