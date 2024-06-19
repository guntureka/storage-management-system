import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/components/appbar_component.dart';
import 'package:frontend/components/navDrawer_component.dart';
import 'package:frontend/models/category_model.dart';
import "package:image_picker/image_picker.dart";

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  String? filePath;
  String? _errorMessage;
  Category? _selectedCategory;

  final List<Category> _categories = [
    Category(id: "1", name: "Elektronik"),
    Category(id: "2", name: "Rumah Tangga"),
    Category(id: "3", name: "Kendaraan"),
    Category(id: "4", name: "Rumah"),
    Category(id: "4", name: "Rumah"),
    Category(id: "4", name: "Rumah"),
    Category(id: "4", name: "Rumah"),
    Category(id: "4", name: "Rumah"),
    Category(id: "4", name: "Rumah"),
    Category(id: "4", name: "Rumah"),
    Category(id: "4", name: "Rumah"),
    Category(id: "4", name: "Rumah"),
    Category(id: "4", name: "Rumah"),
    Category(id: "4", name: "Rumah"),
    Category(id: "4", name: "Rumah"),
  ];

  final TextEditingController _nameField = TextEditingController();
  final TextEditingController _quantityField = TextEditingController();

  void _handleInputImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(
        () {
          filePath = pickedFile.path;
        },
      );
    }
  }

  void _handleDeleteImage() async {
    setState(() {
      filePath = null;
    });
  }

  Future _handleFormInput() async {
    setState(() {
      _errorMessage = null;
    });
    if (_nameField.text == "" ||
        _quantityField.text == "" ||
        _selectedCategory == null) {
      return setState(() {
        _errorMessage = "Please fill name/quantity/category field";
      });
    }

    if (filePath == null) {
      return setState(() {
        _errorMessage = "Please input an image";
      });
    }
    log(_nameField.text);
    log(_quantityField.text);
    if (filePath != null) {
      log(filePath!);
    }
    log(_selectedCategory!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarComponent(),
      drawer: const NavDrawerComponent(),
      body: ListView(
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
          _errorMessage != null
              ? Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.red,
                  ),
                  width: double.infinity,
                  // alignment: Alignment.centele,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox(
                  height: 0,
                ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              child: Column(
                children: [
                  FormField(
                    builder: (context) {
                      return TextFormField(
                        controller: _nameField,
                        decoration: const InputDecoration(
                          hintText: "Enter product name",
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormField(
                    builder: (context) {
                      return TextFormField(
                        controller: _quantityField,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Enter product quantity",
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      );
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
                        child: DropdownButton<Category>(
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
                          value: _selectedCategory,

                          items: _categories
                              .map((category) => DropdownMenuItem<Category>(
                                    value: category,
                                    child: Text(category.name),
                                  ))
                              .toList(),
                          onChanged: (Category? selectedCategory) {
                            setState(() {
                              _selectedCategory = selectedCategory;
                            });
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  filePath != null
                      ? Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _handleInputImage();
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
                                  child: Image.file(
                                    File(filePath!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                _handleDeleteImage();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.red,
                                ),
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20,
                                ),
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: () {
                            _handleInputImage();
                          },
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                  offset: const Offset(1.0, 1.0),
                                )
                              ],
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Input image",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _handleFormInput();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                      ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: const Text(
                        "Add Product",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
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
}
