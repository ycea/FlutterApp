// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mangas_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangasDto _$MangasDtoFromJson(Map<String, dynamic> json) => MangasDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MangaDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      offset: (json['offset'] as num?)?.toInt() ?? 0,
    );

MangaDto _$MangaDtoFromJson(Map<String, dynamic> json) => MangaDto(
      id: json['id'] as String?,
      type: json['type'] as String?,
      attributes: json['attributes'] == null
          ? null
          : MangaAttributesDto.fromJson(
              json['attributes'] as Map<String, dynamic>),
      relationships: (json['relationships'] as List<dynamic>?)
          ?.map((e) => RelationshipDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

MangaAttributesDto _$MangaAttributesDtoFromJson(Map<String, dynamic> json) =>
    MangaAttributesDto(
      title: json['title'] as Map<String, dynamic>?,
      description: json['description'] as Map<String, dynamic>?,
    );

RelationshipDto _$RelationshipDtoFromJson(Map<String, dynamic> json) =>
    RelationshipDto(
      id: json['id'] as String?,
      type: json['type'] as String?,
      attributes: json['attributes'] == null
          ? null
          : RelationshipAttributesDto.fromJson(
              json['attributes'] as Map<String, dynamic>),
    );

RelationshipAttributesDto _$RelationshipAttributesDtoFromJson(
        Map<String, dynamic> json) =>
    RelationshipAttributesDto(
      fileName: json['fileName'] as String?,
    );
