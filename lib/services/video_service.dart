import 'package:http/http.dart' as http;

import 'package:course_mania/constants/api.dart';
import 'package:course_mania/models/video_model.dart';

class VideoService {
  Future<List<VideoModel>> getVideo() async {
    try {
      final response =
          await http.get(Uri.parse(Api().baseApi + "video/getall"));
      if (response.statusCode == 200) {
        final payload = payloadModelFromJson(response.body);
        return payload.videos;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
