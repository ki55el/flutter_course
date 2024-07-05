import 'package:flutter_course/src/features/menu/models/category_model.dart';
import 'package:flutter_course/src/features/menu/models/item_model.dart';

const categories = [
  CategoryModel(
    categoryName: 'Черный кофе',
    items: [
      ItemModel(name: 'Американо ', price: 109),
      ItemModel(name: 'Лунго', price: 129),
      ItemModel(name: 'Эспрессо', price: 119),
    ],
  ),
  CategoryModel(
    categoryName: 'Кофе с молоком',
    items: [
      ItemModel(name: 'Олеато', price: 159),
      ItemModel(name: 'Капучино', price: 169),
      ItemModel(name: 'Латте', price: 129),
    ],
  ),
  CategoryModel(
    categoryName: 'Чай',
    items: [
      ItemModel(name: 'Черный', price: 89),
      ItemModel(name: 'Пуэр', price: 129),
      ItemModel(name: 'Улун', price: 139),
    ],
  ),
  CategoryModel(
    categoryName: 'Раф',
    items: [
      ItemModel(name: 'Тыквенный', price: 209),
      ItemModel(name: 'Кокосовый', price: 219),
      ItemModel(name: 'Малиновый', price: 229),
    ],
  ),
];
