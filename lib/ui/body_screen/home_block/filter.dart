// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/ui/body_screen/home_block/data_category.dart';
import 'package:color_match_inventory/ui/widget/bottom_navigation_bar.dart';
import 'package:color_match_inventory/ui/widget/category_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class FilterHome extends StatefulWidget {
  String? title;
  FilterHome({
    super.key,
    this.title,
  });

  @override
  State<FilterHome> createState() => _FilterHomeState();
}

class _FilterHomeState extends State<FilterHome> {
  List<Map<String, dynamic>> loadedCategories = [];
  int selectColor = -1;
  int selectedCategoryIndex = -1;
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

  List<String> categoryFilterTitle = [];
  List<int> categoryFilterColor = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadedCategories = await CategoryStorage.loadCategories();
      loadedCategories.removeWhere((item) => item['title'] == "Add a category");

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? '',
          style: theme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 0,
      ),
      body: body(theme: theme),
    );
  }

  Widget body({TextTheme? theme}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                height: 150.w,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: colorBlock(theme: theme),
              ),
              categoryBlock(theme: theme),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return DataCategory(
                title: 'Home',
                categoryNameList:
                    categoryFilterTitle.isEmpty ? null : categoryFilterTitle,
                categoryColorList:
                    categoryFilterColor.isEmpty ? null : categoryFilterColor,
                filter: true,
              );
            }));
          },
          child: Container(
            height: 44.w,
            margin: EdgeInsets.symmetric(vertical: 20.w, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary,
            ),
            child: Center(
              child: Text(
                'Search',
                style: theme?.titleLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget colorBlock({TextTheme? theme}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
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
              categoryFilterColor = [colorList[index]];
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

  Widget categoryBlock({TextTheme? theme}) {
    return Column(
      children: [
        Wrap(
          spacing: 15, // Horizontal spacing between items
          runSpacing: 15, // Vertical spacing between rows
          children: List.generate(
            loadedCategories.length % 2 == 0
                ? loadedCategories.length
                : loadedCategories.length - 1,
            (index) {
              return GestureDetector(
                onTap: () {
                  if (loadedCategories[index]['title'] != "Add a category") {
                    selectedCategoryIndex = index;
                    if (loadedCategories[index]['selected'] == false) {
                      loadedCategories[index]['selected'] = true;
                    } else {
                      loadedCategories[index]['selected'] = false;
                    }
                    categoryFilterTitle = [];
                    for (var i = 0; i < loadedCategories.length; i++) {
                      if (loadedCategories[i]['selected'] == true) {
                        categoryFilterTitle.add(loadedCategories[i]['title']);
                      }
                    }
                    if (mounted) {
                      setState(() {});
                    }
                  }
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width - 45) / 2,
                  height: 56.w,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.primary),
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
                                color:
                                    loadedCategories[index]['selected'] == false
                                        ? AppColors.grayLight
                                        : AppColors.primary,
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${loadedCategories[index]['title']}",
                          style: theme?.bodyLarge?.copyWith(
                              color:
                                  loadedCategories[index]['selected'] == false
                                      ? AppColors.grayLight
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
        loadedCategories.length % 2 == 0
            ? const SizedBox.shrink()
            : GestureDetector(
                onTap: () {
                  if (loadedCategories[loadedCategories.length - 1]['title'] !=
                      "Add a category") {
                    selectedCategoryIndex = loadedCategories.length - 1;
                    if (loadedCategories[loadedCategories.length - 1]
                            ['selected'] ==
                        false) {
                      loadedCategories[loadedCategories.length - 1]
                          ['selected'] = true;
                    } else {
                      loadedCategories[loadedCategories.length - 1]
                          ['selected'] = false;
                    }
                    if (mounted) {
                      setState(() {});
                    }
                  }
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width - 45) / 2,
                  height: 56.w,
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.primary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        loadedCategories[loadedCategories.length - 1]['icon'] !=
                                    '' &&
                                loadedCategories[loadedCategories.length - 1]
                                        ['title'] !=
                                    "Add a category"
                            ? Image.asset(
                                loadedCategories[loadedCategories.length - 1]
                                    ['icon'],
                                width: 24.w,
                                height: 24.w,
                                color: loadedCategories[
                                                loadedCategories.length - 1]
                                            ['selected'] ==
                                        false
                                    ? AppColors.grayLight
                                    : AppColors.primary,
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${loadedCategories[loadedCategories.length - 1]['title']}",
                          style: theme?.bodyLarge?.copyWith(
                              color:
                                  loadedCategories[loadedCategories.length - 1]
                                              ['selected'] ==
                                          false
                                      ? AppColors.grayLight
                                      : AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
