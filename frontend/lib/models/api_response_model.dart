import 'package:frontend/models/category_model.dart';
import 'package:frontend/models/user_model.dart';

import 'image_model.dart';

class ApiResponseMap {
  Map<String, dynamic>? data;
  String? error;
  int? status;

  ApiResponseMap({this.data, this.error, this.status});

  factory ApiResponseMap.fromJson(Map<String, dynamic> json) {
    return ApiResponseMap(
      data: json['data'],
      status: json['status'],
      error: json['error'],
    );
  }
}

class ImageApiResponse {
  ImageModel? data;
  String? error;
  int? status;

  ImageApiResponse({this.data, this.error, this.status});

  factory ImageApiResponse.fromJson(Map<String, dynamic> json) {
    ImageModel? image;

    if (json['data'] != null) {
      image = ImageModel.fromJson(
        json['data'],
      );
    }
    return ImageApiResponse(
      data: image,
      status: json['status'],
      error: json['error'],
    );
  }
}

class RegisterApiResponse {
  User? data;
  String? error;
  int? status;

  RegisterApiResponse({this.data, this.error, this.status});

  factory RegisterApiResponse.fromJson(Map<String, dynamic> json) {
    User? user;

    if (json['data'] != null) {
      user = User.fromJson(json['data']);
    }

    return RegisterApiResponse(
      data: user,
      status: json['status'],
      error: json['error'],
    );
  }
}

class LoginApiResponse {
  User? data;
  String? error;
  int? status;

  LoginApiResponse({this.data, this.error, this.status});

  factory LoginApiResponse.fromJson(Map<String, dynamic> json) {
    User? user;

    if (json['data'] != null) {
      user = User.fromJson(json['data']);
    }
    return LoginApiResponse(
      data: user,
      status: json['status'],
      error: json['error'],
    );
  }
}

class CategoryApiResponse {
  List<Category>? data;
  String? error;
  int? status;

  CategoryApiResponse({this.data, this.error, this.status});

  factory CategoryApiResponse.fromJson(Map<String, dynamic> json) {
    final categories = <Category>[];

    if (json["data"] != null) {
      json["data"].forEach((v) {
        categories.add(
          Category.fromJson(v),
        );
      });
    }

    return CategoryApiResponse(
      data: categories,
      error: json['error'],
      status: json['status'],
    );
  }
}
