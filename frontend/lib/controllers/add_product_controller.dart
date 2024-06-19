import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/api_response_model.dart';
import 'package:frontend/models/category_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/category_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductController extends GetxController {
  GlobalKey<FormState> addProductKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  RxBool isLoading = false.obs;
  final Rx<User?> user = Rx<User?>(null);
  Rx<Category?> category = Rx<Category?>(null);
  RxList<Category> categories = <Category>[].obs;
  Rx<XFile?> imageFile = Rx<XFile?>(null);
  final RxString imagePath = "".obs;

  @override
  void onInit() {
    super.onInit();
    _getUserFromStorage();
    _getCategory();
  }

  void imageInput() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imageFile.value = image;
      imagePath.value = image.path;
    }
  }

  void imageDelete() async {
    imagePath.value = "";
  }

  Future _getCategory() async {
    CategoryService categoryService = Get.put(CategoryService());

    final categoryResponse = await categoryService.get();

    if (categoryResponse == null) {
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
      return Get.snackbar(
        "Error",
        categoryApiResponse.error!,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    categories.value = categoryApiResponse.data!;
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

  void handleSelectedCategory(Category? selectedCategory) async {
    category.value = selectedCategory;
  }

  Future handleSubmit() async {
    if (addProductKey.currentState!.validate()) {
      if (category.value == null) {
        isLoading.value = false;
        return Get.snackbar(
          "Error",
          "Please select category!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      
      
    }
  }
}
