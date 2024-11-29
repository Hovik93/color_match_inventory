import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/ui/widget/category_storage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a time-consuming task (e.g., loading data) for the splash screen.
    // Replace this with your actual data loading logic.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool showOnboarding = await CategoryStorage.isOnboardingSeen();
      if (!showOnboarding) {
        Navigator.pushReplacementNamed(context, '/onBoarding');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });

    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/onBoarding');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'ColorMatch Inventory',
            style: theme.headlineLarge?.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
