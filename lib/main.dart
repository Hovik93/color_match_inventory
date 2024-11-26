import 'package:color_match_inventory/router/router.dart';
import 'package:color_match_inventory/theme/theme.dart';
import 'package:color_match_inventory/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ColorMatch Inventory',
            theme: lightTheme,
            home: const SplashScreen(),
            routes: routes,
          );
        });
  }
}
