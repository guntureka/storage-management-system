import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/api_response_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isUsernameValid = false.obs;
  final RxBool isPasswordValid = false.obs;
  final RxBool isLoading = false.obs;
  // final RxString user = "".obs;
  final Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadUserFromStorage();
  }

  Future<dynamic> login() async {
    if (loginKey.currentState!.validate()) {
      AuthService authService = Get.put(AuthService());
      isLoading.value = true;

      final loginResponse = await authService.login(
        usernameController.text,
        passwordController.text,
      );

      if (loginResponse == null) {
        isLoading.value = false;
        return Get.snackbar(
          "Error",
          "Something went wrong!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      LoginApiResponse loginApiResponse = LoginApiResponse.fromJson(
        loginResponse,
      );

      if (loginApiResponse.error != null) {
        isLoading.value = false;
        return Get.snackbar(
          "Error",
          loginApiResponse.error!,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      User userModel = User(
        id: loginApiResponse.data!.id,
        username: loginApiResponse.data!.username,
        image: loginApiResponse.data!.image,
      );

      user.value = userModel;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(user.toJson()));

      isLoading.value = false;

      Get.snackbar(
        "Success",
        "Registered successful",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      return Get.offNamed('/');
    }
  }

  Future<void> _loadUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      user.value = User.fromJson(jsonDecode(userData));
      Get.offNamed('/');
    }
  }
}
