import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:course_mania/models/user_model.dart';
import 'package:course_mania/services/user_service.dart';

class UserCubit extends Cubit<List<UserModel>> {
  UserCubit() : super([]);

  final UserService _userService = UserService();

  void get user async => emit(await _userService.getUser());
}
