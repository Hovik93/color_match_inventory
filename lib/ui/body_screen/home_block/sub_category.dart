// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/base/dynamic_size.dart';
import 'package:color_match_inventory/base/images.dart';
import 'package:color_match_inventory/ui/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class SubCategoryPage extends StatefulWidget {
  String? title;
  Map<String, dynamic>? subCategories;

  SubCategoryPage({
    super.key,
    this.title,
    this.subCategories,
  });

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounce;
  List<dynamic> filteredData = [];

  void _onSearchChanged(String query) {
    if (_debounce != null) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        if (query.isEmpty) {
          // Если поле поиска пустое, возвращаем все subItems
          filteredData = List.from(widget.subCategories?['subItems']);
        } else {
          // Фильтруем subItems по subtitle
          filteredData =
              List<Map<String, dynamic>>.from(widget.subCategories?['subItems'])
                  .where((subItem) => subItem['subtitle']
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList();
        }
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    filteredData = widget.subCategories?['subItems'];
    super.initState();
  }

  Future<String> getFullPath(String relativePath) async {
    if (relativePath.isEmpty) {
      return ''; // Возвращаем пустую строку, если путь отсутствует
    }
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$relativePath';
  }

  Future<File?> loadImage(String? relativePath) async {
    if (relativePath == null || relativePath.isEmpty) {
      return null;
    }
    final fullPath = await getFullPath(relativePath);
    final file = File(fullPath);

    if (await file.exists()) {
      return file;
    } else {
      print("Файл не найден: $fullPath");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
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
                        _isSearching ? Icons.close : Icons.search,
                        size: 25.w,
                        color: AppColors.orange,
                      ),
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: body(theme: theme),
      ),
    );
  }

  Widget body({TextTheme? theme}) {
    return Column(
      children: [
        (filteredData.isNotEmpty)
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 30,
                    ),
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: FutureBuilder<String>(
                          future: getFullPath(filteredData[index]['subImage']),
                          builder: (context, snapshot) {
                            // Если путь не загрузился или произошла ошибка
                            // Проверяем состояние snapshot и данные
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child:
                                    CircularProgressIndicator(), // Индикатор загрузки
                              );
                            }

                            // Если путь пустой или ошибка при загрузке
                            if (snapshot.data == '' ||
                                (!snapshot.hasData ||
                                    snapshot.data == null ||
                                    snapshot.data!.isEmpty)) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: width,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: AppColors.primary),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: AppColors.primary,
                                        size: 42.w,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${filteredData[index]['subtitle']}',
                                    style: theme?.titleMedium,
                                  ),
                                ],
                              );
                            }

                            // Если путь загружен успешно
                            return Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(snapshot.data!),
                                      width: 160.w,
                                      height: 200.w,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${filteredData[index]['subtitle']}',
                                  style: theme?.titleMedium,
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            : Expanded(
                child: SizedBox(
                  width: width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'No matching results',
                        style: theme?.titleMedium,
                      ),
                      Image.asset(
                        AppImages.noResult,
                        width: 68.w,
                        height: 68.w,
                      )
                    ],
                  ),
                ),
              )
      ],
    );
  }
}
