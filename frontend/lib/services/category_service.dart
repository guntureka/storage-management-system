import 'dart:developer';

import 'package:frontend/utils/dio_helper.dart';

class CategoryService {
  Future<dynamic> get() async {
    try {
      final response = await DioHelper.dio.get('/categories');

      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }
}
