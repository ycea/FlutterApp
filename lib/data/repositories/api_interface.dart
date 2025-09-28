import 'package:flutter_test_app/domain/models/home.dart';

abstract class ApiInterface {
  Future<HomeData?> loadData({OnErrorCallback? onError});
}

typedef OnErrorCallback = void Function(String? error);
