import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppbarController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> _getUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('');

    if (userData != null) {
      user.value = User.fromJson(
        (jsonDecode(userData)),
      );
    }
  }
}

class AppbarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppbarComponent({super.key});

  final String? image =
      'https://cdn.prod.website-files.com/62d84e447b4f9e7263d31e94/6399a4d27711a5ad2c9bf5cd_ben-sweet-2LowviVHZ-E-unsplash-1.jpeg';

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "SMS",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      // backgroundColor: Colors.blue,
      centerTitle: true,
      elevation: 0,
      // foregroundColor: Colors.white,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      actions: [
        InkWell(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.people),
          ),
        ),
      ],
    );
  }
}
