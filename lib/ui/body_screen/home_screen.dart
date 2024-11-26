import 'dart:async';

import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/base/dynamic_size.dart';
import 'package:color_match_inventory/base/images.dart';
import 'package:color_match_inventory/ui/body_screen/home_block/add_category.dart';
import 'package:color_match_inventory/ui/body_screen/home_block/data_category.dart';
import 'package:color_match_inventory/ui/body_screen/home_block/filter.dart';
import 'package:color_match_inventory/ui/widget/category_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoryStorage storage = CategoryStorage();
  List<Map<String, dynamic>> filteredCategories = [];
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  bool _isSearching = false;
  List<Map<String, dynamic>> categories = [
    {
      'title': 'Add a category',
      'icon': AppImages.plus,
      'crossAxisCount': 2,
      'mainAxisCount': 1,
      'selected': false,
    }
  ];
  List<Map<String, dynamic>> loadedCategories = [];
  Map<String, dynamic> newCategory = {
    'title': 'Add a category',
    'icon': AppImages.plus, // Замените на реальный путь к иконке
    'crossAxisCount': 2,
    'mainAxisCount': 1,
    'selected': false,
  };
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadedCategories = await CategoryStorage.loadCategories();

      // Если данные пустые, добавьте категорию по умолчанию
      if (loadedCategories.isEmpty) {
        await CategoryStorage.ensureCategoryExists(newCategory);
        loadedCategories = await CategoryStorage.loadCategories();
        categories = loadedCategories;
      }

      filteredCategories = loadedCategories;

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> loadCategories() async {
    loadedCategories = await CategoryStorage.loadCategories();
    setState(() {});
  }

  void addCategory(Map<String, dynamic> newCategory) async {
    // Загружаем существующие категории
    List<Map<String, dynamic>> existingCategories =
        await CategoryStorage.loadCategories();

    // Проверяем, существует ли уже такая категория
    final bool exists = existingCategories.any((category) =>
        category['title'] == newCategory['title'] &&
        category['icon'] == newCategory['icon']);

    if (!exists) {
      existingCategories.add(newCategory);

      // Сохраняем обновленный список
      await CategoryStorage.saveCategories(existingCategories);

      setState(() {
        loadedCategories = existingCategories;
      });
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce != null) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        if (query.isEmpty) {
          // Если поле поиска пустое, возвращаем все категории
          filteredCategories = List.from(loadedCategories);
        } else {
          // Фильтруем категории по title
          filteredCategories = List<Map<String, dynamic>>.from(loadedCategories)
              .where((category) => category['title']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(width, DynamicSize.size(screenWidth: width, size: 100)),
        child: appBar(theme: theme),
      ),
      body: body(theme: theme),
    );
  }

  Widget appBar({TextTheme? theme}) {
    return Padding(
      padding: EdgeInsets.only(top: deviceTopPadding + 10, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!_isSearching)
            Text(
              'Home',
              style: theme?.titleLarge,
            ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_isSearching)
                  Expanded(
                    child: SizedBox(
                      height: 40.0,
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: AppColors.grayLight),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        style: TextStyle(color: AppColors.black),
                        autofocus: true,
                      ),
                    ),
                  ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_isSearching) {
                        _isSearching = false;
                      } else {
                        _isSearching = true;
                      }
                    });
                  },
                  child: _isSearching
                      ? Icon(
                          Icons.close,
                          size: 25.w,
                          color: AppColors.black,
                        )
                      : Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: AppColors.gray,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.search,
                            size: 25.w,
                            color: AppColors.orange,
                          ),
                        ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return FilterHome(
                        title: 'Home',
                      );
                    }));
                  },
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: AppColors.gray,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      AppImages.filter,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget body({TextTheme? theme}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: SingleChildScrollView(
        child: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: filteredCategories.map((category) {
            return StaggeredGridTile.count(
              crossAxisCellCount: category['crossAxisCount'],
              mainAxisCellCount: category['mainAxisCount'],
              child: GestureDetector(
                onTap: () {
                  if (category['title'] == 'Add a category') {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return AddCategory(
                        title: 'Home',
                      );
                    })).then((value) async {
                      if (value != null) {
                        categories.add(value);
                        if (loadedCategories.length == 2) {
                          categories = categories.reversed.toList();
                          await CategoryStorage.overwriteCategories(categories);
                        }
                        addCategory(value);

                        filteredCategories =
                            await CategoryStorage.loadCategories();

                        setState(() {});
                      }
                    });
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return DataCategory(
                          title: 'Home', categoryName: category['title']);
                    }));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: category['title'] == 'Add a category'
                        ? AppColors.gray
                        : AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      category['icon'] != ''
                          ? Image.asset(
                              category['icon'],
                              width: category['title'] == 'Add a category'
                                  ? 24.w
                                  : 40.w,
                              color: category['title'] == 'Add a category'
                                  ? AppColors.grayLight
                                  : AppColors.white,
                            )
                          : const SizedBox.shrink(),
                      category['title'] != null && category['title'] != ''
                          ? Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                category['title'],
                                style: theme?.titleMedium?.copyWith(
                                    color: category['title'] == 'Add a category'
                                        ? AppColors.grayLight
                                        : AppColors.white),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
