import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/api_response_model.dart';
import 'package:frontend/models/category_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/category_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Category> categories = <Category>[].obs;
  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    _getUserFromStorage();
    _getCategory();
  }

  Future _getCategory() async {
    isLoading.value = true;
    CategoryService categoryService = Get.put(CategoryService());

    final categoryResponse = await categoryService.get();

    if (categoryResponse == null) {
      isLoading.value = false;
      return Get.snackbar(
        "Error",
        "Something went wrong!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    CategoryApiResponse categoryApiResponse = CategoryApiResponse.fromJson(
      categoryResponse,
    );

    if (categoryApiResponse.error != null) {
      isLoading.value = false;
      return Get.snackbar(
        "Error",
        categoryApiResponse.error!,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    categories.value = categoryApiResponse.data!;
    isLoading.value = false;
  }

  Future<void> _getUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');

    if (userData != null) {
      user.value = User.fromJson(
        (jsonDecode(userData)),
      );
    } else {
      Get.offNamed('/login');
    }
  }

  Future<void> handleExit() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    user.value = null;

    Get.offAllNamed('/login');
  }

  void handleHome() async {
    Get.offAllNamed('/');
  }
}
