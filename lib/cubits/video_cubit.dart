import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:course_mania/models/video_model.dart';
import 'package:course_mania/services/video_service.dart';

class VideoCubit extends Cubit<List<VideoModel>> {
  VideoCubit() : super([]);

  final VideoService _videoService = VideoService();

  void get video async => emit(await _videoService.getVideo());
}
