import 'package:flutter_course/src/features/menu/models/item_model.dart';

class CategoryModel {
  final String categoryName;
  final List<ItemModel> items;

  const CategoryModel({
    required this.categoryName,
    required this.items,
  });

  factory CategoryModel.fromJSON(Map<String, dynamic> json) {
    return CategoryModel(
      categoryName: json['categoryName'],
      items: json['items'],
    );
  }
}
