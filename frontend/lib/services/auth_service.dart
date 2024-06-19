import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/utils/dio_helper.dart';

class AuthService {
  Future<dynamic> login(String username, String password) async {
    try {
      final User user = User(
        username: username,
        password: password,
      );
      final jsonData = user.toJson();
      final response = await DioHelper.dio.post('/auth/login', data: jsonData);

      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> register(
      String username, String password, String? image) async {
    try {
      final User user = User(
        username: username,
        password: password,
        image: image,
      );
      final jsonData = user.toJson();
      final Response response = await DioHelper.dio.post(
        '/auth/register',
        data: jsonData,
      );

      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }
}
