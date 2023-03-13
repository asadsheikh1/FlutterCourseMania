import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:course_mania/models/playlist_model.dart';
import 'package:course_mania/services/playlist_service.dart';

class PlaylistCubit extends Cubit<List<PlaylistModel>> {
  PlaylistCubit() : super([]);

  final PlaylistService _playlistService = PlaylistService();

  void get playlist async => emit(await _playlistService.getPlaylist());
}
