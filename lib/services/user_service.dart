import 'package:http/http.dart' as http;

import 'package:course_mania/constants/api.dart';
import 'package:course_mania/models/user_model.dart';

class UserService {
  Future<List<UserModel>> getUser() async {
    try {
      final response = await http.get(Uri.parse(Api().baseApi + "user/getall"));
      if (response.statusCode == 200) {
        final payload = payloadModelFromJson(response.body);
        return payload.user;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
