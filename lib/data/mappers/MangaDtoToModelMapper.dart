import 'package:flutter_test_app/data/dtos/mangas_dto.dart';
import 'package:flutter_test_app/domain/models/card.dart';

const _imagePlaceholder =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png";

extension MangaDtoToModelMapper on MangaDto {
  CardData toDomain() {
    return CardData(
      title ?? "UNKNOWN",
      imageUrl: coverImage == null
          ? _imagePlaceholder
          : "https://uploads.mangadex.org/covers/$id/$coverImage",
      description: description ?? "UNKNOWN",
      id: id,
    );
  }
}
