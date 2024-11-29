import 'package:color_match_inventory/ui/home.dart';
import 'package:color_match_inventory/ui/onboarding_screen.dart';

final routes = {
  '/onBoarding': (context) => const OnBoardingScreen(),
  '/home': (context) => HomePage(),
  // '/home': (context) {
  //   final args = (ModalRoute.of(context)!.settings.arguments ?? 0) as int;
  //   return HomePage(selectedIndex: args);
  // },

  // '/add_work': (context) => const AddWork(),
};
