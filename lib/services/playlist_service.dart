import 'package:http/http.dart' as http;

import 'package:course_mania/constants/api.dart';
import 'package:course_mania/models/playlist_model.dart';

class PlaylistService {
  Future<List<PlaylistModel>> getPlaylist() async {
    try {
      final response =
          await http.get(Uri.parse(Api().baseApi + "playlist/getall"));
      if (response.statusCode == 200) {
        final payload = payloadModelFromJson(response.body);
        return payload.playlist;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
