import 'package:flutter/material.dart';
import 'package:frontend/models/api_response_model.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/upload_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isUsernameValid = false.obs;
  final RxBool isPasswordValid = false.obs;
  final RxString imagePath = "".obs;
  final RxBool isLoading = false.obs;
  Rx<XFile?> imageFile = Rx<XFile?>(null);

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

  Future<dynamic> register() async {
    if (registerKey.currentState!.validate()) {
      AuthService authService = Get.put(AuthService());
      UploadService uploadService = Get.put(UploadService());
      isLoading.value = true;
      String? filename;

      if (imageFile.value != null) {
        final imageResponse = await uploadService.uploadImage(
          imageFile.value!,
        );

        if (imageResponse == null) {
          isLoading.value = false;
          return Get.snackbar(
            "Error",
            "Something went wrong!",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }

        ImageApiResponse imageApiResponse = ImageApiResponse.fromJson(
          imageResponse,
        );

        if (imageApiResponse.error != null) {
          isLoading.value = false;
          return Get.snackbar(
            "Error",
            imageApiResponse.error!,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }

        filename = imageApiResponse.data!.filename;
      }
      final registerResponse = await authService.register(
        usernameController.text,
        passwordController.text,
        filename!,
      );

      if (registerResponse == null) {
        isLoading.value = false;
        return Get.snackbar(
          "Error",
          "Something went wrong!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      RegisterApiResponse registerApiResponse = RegisterApiResponse.fromJson(
        registerResponse,
      );

      if (registerApiResponse.error != null) {
        isLoading.value = false;
        return Get.snackbar(
          "Error",
          registerApiResponse.error!,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      isLoading.value = false;

      return Get.snackbar(
        "Success",
        "Registered successful",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
