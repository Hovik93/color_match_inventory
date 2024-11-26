// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/base/images.dart';
import 'package:color_match_inventory/ui/body_screen/home_block/filter.dart';
import 'package:color_match_inventory/ui/body_screen/home_block/sub_category.dart';
import 'package:color_match_inventory/ui/widget/bottom_navigation_bar.dart';
import 'package:color_match_inventory/ui/widget/category_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DataCategory extends StatefulWidget {
  String? title;
  String? categoryName;
  List<String>? categoryNameList;
  List<int>? categoryColorList;
  bool? filter;
  DataCategory({
    super.key,
    this.title,
    this.categoryName,
    this.categoryNameList,
    this.categoryColorList,
    this.filter = false,
  });

  @override
  State<DataCategory> createState() => _DataCategoryState();
}

class _DataCategoryState extends State<DataCategory> {
  List<Map<String, dynamic>> loadedCategories = [];
  List<Map<String, dynamic>> allData = [];
  List<Map<String, dynamic>> filterTitleList = [];

  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounce;
  List<dynamic> filteredData = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadedCategories = await CategoryStorage.loadCategories();

      if (widget.filter == true) {
        extractAndAddDataByFlexibleFilters(
          loadedCategories,
          allData,
          filterTitles: widget.categoryNameList,
          filterColors: widget.categoryColorList,
        );

        filterTitleList = extractFilteredUniqueTitlesAndIcons(
          loadedCategories,
          filterColors: widget.categoryColorList,
          filterTitles: widget.categoryNameList,
        );
      } else {
        extractAndAddDataByTitle(
          loadedCategories,
          allData,
          widget.categoryName ?? '',
        );
      }

      filteredData = allData;

      if (mounted) {
        setState(() {});
      }
    });
  }

  void _onSearchChanged(String query) {
    if (_debounce != null) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        if (query.isEmpty) {
          // Если поле поиска пустое, возвращаем все элементы
          filteredData = List.from(allData);
        } else {
          // Фильтруем элементы по совпадению с name
          filteredData = allData
              .where((item) => item['name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
        }
      });
    });
  }

  void extractAndAddDataByTitle(
    List<Map<String, dynamic>> loadedCategories,
    List<Map<String, dynamic>> allData,
    String filterTitle,
  ) {
    // Временный словарь для группировки по цвету и имени
    Map<String, Map<String, dynamic>> groupedData = {};

    for (var category in loadedCategories) {
      // Проверяем, совпадает ли текущий title с filterTitle
      if (category['title'] == filterTitle) {
        if (category.containsKey('data') && category['data'] is List) {
          for (var item in category['data']) {
            if (item.containsKey('subcategory') &&
                item['subcategory'] is List) {
              int color = item['color'];
              String name = item['name'];
              String groupKey =
                  '$color|$name'; // Уникальный ключ для группировки

              // Если цвет и имя уже есть в группировке
              if (groupedData.containsKey(groupKey)) {
                // Увеличиваем количество и добавляем subItems (subtitle + subImage)
                groupedData[groupKey]!['quantity'] += 1;

                for (var subcategory in item['subcategory']) {
                  if (subcategory is Map<String, dynamic>) {
                    if (subcategory.containsKey('title') &&
                        subcategory.containsKey('image')) {
                      groupedData[groupKey]!['subItems'].add({
                        'subtitle': subcategory['title'],
                        'subImage': subcategory['image']
                      });
                    }
                  }
                }
              } else {
                // Инициализируем запись для нового цвето-именного ключа
                groupedData[groupKey] = {
                  'title': category['title'],
                  'icon': category['icon'],
                  'crossAxisCount': category['crossAxisCount'],
                  'mainAxisCount': category['mainAxisCount'],
                  'color': color,
                  'quantity': 1,
                  'name': name, // Учитываем имя для группировки
                  'subItems': item['subcategory']
                      .where((subcategory) =>
                          subcategory is Map<String, dynamic> &&
                          subcategory.containsKey('title') &&
                          subcategory.containsKey('image'))
                      .map((subcategory) => {
                            'subtitle': subcategory['title'],
                            'subImage': subcategory['image']
                          })
                      .toList() // Список объектов с subtitle и subImage
                };
              }
            }
          }
        }
      }
    }

    // Преобразуем словарь в список
    allData.addAll(groupedData.values.map((entry) {
      // Убираем дубликаты из subItems
      entry['subItems'] = entry['subItems']
          .toSet()
          .toList(); // Убираем дубликаты по всей структуре subItems
      return entry;
    }));
  }

  void extractAndAddDataByFlexibleFilters(
      List<Map<String, dynamic>> loadedCategories,
      List<Map<String, dynamic>> allData,
      {List<String>? filterTitles,
      List<int>? filterColors}) {
    // Временный словарь для группировки по `color` и `name`
    Map<String, Map<String, dynamic>> groupedData = {};

    for (var category in loadedCategories) {
      // Проверяем фильтр по `title`
      bool titleMatches =
          filterTitles == null || filterTitles.contains(category['title']);

      if (titleMatches &&
          category.containsKey('data') &&
          category['data'] is List) {
        for (var item in category['data']) {
          int color = item['color'];
          String? name = item['name'];

          // Проверяем фильтр по `color`
          bool colorMatches =
              filterColors == null || filterColors.contains(color);

          if (colorMatches &&
              item.containsKey('subcategory') &&
              item['subcategory'] is List) {
            // Генерируем ключ для группировки: `color_name`
            String groupKey = "${color}_$name";

            // Если такая группа уже есть
            if (groupedData.containsKey(groupKey)) {
              // Увеличиваем количество и объединяем `subItems`
              groupedData[groupKey]!['quantity'] += 1;

              for (var subcategory in item['subcategory']) {
                if (subcategory is Map<String, dynamic> &&
                    subcategory.containsKey('title')) {
                  String subImage = subcategory.containsKey('image')
                      ? subcategory['image']
                      : '';
                  groupedData[groupKey]!['subItems'].add({
                    'subtitle': subcategory['title'],
                    'subImage': subImage,
                  });
                }
              }
            } else {
              // Создаем новую запись для группировки
              groupedData[groupKey] = {
                'title': category['title'],
                'icon': category['icon'],
                'crossAxisCount': category['crossAxisCount'],
                'mainAxisCount': category['mainAxisCount'],
                'color': color,
                'quantity': 1,
                'name': name,
                'subItems': item['subcategory']
                    .where((subcategory) =>
                        subcategory is Map<String, dynamic> &&
                        subcategory.containsKey('title') &&
                        subcategory.containsKey('image'))
                    .map((subcategory) => {
                          'subtitle': subcategory['title'],
                          'subImage': subcategory['image']
                        })
                    .toList(),
              };
            }
          }
        }
      }
    }

    // Преобразуем словарь в список
    allData.addAll(groupedData.values.map((entry) {
      // Убираем дубликаты из `subItems`
      entry['subItems'] = entry['subItems']
          .toSet()
          .toList(); // Удаляем дубликаты объектов в `subItems`
      return entry;
    }));
  }

  List<Map<String, String>> extractFilteredUniqueTitlesAndIcons(
    List<Map<String, dynamic>> loadedCategories, {
    List<String>? filterTitles,
    List<int>? filterColors,
  }) {
    Map<String, String> uniqueTitlesAndIcons = {};

    for (var category in loadedCategories) {
      // Проверяем, нужно ли фильтровать по title
      bool titleMatches =
          filterTitles == null || filterTitles.contains(category['title']);

      if (titleMatches &&
          category.containsKey('data') &&
          category['data'] is List) {
        for (var item in category['data']) {
          int color = item['color'];

          // Проверяем, нужно ли фильтровать по color
          bool colorMatches =
              filterColors == null || filterColors.contains(color);

          // Добавляем только если совпадают оба фильтра или они не заданы
          if (titleMatches && colorMatches) {
            // Добавляем уникальный title и его icon
            if (!uniqueTitlesAndIcons.containsKey(category['title'])) {
              uniqueTitlesAndIcons[category['title']] = category['icon'];
            }
          }
        }
      }
    }

    // Преобразуем словарь в список
    return uniqueTitlesAndIcons.entries
        .map((entry) => {'title': entry.key, 'icon': entry.value})
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: _isSearching
            ? SizedBox(
                height: 40.0,
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: AppColors.grayLight),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
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
              )
            : Text(
                widget.title ?? '',
                style: theme.titleLarge,
              ),
        actions: [
          if (widget.filter == true)
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
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  AppImages.filter,
                ),
              ),
            ),
          if (widget.filter == false)
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
                  ? Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.close,
                        size: 25.w,
                        color: AppColors.black,
                      ),
                    )
                  : Container(
                      width: 44.w,
                      height: 44.w,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: AppColors.gray,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isSearching ? Icons.close : Icons.search,
                        size: 25.w,
                        color: AppColors.orange,
                      ),
                    ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 0,
      ),
      body: body(theme: theme),
    );
  }

  Widget body({TextTheme? theme}) {
    return allData.isEmpty || filteredData.isEmpty
        ? Center(
            child: widget.filter == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.noResult,
                        width: 68.w,
                        height: 68.w,
                      ),
                      Text(
                        'No matching results',
                        style: theme?.titleMedium
                            ?.copyWith(color: AppColors.grayLight),
                      ),
                    ],
                  )
                : Text(
                    filteredData.isEmpty
                        ? 'No matching results'
                        : 'Nothing added',
                    style: theme?.titleMedium
                        ?.copyWith(color: AppColors.grayLight),
                  ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Wrap(
                  spacing: 15, // Horizontal spacing between items
                  runSpacing: 15, // Vertical spacing between rows
                  children: List.generate(
                    filterTitleList.length,
                    (index) {
                      return Container(
                        width: (MediaQuery.of(context).size.width - 45) / 2,
                        height: 56.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              filterTitleList[index]['icon'] != ''
                                  ? Image.asset(
                                      filterTitleList[index]['icon'],
                                      width: 24.w,
                                      height: 24.w,
                                      color: AppColors.white,
                                    )
                                  : const SizedBox.shrink(),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${filterTitleList[index]['title']}",
                                style: theme?.bodyLarge
                                    ?.copyWith(color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 15,
                  ),
                  itemCount:
                      _isSearching ? filteredData.length : allData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return SubCategoryPage(
                            title: widget.title,
                            subCategories: _isSearching
                                ? filteredData[index]
                                : allData[index],
                          );
                        }));
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            AppImages.color,
                            color: Color(_isSearching
                                ? filteredData[index]['color']
                                : allData[index]['color']),
                          ),
                          Text(
                            '${_isSearching ? filteredData[index]['name'] : allData[index]['name']}',
                            style: theme?.bodyMedium,
                          ),
                          Text(
                            'quantity ${_isSearching ? filteredData[index]['quantity'] : allData[index]['quantity']}',
                            style: theme?.titleMedium
                                ?.copyWith(color: AppColors.primary),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );

    //  Column(
    //     children: [
    //       Image.asset(
    //         AppImages.color,
    //         width: 164.w,
    //         height: 100.w,
    //         color: Colors.yellow,
    //       )
    //     ],
    //   );
  }
}
