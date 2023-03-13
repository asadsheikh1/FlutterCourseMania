import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:course_mania/models/category_model.dart';
import 'package:course_mania/services/category_service.dart';

class CategoryCubit extends Cubit<List<CategoryModel>> {
  CategoryCubit() : super([]);

  final CategoryService _categoryService = CategoryService();

  void get category async => emit(await _categoryService.getCategory());
}
