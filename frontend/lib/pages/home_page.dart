// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:frontend/components/appbar_component.dart';
// import 'package:frontend/components/navDrawer_component.dart';
// import 'package:frontend/models/category_model.dart';
// import 'package:frontend/models/product_model.dart';
// import 'package:google_fonts/google_fonts.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final String name = "Guntur";
//   String? image =
//       'https://cdn.prod.website-files.com/62d84e447b4f9e7263d31e94/6399a4d27711a5ad2c9bf5cd_ben-sweet-2LowviVHZ-E-unsplash-1.jpeg';

//   final List<Category> _categories = [
//     Category(id: "1", name: "Elektronik"),
//     Category(id: "2", name: "Rumah Tangga"),
//     Category(id: "3", name: "Kendaraan"),
//     Category(id: "4", name: "Rumah"),
//     Category(id: "4", name: "Rumah"),
//     Category(id: "4", name: "Rumah"),
//     Category(id: "4", name: "Rumah"),
//     Category(id: "4", name: "Rumah"),
//   ];

//   final List<Product> _products = [
//     Product(
//         id: "1",
//         name: "Elektronik",
//         quantity: 30,
//         image:
//             'https://images.tokopedia.net/img/cache/900/VqbcmM/2023/6/27/84a5bf25-f1f5-4740-8703-0930284a2096.jpg'),
//     Product(
//         id: "1",
//         name: "Elektronik",
//         quantity: 30,
//         image:
//             'https://images.tokopedia.net/img/cache/900/VqbcmM/2023/6/27/84a5bf25-f1f5-4740-8703-0930284a2096.jpg'),
//     Product(
//         id: "1",
//         name: "Elektronik Elektronik Elektronik Elektronik",
//         quantity: 30,
//         image:
//             'https://cdn.prod.website-files.com/62d84e447b4f9e7263d31e94/6399a4d27711a5ad2c9bf5cd_ben-sweet-2LowviVHZ-E-unsplash-1.jpeg'),
//     Product(
//         id: "1",
//         name: "Elektronik",
//         quantity: 30,
//         image:
//             'https://cdn.prod.website-files.com/62d84e447b4f9e7263d31e94/6399a4d27711a5ad2c9bf5cd_ben-sweet-2LowviVHZ-E-unsplash-1.jpeg'),
//     Product(
//         id: "1",
//         name: "Elektronik",
//         quantity: 30,
//         image:
//             'https://cdn.prod.website-files.com/62d84e447b4f9e7263d31e94/6399a4d27711a5ad2c9bf5cd_ben-sweet-2LowviVHZ-E-unsplash-1.jpeg'),
//   ];

//   void _handleCategory() {
//     log("Category Click");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppbarComponent(),
//       drawer: const NavDrawerComponent(),
//       body: SafeArea(
//         child: ListView(
//           children: [
//             // welcome message
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Container(
//                 alignment: Alignment.centerLeft,
//                 // color: Colors.blue,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Welcome,",
//                       textAlign: TextAlign.start,
//                       style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 18,
//                           fontFamily: GoogleFonts.poppins().fontFamily),
//                     ),
//                     Text(
//                       "$name !",
//                       textAlign: TextAlign.start,
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 28,
//                           fontFamily: GoogleFonts.poppins().fontFamily),
//                     )
//                   ],
//                 ),
//               ),
//             ),

//             // Divider
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.0),
//               child: Divider(
//                 color: Colors.black,
//                 thickness: 1,
//               ),
//             ),

//             const SizedBox(
//               height: 20,
//             ),

//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Categories",
//                   textAlign: TextAlign.start,
//                   style: TextStyle(
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(
//               height: 10,
//             ),

//             SizedBox(
//               height: 50,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _categories.length,
//                 itemBuilder: (context, index) => Row(
//                   children: [
//                     if (index == 0)
//                       const SizedBox(
//                         width: 20,
//                       ),
//                     ElevatedButton(
//                       onPressed: () {
//                         _handleCategory();
//                       },
//                       style: ButtonStyle(
//                         backgroundColor: WidgetStateProperty.all(Colors.black),
//                         elevation: WidgetStateProperty.all(0),
//                         shape: WidgetStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                       child: Text(
//                         _categories[index].name,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     if (index != _categories.length - 1)
//                       const SizedBox(
//                         width: 10.0,
//                       ),
//                     if (index == _categories.length - 1)
//                       const SizedBox(
//                         width: 20.0,
//                       ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(
//               height: 10,
//             ),

//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Products",
//                   textAlign: TextAlign.start,
//                   style: TextStyle(
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(
//               height: 10,
//             ),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: GridView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: _products.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 0.5,
//                 ),
//                 itemBuilder: (context, index) {
//                   final Product product = _products[index];
//                   return Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(
//                         color: Colors.white,
//                         width: 2,
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           blurRadius: 10.0,
//                           spreadRadius: 2.0,
//                           offset: const Offset(1.0, 1.0),
//                         )
//                       ],
//                     ),

//                     // padding: const EdgeInsets.symmetric(
//                     //     vertical: 10, horizontal: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: double.infinity,
//                           height: 150,
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(8),
//                               topRight: Radius.circular(8),
//                               bottomLeft: Radius.circular(8),
//                               bottomRight: Radius.circular(8),
//                             ),
//                             child: Image.network(
//                               product.image,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 4,
//                         ),
//                         Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10.0, vertical: 5.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   product.name,
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.black,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 const SizedBox(
//                                   height: 4,
//                                 ),
//                                 Text(
//                                   "${product.quantity.toString()} pcs",
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:frontend/controllers/home_controller.dart';
import 'package:frontend/utils/dio_helper.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(
      HomeController(),
    );
    return Scaffold(
      appBar: _appBarUI(context),
      drawer: _drawerUI(context),
      body: _buildUI(context),
    );
  }

  PreferredSizeWidget _appBarUI(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
          child: Obx(
            () => CircleAvatar(
              backgroundImage: controller.user.value != null
                  ? NetworkImage(
                      "$BASE_URL/api/uploads/${controller.user.value?.image}")
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _drawerUI(BuildContext context) {
    return Obx(
      () => Drawer(
        backgroundColor: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Welcome,\n${controller.user.value?.username}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
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
              onTap: () {},
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
                Get.toNamed('/add-product');
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
                controller.handleExit();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          _headerUI(context),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _categoryUI(context),
          _productUI(context),
        ],
      ),
    );
  }

  Widget _headerUI(BuildContext context) {
    return Obx(
      () => Container(
        alignment: Alignment.centerLeft,
        // color: Colors.blue,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome,",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            if (controller.user.value != null) // Check if user is not null
              Text(
                "${controller.user.value!.username} !",
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _categoryUI(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Categories",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) => Row(
                  children: [
                    if (index == 0)
                      const SizedBox(
                        width: 20,
                      ),
                    ElevatedButton(
                      onPressed: () {
                        // _handleCategory();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.black),
                        elevation: WidgetStateProperty.all(0),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      child: Text(
                        controller.categories[index].name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    if (index != controller.categories.length - 1)
                      const SizedBox(
                        width: 10.0,
                      ),
                    if (index == controller.categories.length - 1)
                      const SizedBox(
                        width: 20.0,
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

  Widget _productUI(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Products",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Obx(() => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                itemCount: controller.categories.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: controller.user.value != null
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(14),
                                      topRight: Radius.circular(14),
                                    ),
                                    child: Image.network(
                                      "$BASE_URL/api/uploads/${controller.user.value?.image}",
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
        )
      ],
    );
  }
}
