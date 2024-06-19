import 'package:frontend/models/product_model.dart';
import 'package:frontend/utils/dio_helper.dart';

class ProductService {
  Future<dynamic> add(
    String? name,
    int? quantity,
    String? categoryId,
    String? username,
  ) async {
    try {
      final Product product = Product(
        name: name,
        quantity: quantity,
        categoryId: categoryId,
        createdBy: username,
        updatedBy: username,
      );
      final jsonData = product.toJson();

      final response = await DioHelper.dio.post(
        '/products/create',
        data: jsonData,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
