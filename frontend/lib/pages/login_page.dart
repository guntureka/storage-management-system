import 'package:flutter/material.dart';
import 'package:frontend/components/redirect_component.dart';
import 'package:frontend/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      LoginController(),
    );
    return Scaffold(
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "LOGIN",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: _formUI(context),
              ),
              const SizedBox(
                height: 20,
              ),
              RedirectComponent(
                text: "Dont have an account? ",
                redirectText: "Register",
                onTap: () {
                  Get.offNamed('/register');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _formUI(BuildContext context) {
    return Obx(
      () => Form(
        key: controller.loginKey,
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.login,
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
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
