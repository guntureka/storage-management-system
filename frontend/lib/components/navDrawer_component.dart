import 'package:flutter/material.dart';
import 'package:frontend/pages/add_product_form.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/login_page.dart';

class NavDrawerComponent extends StatelessWidget {
  const NavDrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    String name = "Guntur";
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
              'Welcome,\n$name',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
            title: const Text(
              'Add Product',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddProductForm(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: const Text(
              'Exit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              // Handle exit logic (e.g., navigate back or pop drawer)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              ); // Close the drawer by default
            },
          ),
        ],
      ),
    );
  }
}
