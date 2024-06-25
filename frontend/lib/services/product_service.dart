import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/utils/dio_helper.dart';

class ProductService {
  Future<dynamic> create(String? name, int? quantity, String? image,
      String? categoryId, String? username) async {
    try {
      final Product product = Product(
        name: name,
        quantity: quantity,
        image: image,
        categoryId: categoryId,
        createdBy: username,
        updatedBy: username,
      );
      final jsonData = product.toJson();

      final Response response = await DioHelper.dio.post(
        '/products/create',
        data: jsonData,
      );

      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> update(String id, String? name, int? quantity, String? image,
      String? categoryId, String? username) async {
    try {
      final Product product = Product(
        name: name,
        quantity: quantity,
        image: image,
        categoryId: categoryId,
        updatedBy: username,
      );
      final jsonData = product.toJson();

      print(jsonData.toString());

      final Response response = await DioHelper.dio.put(
        '/products/update/$id',
        data: jsonData,
      );

      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> getAll() async {
    try {
      final Response response = await DioHelper.dio.get('/products');

      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> getByCategoryId(String id) async {
    try {
      final Response response =
          await DioHelper.dio.get('/products/category/$id');

      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> getById(String id) async {
    try {
      final Response response = await DioHelper.dio.get('/products/$id');

      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> delete(String id) async {
    try {
      final Response response =
          await DioHelper.dio.delete('/products/delete/$id');

      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }
}
