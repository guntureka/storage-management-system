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
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
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
              onTap: () {
                Get.offNamed('/');
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
                Get.offAndToNamed('/add-product');
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
                        controller.handleSelectedCategories(
                            controller.categories[index].id);
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
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(
            () => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 250,
              ),
              shrinkWrap: true,
              itemCount: controller.products.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller
                          .handleUpdatePage(controller.products[index].id!);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            offset: const Offset(1.0, 1.0),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 10.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(0.0, 1.0),
                                )
                              ],
                            ),
                            child: controller.products[index].image != null
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(14),
                                      topRight: Radius.circular(14),
                                    ),
                                    child: Image.network(
                                      "$BASE_URL/api/uploads/${controller.products[index].image}",
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    controller.products[index].name!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    controller.products[index].createdBy!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "${controller.products[index].quantity.toString()} PCS",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
