import 'package:flutter_test_app/domain/models/card.dart';

class HomeData {
  final List<CardData>? data;
  final int offset;
  HomeData({this.data, this.offset = 0});
}
