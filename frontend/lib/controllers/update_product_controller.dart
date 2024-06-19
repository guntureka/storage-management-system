import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/models/api_response_model.dart';
import 'package:frontend/models/category_model.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/category_service.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/services/upload_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProductController extends GetxController {
  final String productId;

  UpdateProductController({required this.productId});

  GlobalKey<FormState> updateProductKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final Rx<User?> user = Rx<User?>(null);
  final RxString imagePath = "".obs;
  final RxBool imageUrl = false.obs;
  final RxBool isLoading = false.obs;
  final Rx<Category?> selectedCategory = Rx<Category?>(null);
  final RxList<Category> categories = <Category>[].obs;
  final Rx<XFile?> imageFile = Rx<XFile?>(null);
  final Rx<Product?> product = Rx<Product?>(null);

  @override
  void onInit() {
    super.onInit();
    _getUserFromStorage();
    _getCategory();
    _getProduct(productId);
  }

  Future _getProduct(String id) async {
    isLoading.value = true;

    ProductService productService = Get.put(ProductService());

    final productResponse = await productService.getById(id);

    if (productResponse == null) {
      isLoading.value = false;
      return Get.snackbar(
        "Error",
        "Something went wrong!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    ProductAddApiResponse productApiResponse =
        ProductAddApiResponse.fromJson(productResponse);

    if (productApiResponse.error != null) {
      isLoading.value = false;
      return Get.snackbar(
        "Error",
        productApiResponse.error!,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    product.value = productApiResponse.data;

    nameController.text = productApiResponse.data!.name!;
    quantityController.text = productApiResponse.data!.quantity.toString();
    selectedCategory.value = categories.firstWhere(
      (category) => category.id == productApiResponse.data!.categoryId,
    );
    if (productApiResponse.data!.image != null) {
      imageUrl.value = true;
      imagePath.value = productApiResponse.data!.image!;
    }

    isLoading.value = false;
  }

  void imageInput() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imageFile.value = image;
      imagePath.value = image.path;
      imageUrl.value = false;
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

  void handleSelectedCategory(Category category) async {
    selectedCategory.value = category;
  }

  Future handleSubmit() async {
    if (updateProductKey.currentState!.validate()) {
      isLoading.value = true;
      ProductService productService = Get.put(ProductService());
      UploadService uploadService = Get.put(UploadService());

      if (selectedCategory.value == null) {
        isLoading.value = false;

        return Get.snackbar(
          "Error",
          "Please select category!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      if (imagePath.value == "") {
        isLoading.value = false;

        return Get.snackbar(
          "Error",
          "Please select an image!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      String imageName;

      if (imageUrl.value == true) {
        imageName = imagePath.value;
      } else {
        final imageResponse = await uploadService.uploadImage(imageFile.value!);

        if (imageResponse == null) {
          isLoading.value = false;
          return Get.snackbar(
            "Error",
            "Something went wrong!",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }

        ImageApiResponse imageApiResponse =
            ImageApiResponse.fromJson(imageResponse);

        if (imageApiResponse.error != null) {
          isLoading.value = false;
          return Get.snackbar(
            "Error",
            imageApiResponse.error!,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }

        imageName = imageApiResponse.data!.filename!;
      }

      final updateProductResponse = await productService.update(
        productId,
        nameController.text,
        int.tryParse(quantityController.text),
        imageName,
        selectedCategory.value!.id,
        user.value!.username,
      );

      if (updateProductResponse == null) {
        isLoading.value = false;
        return Get.snackbar(
          "Error",
          "Something went wrong!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      ProductAddApiResponse productAddApiResponse =
          ProductAddApiResponse.fromJson(updateProductResponse);

      if (productAddApiResponse.error != null) {
        isLoading.value = false;
        return Get.snackbar(
          "Error",
          productAddApiResponse.error!,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      isLoading.value = false;

      Get.offAllNamed('/');

      return Get.snackbar(
        "Success",
        "Product updated successful",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  Future handleDeleteProduct() async {
    isLoading.value = true;

    ProductService productService = Get.put(ProductService());

    final productResponse = await productService.delete(productId);

    if (productResponse == null) {
      isLoading.value = false;
      return Get.snackbar(
        "Error",
        "Something went wrong!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    ProductAddApiResponse productAddApiResponse =
        ProductAddApiResponse.fromJson(productResponse);

    if (productAddApiResponse.error != null) {
      isLoading.value = false;
      return Get.snackbar(
        "Error",
        productAddApiResponse.error!,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    isLoading.value = false;

    Get.offAllNamed('/');

    return Get.snackbar(
      "Success",
      "Product deleted successful",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  Future<void> handleExit() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    user.value = null;

    Get.offAllNamed('/login');
  }
}
