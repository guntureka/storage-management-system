import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/controllers/add_product_controller.dart';
import 'package:frontend/models/category_model.dart';
import 'package:get/get.dart';

class AddProduct extends GetView<AddProductController> {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      AddProductController(),
    );
    return Scaffold(
      body: _bodyUI(context),
    );
  }

  Widget _bodyUI(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Text(
              "Product",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _formUI(context),
          ),
        ],
      ),
    );
  }

  Widget _formUI(BuildContext context) {
    return Form(
      key: controller.addProductKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.nameController,
            decoration: const InputDecoration(
              labelText: 'Product name',
              hintText: "Input product name here...",
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Product name cannot empty";
              }

              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: controller.quantityController,
            decoration: const InputDecoration(
              labelText: 'Quantity',
              hintText: "Input quantity here...",
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value!.isEmpty) {
                return "Quantity cannot empty";
              }

              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          FormField(
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                // alignment: Alignment.center,
                child: Obx(
                  () => DropdownButton<Category>(
                    alignment: Alignment.centerRight,
                    hint: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select Category",
                        textAlign: TextAlign.start,
                      ),
                    ),
                    isExpanded: true,
                    // elevation: 0,
                    dropdownColor: Colors.white,
                    value: controller.category.value,

                    items: controller.categories
                        .map((category) => DropdownMenuItem<Category>(
                              value: category,
                              child: Text(category.name),
                            ))
                        .toList(),
                    onChanged: (Category? selectedCategory) {
                      controller.handleSelectedCategory(selectedCategory);
                    },
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          _imageUI(context),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  controller.isLoading.value ? null : controller.handleSubmit,
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
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
          const SizedBox(
            height: 20,
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
