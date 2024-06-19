import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/api_response_model.dart';
import 'package:frontend/models/category_model.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/category_service.dart';
import 'package:frontend/services/product_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Category> categories = <Category>[].obs;
  RxList<Product> products = <Product>[].obs;
  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    _getUserFromStorage();
    _getCategory();
    _getProduct();
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

    final List<Category> categoriesData = [
      Category(id: "all", name: "All"),
      ...categoryApiResponse.data!
    ];

    categories.value = categoriesData;
    isLoading.value = false;
    update();
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

    Get.offNamed('/login');
  }

  Future _getProduct() async {
    isLoading.value = true;

    ProductService productService = Get.put(ProductService());

    final productResponse = await productService.getAll();

    if (productResponse == null) {
      isLoading.value = false;
      return Get.snackbar(
        "Error",
        "Something went wrong!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    ProductApiResponse productApiResponse =
        ProductApiResponse.fromJson(productResponse);

    if (productApiResponse.error != null) {
      isLoading.value = false;
      return Get.snackbar(
        "Error",
        productApiResponse.error!,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    products.value = productApiResponse.data!;

    isLoading.value = false;
  }

  Future handleSelectedCategories(String id) async {
    isLoading.value = true;

    ProductService productService = Get.put(ProductService());

    final dynamic productResponse;

    if (id == "all") {
      productResponse = await productService.getAll();
    } else {
      productResponse = await productService.getByCategoryId(id);
    }

    if (productResponse == null) {
      isLoading.value = false;
      return Get.snackbar(
        "Error",
        "Something went wrong!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    ProductApiResponse productApiResponse =
        ProductApiResponse.fromJson(productResponse);

    if (productApiResponse.error != null) {
      isLoading.value = false;
      return Get.snackbar(
        "Error",
        productApiResponse.error!,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    products.value = productApiResponse.data!;

    isLoading.value = false;
  }

  void handleUpdatePage(String id) {
    Get.offAndToNamed('/update-product/$id');
  }
}
