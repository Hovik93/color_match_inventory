// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:color_match_inventory/ui/home.dart';
import 'package:flutter/material.dart';

import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/base/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class BottomNavigationBarWidget extends StatefulWidget {
  int selectedIndex;
  BottomNavigationBarWidget({
    super.key,
    required this.selectedIndex,
  });

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  void onTap(int index) {
    if (widget.selectedIndex != index) {
      setState(() {
        widget.selectedIndex = index;
      });
    }

    if (index == 2) {}

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(selectedIndex: index),
      ),
      (route) => false, 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: BottomNavigationBar(
          backgroundColor: AppColors.white,
          currentIndex: widget.selectedIndex,
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
                  color: widget.selectedIndex == 0
                      ? AppColors.orange
                      : AppColors.grayLight,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  AppImages.info,
                  width: 22.w,
                  height: 22.w,
                  color: widget.selectedIndex == 1
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
                  color: widget.selectedIndex == 3
                      ? AppColors.orange
                      : AppColors.grayLight,
                ),
                label: 'Setting'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  AppImages.setting,
                  width: 22.w,
                  height: 22.w,
                  color: widget.selectedIndex == 4
                      ? AppColors.orange
                      : AppColors.grayLight,
                ),
                label: 'Setting'),
          ],
        ),
      ),
    );
  }
}
