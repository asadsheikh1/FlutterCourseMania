import 'package:course_mania/models/comment_model.dart';
import 'package:course_mania/services/comment_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCubit extends Cubit<List<CommentModel>> {
  CommentCubit() : super([]);

  final CommentService _commentService = CommentService();

  void get comment async => emit(await _commentService.getComment());
}
