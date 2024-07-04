import 'package:flutter_course/src/features/menu/models/category_model.dart';
import 'package:flutter_course/src/features/menu/view/widgets/category_widget.dart';
import 'package:flutter_course/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuScreen extends StatefulWidget {
  final List<CategoryModel> categories;

  const MenuScreen({super.key, required this.categories});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with SingleTickerProviderStateMixin {
  late final _menuController = ItemScrollController();
  late final _appBarController = ItemScrollController();
  late final _itemListener = ItemPositionsListener.create();
  late var _categoryKeys = <String, GlobalKey>{};

  int _currentCategoryIndex = 0;
  bool _isScrolling = false;
  final bool _scrolledToBottom = false;

  @override
  void initState() {
    super.initState();
    _initCategoryKeys();
    _initItemListener();
  }

  void _initCategoryKeys() {
    _categoryKeys = {
      for (var category in widget.categories) category.categoryName: GlobalKey()
    };
  }

  void _initItemListener() {
    _itemListener.itemPositions.addListener(_onItemPositionsChanged);
  }

  void _onItemPositionsChanged() {
    final fullyVisibleIndex = _itemListener.itemPositions.value.firstWhere((item) => item.itemLeadingEdge >= 0).index;

    if (_shouldUpdateCurrentCategory(fullyVisibleIndex)) {
      _setCurrentCategoryIndex(fullyVisibleIndex);
      _scrollAppBarToCategory(fullyVisibleIndex);
    }
  }

  bool _shouldUpdateCurrentCategory(int newIndex) => newIndex!= _currentCategoryIndex &&!_isScrolling &&!_scrolledToBottom;

  void _setCurrentCategoryIndex(int newIndex) {
    setState(() {
      _currentCategoryIndex = newIndex;
    });
  }

  Future<void> _scrollMenuToCategory(int index) async {
    _isScrolling = true;
    await _menuController.scrollTo(index: index, duration: const Duration(milliseconds: 200));
    await Future.delayed(const Duration(milliseconds: 200));
    _isScrolling = false;
  }

  Future<void> _scrollAppBarToCategory(int index) async {
    await _appBarController.scrollTo(
      curve: Curves.easeOut,
      opacityAnimationWeights: [20, 20, 60],
      index: index,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: SizedBox(
              height: 40,
              child: ScrollablePositionedList.builder(
                itemScrollController: _appBarController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  final category = widget.categories[index];
                  return _buildAppBarButton(category, index);
                },
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ScrollablePositionedList.builder(
            itemScrollController: _menuController,
            itemPositionsListener: _itemListener,
            itemBuilder: (context, index) {
              final category = widget.categories[index];
              return CategoryWidget(
                key: _categoryKeys[category.categoryName],
                category: category,
              );
            },
            itemCount: widget.categories.length,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarButton(CategoryModel category, int index) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: () {
          _setCurrentCategoryIndex(index);
          _scrollMenuToCategory(index);
          _scrollAppBarToCategory(index);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: index == _currentCategoryIndex
             ? AppColors.lightBlue
              : AppColors.white,
        ),
        child: Text(
          category.categoryName,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: index == _currentCategoryIndex
               ? AppColors.white
                : AppColors.black,
          ),
        ),
      ),
    );
  }
}