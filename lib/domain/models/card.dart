import 'package:flutter/material.dart';

typedef OnLikeCallBack =
    void Function(BuildContext context, String title, bool isLiked)?;

class CardData {
  final String name;
  final IconData icon; // for the future update
  final String? imageUrl;
  final String? description;
  final OnLikeCallBack? onLike;
  const CardData(
    this.name, {
    this.imageUrl,
    this.onLike,
    this.description,
    this.icon = Icons.ac_unit_outlined,
  });
}
