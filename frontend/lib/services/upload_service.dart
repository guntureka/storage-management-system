import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:frontend/utils/dio_helper.dart';
import 'package:image_picker/image_picker.dart';

class UploadService {
  Future<dynamic> uploadImage(XFile imageFile) async {
    try {
      final formData = FormData.fromMap(
        {
          'image': MultipartFile.fromFileSync(
            imageFile.path,
            filename: imageFile.name,
          ),
        },
      );
      final Response response = await DioHelper.dio.post(
        '/uploads',
        data: formData,
      );

      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }
}
