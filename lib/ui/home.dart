// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/base/images.dart';
import 'package:color_match_inventory/ui/body_screen/add_screen.dart';
import 'package:color_match_inventory/ui/body_screen/home_screen.dart';
import 'package:color_match_inventory/ui/body_screen/info_screen.dart';
import 'package:color_match_inventory/ui/body_screen/quiz_screen.dart';
import 'package:color_match_inventory/ui/body_screen/setting_screen.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  int? selectedIndex;
  HomePage({
    super.key,
    this.selectedIndex,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final list = [
    const HomeScreen(),
    const InfoScreen(),
    AddScreen(
      title: 'Home',
    ),
    const QuizScreen(),
    const SettingScreen(),
  ];

  int? _selectedIndex = 0;

  void onTap(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.selectedIndex != null) {
      _selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: BottomNavigationBar(
            backgroundColor: AppColors.white,
            currentIndex: _selectedIndex ?? 0,
            elevation: 0,
            selectedFontSize: 0,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: AppColors.orange,
            selectedIconTheme: IconThemeData(color: AppColors.orange),
            onTap: onTap,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    AppImages.home,
                    width: 22.w,
                    height: 22.w,
                    color: _selectedIndex == 0 || _selectedIndex == 2
                        ? AppColors.orange
                        : AppColors.grayLight,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    AppImages.info,
                    width: 22.w,
                    height: 22.w,
                    color: _selectedIndex == 1
                        ? AppColors.orange
                        : AppColors.grayLight,
                  ),
                  label: 'Favorite'),
              BottomNavigationBarItem(
                icon: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.primary, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(14),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    AppImages.quiz,
                    width: 22.w,
                    height: 22.w,
                    color: _selectedIndex == 3
                        ? AppColors.orange
                        : AppColors.grayLight,
                  ),
                  label: 'Setting'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    AppImages.setting,
                    width: 22.w,
                    height: 22.w,
                    color: _selectedIndex == 4
                        ? AppColors.orange
                        : AppColors.grayLight,
                  ),
                  label: 'Setting'),
            ],
          ),
        ),
      ),
    );
  }

  Widget body() {
    return list[_selectedIndex ?? 0];
  }
}
