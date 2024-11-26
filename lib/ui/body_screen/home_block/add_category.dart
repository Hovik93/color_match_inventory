// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/base/images.dart';
import 'package:color_match_inventory/ui/widget/bottom_navigation_bar.dart';
import 'package:color_match_inventory/ui/widget/text_field_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AddCategory extends StatefulWidget {
  String? title;
  AddCategory({
    super.key,
    this.title,
  });

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  int selectedIndex = -1;
  Map<String, dynamic> createCategory = {};
  TextEditingController controller = TextEditingController();
  List<dynamic> iconsList = [
    '',
    AppImages.cloth,
    AppImages.sports,
    AppImages.work,
    AppImages.kitchen,
    AppImages.inventory,
    AppImages.electronic,
    AppImages.homeIcon,
    AppImages.dishes,
    AppImages.day,
    AppImages.night,
    AppImages.food,
    AppImages.transport,
    AppImages.sale,
    AppImages.pets,
    AppImages.cosmetic,
    AppImages.medicine,
    AppImages.book,
    AppImages.files,
    AppImages.closet,
    AppImages.pantry,
    AppImages.shopping,
    AppImages.men,
    AppImages.women,
    'null',
    AppImages.season,
    AppImages.chemicals,
    AppImages.photo,
    AppImages.like,
    'null',
  ];

  List<int> colorTemporaryList = [
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
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text('Name', style: theme?.bodyMedium),
                  ),
                  TextFieldRadius(
                    hint: "Name",
                    controller: controller,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 15),
                    child: Text('Screensaver', style: theme?.bodyMedium),
                  ),
                  SizedBox(
                    height: 255.w,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6, // 3 columns
                        mainAxisSpacing: 8, // spacing between rows
                        crossAxisSpacing: 15, // spacing between columns
                      ),
                      itemCount: iconsList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (iconsList[index] != 'null') {
                              selectedIndex = index;
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: iconsList[index] == 'null'
                                  ? Colors.transparent
                                  : selectedIndex == index
                                      ? AppColors.primary
                                      : AppColors.gray,
                            ),
                            height: 44.w,
                            width: 44.w,
                            child: iconsList[index] == '' ||
                                    iconsList[index] == 'null'
                                ? const SizedBox.shrink()
                                : Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Image.asset(
                                        iconsList[index],
                                        color: selectedIndex == index
                                            ? AppColors.white
                                            : AppColors.primaryLight,
                                      ),
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (selectedIndex != -1) {
                if (iconsList[selectedIndex] == '') {
                  createCategory = {
                    'title': controller.text,
                    'icon': '',
                    'crossAxisCount': 2,
                    'mainAxisCount': 2,
                    'selected': false,
                  };
                } else {
                  createCategory = {
                    'title': controller.text,
                    'icon': '${iconsList[selectedIndex]}',
                    'crossAxisCount': 2,
                    'mainAxisCount': 2,
                    'selected': false,
                  };
                }
                Navigator.pop(context, createCategory);
              }
            },
            child: Container(
              height: 44.w,
              margin: EdgeInsets.symmetric(
                vertical: 20.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: selectedIndex != -1
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
    );
  }
}
