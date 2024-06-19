import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/components/redirect_component.dart';
import 'package:frontend/controllers/register_controller.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      RegisterController(),
    );
    return Scaffold(
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        children: [
          const Center(
            child: Text(
              "REGISTER",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: _formUI(context)),
          const SizedBox(
            height: 20,
          ),
          RedirectComponent(
            text: "Already have an account? ",
            redirectText: "Login",
            onTap: () {
              Get.offNamed('/login');
            },
          )
        ],
      ),
    );
  }

  Widget _formUI(BuildContext context) {
    return Form(
      key: controller.registerKey,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: controller.usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              hintText: "Input username here...",
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Username cannot empty";
              } else if (value.contains(" ")) {
                return 'Username cannot have spaces';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: controller.passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: "Input password here...",
            ),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return "Password cannot empty";
              } else if (value.contains(" ")) {
                return 'Password cannot have spaces';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          _imageUI(context),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    controller.isLoading.value ? null : controller.register,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.black),
                  padding: WidgetStateProperty.all(
                    const EdgeInsetsDirectional.symmetric(
                      vertical: 20,
                    ),
                  ),
                ),

                clipBehavior: Clip.none, // Optional for rounded corners
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageUI(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          GestureDetector(
            onTap: () {
              controller.imageInput();
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                    offset: const Offset(1.0, 1.0),
                  )
                ],
              ),
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: controller.imagePath.value.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image),
                            Text('No Image Selected'),
                          ],
                        ),
                      )
                    : Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Image.file(
                            File(
                              controller.imagePath.value,
                            ),
                            fit: BoxFit.cover,
                          ),
                          if (controller.imagePath.value.isNotEmpty)
                            Positioned(
                              bottom: 10.0,
                              right: 10.0,
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: ElevatedButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : () {
                                          controller.imageDelete();
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
