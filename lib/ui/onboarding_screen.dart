import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/base/images.dart';
import 'package:color_match_inventory/ui/widget/category_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<Map<String, dynamic>> onBoardingImages = [
    {
      'image': AppImages.onBoardingImage1,
      'text':
          "Effortlessly manage your inventory with our unique color-coding system! Whether it’s for a warehouse, home supplies, or any other space, ColorMatch makes finding and organizing your items a breeze.",
      'index': 0
    },
    {
      'image': AppImages.onBoardingImage2,
      'text':
          "Say goodbye to endless searching! Assign colors to your items for quick identification and easy storage.",
      'index': 1
    },
    {
      'image': AppImages.onBoardingImage3,
      'text':
          "Ready to take control of your inventory? Let's set up your first color-coded category! Tap 'Start' to begin organizing your items efficiently and effortlessly.",
      'index': 2
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: body(),
    );
  }

  Widget body() {
    final TextTheme theme = Theme.of(context).textTheme;
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PageView.builder(
            itemCount: onBoardingImages.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(onBoardingImages[index]['image']),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Expanded(
                      flex: 7,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        // color: Colors.green,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              onBoardingImages[index]['text'],
                              textAlign: TextAlign.start,
                              style: theme.titleMedium,
                            ),
                            index == onBoardingImages.last['index']
                                ? GestureDetector(
                                    onTap: () async {
                                      bool showOnboarding =
                                          await CategoryStorage
                                              .isOnboardingSeen();
                                      if (!showOnboarding) {
                                        // Показать онбординг
                                        await CategoryStorage
                                            .setOnboardingSeen();
                                      }
                                      Navigator.pushReplacementNamed(
                                          context, '/home');
                                    },
                                    child: Container(
                                      height: 44.w,
                                      margin: EdgeInsets.only(
                                        top: 20.w,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primary,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Start',
                                          style: theme.titleLarge
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 20.w,
                                  ),

                            /// dotes
                            Padding(
                              padding: index == onBoardingImages.last['index']
                                  ? EdgeInsets.only(bottom: 10.w)
                                  : EdgeInsets.zero,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ...List.generate(
                                    onBoardingImages.length,
                                    (indexDote) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: 8.w,
                                      height: 8.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: index == indexDote
                                            ? AppColors.primary
                                            : AppColors.primaryLight,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ///
                            // SizedBox(
                            //   height: 20.w,
                            // )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
