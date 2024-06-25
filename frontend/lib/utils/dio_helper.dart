import 'package:dio/dio.dart';

const String BASE_URL = "http://192.168.105.145:3000";

class DioHelper {
  static final Dio dio = Dio(
    BaseOptions(baseUrl: '$BASE_URL/api'),
  );
}
