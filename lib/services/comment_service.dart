import 'package:http/http.dart' as http;

import 'package:course_mania/constants/api.dart';
import 'package:course_mania/models/comment_model.dart';

class CommentService {
  Future<List<CommentModel>> getComment() async {
    try {
      final response =
          await http.get(Uri.parse(Api().baseApi + "comment/getall"));
      if (response.statusCode == 200) {
        final payload = payloadModelFromJson(response.body);
        return payload.comments;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
