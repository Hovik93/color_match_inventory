// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/ui/body_screen/home_block/add_category.dart';
import 'package:color_match_inventory/ui/home.dart';
import 'package:color_match_inventory/ui/widget/bottom_navigation_bar.dart';
import 'package:color_match_inventory/ui/widget/category_storage.dart';
import 'package:color_match_inventory/ui/widget/text_field_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class NewThing extends StatefulWidget {
  String? title;
  NewThing({
    super.key,
    this.title,
  });

  @override
  State<NewThing> createState() => _NewThingState();
}

class _NewThingState extends State<NewThing> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController newSubcategoryController = TextEditingController();
  List<Map<String, dynamic>> loadedCategories = [];
  List<Map<String, dynamic>> categoryList = [];
  Map<String, dynamic> tmpSelectCategory = {};
  int selectedCategoryIndex = -1;
  int selectColor = -1;
  int selectSubcategoryIndex = -1;
  int selectSubcategoryColor = -1;
  String? subCategoryText;

  List<Map<String, dynamic>> uniqueCategories = [];
  Set<String> uniqueKeys = {}; // Для проверки уникальности
  List<int> colorList = [
    0xffC3C3C3,
    0xffFE2B7D,
    0xff2B66FF,
    0xff42F846,
    0xffFFDA03,
    0xffC062F6,
    0xff42FAE4,
    0xff9D9D9D,
    0xffEE2928,
    0xff002EA1,
    0xff008C05,
    0xffFB9702,
    0xff62009B,
    0xff009483,
    0xff1B1B1B,
    0xff741011,
    0xff001449,
    0xff004103,
    0xffFF5D01,
    0xff30153E,
    0xff004038,
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadedCategories = await CategoryStorage.loadCategories();
      if (mounted) {
        setState(() {}); // Обновляем интерфейс после загрузки
      }
    });

    categoryController.addListener(() {
      setState(() {});
    });
    newSubcategoryController.addListener(() {
      setState(() {});
    });
  }

  File? _image; // Для хранения выбранного изображения
  final ImagePicker _picker = ImagePicker();

  // Выбор изображения
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 800, // Уменьшение ширины изображения
        maxHeight: 800, // Уменьшение высоты изображения
        imageQuality: 85, // Сжатие в процентах
      );
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error while selecting image: $e");
    }
  }

  @override
  void dispose() {
    categoryController.dispose();
    newSubcategoryController.dispose();
    super.dispose();
  }

  void updateCategoryColor(
    String categoryTitle,
    int color,
    List<Map<String, dynamic>> categories,
  ) {
    for (var category in categories) {
      if (category['title'] == categoryTitle) {
        category['data'] = {'color': color};
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          widget.title ?? '',
          style: theme.titleLarge,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => HomePage(selectedIndex: 0),
              ),
              (route) => false, // Удаляет все предыдущие маршруты
            );
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 0,
      ),
      body: body(theme: theme),
    );
  }

  Widget body({TextTheme? theme}) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _image == null
                              ? Text('Photo', style: theme?.bodyMedium)
                              : const SizedBox.shrink(),
                          _image != null
                              ? Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.file(
                                        _image!,
                                        width: 340,
                                        height: 270,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          _pickImage(ImageSource.gallery);
                                        },
                                        child: Icon(
                                          Icons.file_download_outlined,
                                          size: 44.w,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          _image == null
                              ? GestureDetector(
                                  onTap: () {
                                    _pickImage(ImageSource.gallery);
                                  },
                                  child: Icon(
                                    Icons.file_download_outlined,
                                    size: 44.w,
                                    color: AppColors.primary,
                                  ),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text('Name', style: theme?.bodyMedium),
                    ),
                    TextFieldRadius(
                      hint: "Name",
                      controller: categoryController,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 10),
                      child: Text('Category', style: theme?.bodyMedium),
                    ),
                    Wrap(
                      spacing: 15, // Horizontal spacing between items
                      runSpacing: 15, // Vertical spacing between rows
                      children: List.generate(
                        loadedCategories.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              if (loadedCategories[index]['title'] !=
                                  "Add a category") {
                                selectedCategoryIndex = index;
                                tmpSelectCategory = loadedCategories[index];
                                for (var item
                                    in tmpSelectCategory['data'] ?? []) {
                                  String key =
                                      '${item['color']}_${item['name']}';
                                  if (!uniqueKeys.contains(key) &&
                                      item['name'] != null &&
                                      item['name'] != "") {
                                    uniqueKeys.add(key);
                                    uniqueCategories.add(item);
                                  }
                                }
                                if (mounted) {
                                  setState(() {});
                                }
                              } else {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return AddCategory(
                                    title: 'Home',
                                  );
                                })).then((value) async {
                                  // Проверяем, возвращается ли value
                                  if (value != null) {
                                    loadedCategories.add(value);
                                    print(
                                        "Список после добавления: $loadedCategories");

                                    // Реверсирование при длине 2
                                    if (loadedCategories.length == 2) {
                                      loadedCategories =
                                          loadedCategories.reversed.toList();
                                      print(
                                          "Список после реверса: $loadedCategories");
                                    }

                                    // Сохраняем обновленный список
                                    await CategoryStorage.overwriteCategories(
                                        loadedCategories);

                                    // Перезагружаем категории
                                    loadedCategories =
                                        await CategoryStorage.loadCategories();
                                    print(
                                        "Список после загрузки: $loadedCategories");

                                    // Обновляем состояние
                                    setState(() {});
                                  }
                                });
                              }
                            },
                            child: Container(
                              width: (MediaQuery.of(context).size.width - 45) /
                                  2, // Fixed width
                              height: 56.w, // Fixed height
                              decoration: BoxDecoration(
                                color: selectedCategoryIndex == index
                                    ? AppColors.primary
                                    : AppColors.white,
                                border: Border.all(
                                    width: 1, color: AppColors.primary),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    loadedCategories[index]['icon'] != '' &&
                                            loadedCategories[index]['title'] !=
                                                "Add a category"
                                        ? Image.asset(
                                            loadedCategories[index]['icon'],
                                            width: 24.w,
                                            height: 24.w,
                                          )
                                        : const SizedBox.shrink(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${loadedCategories[index]['title']}",
                                      style: theme?.titleMedium?.copyWith(
                                          color: loadedCategories[index]
                                                      ['title'] ==
                                                  "Add a category"
                                              ? AppColors.grayLight
                                              : selectedCategoryIndex == index
                                                  ? AppColors.white
                                                  : AppColors.primary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    categoryList.isNotEmpty
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text('Subcategory',
                                    style: theme?.bodyMedium),
                              ),
                              Text(
                                'location',
                                style: theme?.titleMedium
                                    ?.copyWith(color: AppColors.grayLight),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    selectedCategoryIndex != -1 &&
                            (tmpSelectCategory['data'] != null &&
                                tmpSelectCategory['data'].isNotEmpty)
                        ? subCategoryBlock(theme: theme)
                        : const SizedBox.shrink(),
                    selectedCategoryIndex != -1
                        ? newSubCategoryBlock(theme: theme)
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (selectedCategoryIndex != -1 &&
                    categoryController.text.isNotEmpty &&
                    ((selectSubcategoryIndex != -1) ||
                        ((selectColor != -1) &&
                            newSubcategoryController.text.isNotEmpty))) {
                  String categoryTitle =
                      loadedCategories[selectedCategoryIndex]['title'];

                  // Формируем новый объект данных
                  Map<String, dynamic> newData = {
                    'color': selectColor != -1
                        ? colorList[selectColor]
                        : selectSubcategoryColor,
                    'name': newSubcategoryController.text.trim() != ''
                        ? newSubcategoryController.text.trim()
                        : subCategoryText,
                    'subcategory': [
                      {"title": categoryController.text}
                    ]
                  };

                  // Обновляем категорию
                  await CategoryStorage.updateCategoryWithSubcategory(
                      categoryTitle, newData);

                  if (_image != null) {
                    // Получаем путь к директории документов
                    final directory = await getApplicationDocumentsDirectory();
                    final imagePath =
                        '${directory.path}/subcategory_images/${_image!.uri.pathSegments.last}';

                    // Создаем папку, если она не существует
                    final imageDirectory =
                        Directory('${directory.path}/subcategory_images');
                    if (!await imageDirectory.exists()) {
                      await imageDirectory.create(recursive: true);
                    }

                    // Копируем файл в постоянную директорию
                    final newImage = await _image!.copy(imagePath);

                    // Здесь добавляйте код для сохранения пути изображения в базу данных
                    await CategoryStorage.addImageToSubcategory(
                      tmpSelectCategory['title'], // Название категории
                      categoryController.text.trim(), // Название подкатегории
                      newImage.path, // Новый путь к изображению
                    );
                  } else {
                    await CategoryStorage.addImageToSubcategory(
                      tmpSelectCategory['title'], // Название категории
                      categoryController.text.trim(), // Название подкатегории
                      '', // Путь к изображению
                    );
                  }

                  // Перезагружаем категории после обновления
                  loadedCategories = await CategoryStorage.loadCategories();

                  // Очищаем контроллер и сбрасываем выбранный индекс
                  categoryController.clear();
                  selectColor = -1;
                  setState(() {});
                }
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Container(
                height: 44.w,
                margin: EdgeInsets.only(
                  bottom: 10.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selectedCategoryIndex != -1 &&
                          categoryController.text.isNotEmpty &&
                          ((selectSubcategoryIndex != -1) ||
                              ((selectColor != -1) &&
                                  newSubcategoryController.text.isNotEmpty))
                      ? AppColors.primary
                      : AppColors.primaryLight,
                ),
                child: Center(
                  child: Text(
                    'Create',
                    style: theme?.titleLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget subCategoryBlock({TextTheme? theme}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text('Subcategory', style: theme?.bodyMedium),
        ),
        Text(
          'location',
          style: theme?.titleMedium?.copyWith(color: AppColors.grayLight),
        ),
        ...List.generate(
          uniqueCategories.length,
          (index) => tmpSelectCategory['data'][index]['name'] == "" ||
                  tmpSelectCategory['data'][index]['name'] == null
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () {
                    selectSubcategoryIndex = index;
                    selectColor = -1;
                    newSubcategoryController.text = '';
                    selectSubcategoryColor = uniqueCategories[index]['color'];
                    subCategoryText = uniqueCategories[index]['name'];
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: selectSubcategoryIndex == index
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(uniqueCategories[index]['color']),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '${uniqueCategories[index]['name']}',
                          style: theme?.bodyMedium?.copyWith(
                              color: selectSubcategoryIndex == index
                                  ? AppColors.white
                                  : AppColors.black),
                        ),
                      ],
                    ),
                  ),
                ),
        )
      ],
    );
  }

  Widget newSubCategoryBlock({TextTheme? theme}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 10),
          child: Text(
            'new subcategory',
            style: theme?.titleMedium?.copyWith(color: AppColors.grayLight),
          ),
        ),
        TextFieldRadius(
          hint: "Name",
          controller: newSubcategoryController,
          onChanged: (value) {
            selectSubcategoryIndex = -1;
            setState(() {});
          },
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(height: 260.w, child: colorBlock(theme: theme)),
      ],
    );
  }

  Widget colorBlock({TextTheme? theme}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, // 3 columns
          mainAxisSpacing: 3, // spacing between rows
          crossAxisSpacing: 5, // spacing between columns
        ),
        itemCount: colorList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              selectColor = index;
              selectSubcategoryIndex = -1;
              selectSubcategoryColor = -1;
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: selectColor == index
                      ? Color(colorList[index])
                      : Colors.transparent,
                ), // Directly use the integer color
              ),
              height: 44.w, // Specify height if you want square containers
              width: 44.w,
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(
                    colorList[index],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
