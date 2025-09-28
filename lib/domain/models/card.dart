import 'package:flutter/material.dart';

typedef OnLikeCallBack = void Function(String? id, String title, bool isLiked)?;

class CardData {
  final String name;
  final IconData icon;
  final String? imageUrl;
  final String? description;
  final String? id;
  final OnLikeCallBack? onLike;
  const CardData(
    this.name, {
    this.imageUrl,
    this.onLike,
    this.description,
    this.icon = Icons.ac_unit_outlined,
    this.id,
  });
}
