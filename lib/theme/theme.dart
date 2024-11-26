import 'package:color_match_inventory/base/colors.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.white,
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 32,
      fontFamily: "Teachers",
    ),
    titleLarge: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 20,
      fontFamily: "SFProText",
    ),
    bodyMedium: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 18,
      fontFamily: "SFProText",
    ),
    titleMedium: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 15,
      fontFamily: "SFProText",
    ),
    titleSmall: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      fontFamily: "SFProText",
    ),
    bodyLarge: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w700,
      fontSize: 15,
      fontFamily: "SFProText",
    ),
    displayLarge: TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.w400,
      fontSize: 28,
      fontFamily: "Unbounded",
    ),
  ),
);
