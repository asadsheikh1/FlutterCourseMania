import 'dart:convert';

import 'package:equatable/equatable.dart';

PayloadModel payloadModelFromJson(String str) =>
    PayloadModel.fromJson(json.decode(str));

String payloadModelToJson(PayloadModel data) => json.encode(data.toJson());

class PayloadModel extends Equatable {
  final List<CategoryModel> category;

  const PayloadModel({
    required this.category,
  });

  PayloadModel copyWith({
    List<CategoryModel>? category,
  }) =>
      PayloadModel(
        category: category ?? this.category,
      );

  factory PayloadModel.fromJson(Map<String, dynamic> json) => PayloadModel(
        category: List<CategoryModel>.from(
            json["payload"].map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payload": List<dynamic>.from(
          category.map((x) => x.toJson()),
        ),
      };

  @override
  List<Object?> get props => [category];
}

class CategoryModel extends Equatable {
  final int categoryId;
  final String categoryName;
  final int isActive;

  const CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.isActive,
  });

  CategoryModel copyWith({
    int? categoryId,
    String? categoryName,
    int? isActive,
  }) =>
      CategoryModel(
        categoryId: categoryId ?? this.categoryId,
        categoryName: categoryName ?? this.categoryName,
        isActive: isActive ?? this.isActive,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "is_active": isActive,
      };

  @override
  List<Object?> get props => [categoryId, categoryName, isActive];
}
