import 'package:json_annotation/json_annotation.dart';

part 'mangas_dto.g.dart';

@JsonSerializable(createToJson: false)
class MangasDto {
  final List<MangaDto>? data;
  final int offset;
  const MangasDto({this.data, this.offset = 0});

  factory MangasDto.fromJson(Map<String, dynamic> json) =>
      _$MangasDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class MangaDto {
  final String? id;
  final String? type;
  final MangaAttributesDto? attributes;
  final List<RelationshipDto>? relationships;
  // Вспомогательные геттеры
  String? get title =>
      attributes?.title?['en'] ?? attributes?.title?['ja-ro'] ?? "UNKNOWN";
  String? get description =>
      attributes?.description?['en'] ??
      attributes?.title?['ja-ro'] ??
      "UNKNOWN";
  const MangaDto({this.id, this.type, this.attributes, this.relationships});

  factory MangaDto.fromJson(Map<String, dynamic> json) =>
      _$MangaDtoFromJson(json);

  RelationshipDto? get coverImageRelationship {
    if (relationships == null) return null;
    for (var r in relationships!) {
      if (r.type == 'cover_art') return r;
    }
    return null;
  }

  String? get coverImage {
    final cover = coverImageRelationship;
    if (cover == null) return null;
    return cover.attributes?.fileName;
  }
}

@JsonSerializable(createToJson: false)
class MangaAttributesDto {
  final Map<String, dynamic>? title;
  final Map<String, dynamic>? description;

  const MangaAttributesDto({this.title, this.description});

  factory MangaAttributesDto.fromJson(Map<String, dynamic> json) =>
      _$MangaAttributesDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class RelationshipDto {
  final String? id;
  final String? type;
  final RelationshipAttributesDto? attributes;

  const RelationshipDto({this.id, this.type, required this.attributes});

  factory RelationshipDto.fromJson(Map<String, dynamic> json) =>
      _$RelationshipDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class RelationshipAttributesDto {
  final String? fileName;

  const RelationshipAttributesDto({this.fileName});

  factory RelationshipAttributesDto.fromJson(Map<String, dynamic> json) =>
      _$RelationshipAttributesDtoFromJson(json);
}
