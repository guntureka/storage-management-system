import 'package:dio/dio.dart';

// const String BASE_URL = "http://192.168.5.2:3000";
const String BASE_URL = "http://192.168.202.145:3000";

class DioHelper {
  static final Dio dio = Dio(
    BaseOptions(baseUrl: '$BASE_URL/api'),
  );
}
