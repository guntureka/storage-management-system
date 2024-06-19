import 'package:flutter/material.dart';
import 'package:frontend/pages/add_product_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:frontend/pages/update_product_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await _userCheck();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Storage Management",
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.quicksandTextTheme(),
      ),
      initialRoute: '/login',
      // home: const HomePage(),
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/register',
          page: () => const RegisterPage(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
        ),
        GetPage(
          name: '/add-product',
          page: () => const AddProductPage(),
        ),
        GetPage(
          name: '/update-product/:id',
          page: () => const UpdateProductPage(),
        ),
      ],
    );
  }
}

Future<void> _userCheck() async {
  final prefs = await SharedPreferences.getInstance();
  final userData = prefs.getString('user');

  if (userData != null) {
    Get.offAllNamed("/");
  } else {
    Get.offAllNamed('/login');
  }
}
