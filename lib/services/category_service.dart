import 'package:http/http.dart' as http;

import 'package:course_mania/constants/api.dart';
import 'package:course_mania/models/category_model.dart';

class CategoryService {
  Future<List<CategoryModel>> getCategory() async {
    try {
      final response =
          await http.get(Uri.parse(Api().baseApi + "category/getall"));
      if (response.statusCode == 200) {
        final payload = payloadModelFromJson(response.body);
        return payload.category;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
