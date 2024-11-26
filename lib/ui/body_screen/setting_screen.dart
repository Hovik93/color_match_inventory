import 'package:color_match_inventory/base/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<Map<String, String>> settingsList = [
    {'title': 'Privacy & Security', 'icon': AppImages.privacySecurity},
    {'title': 'User Agreement', 'icon': AppImages.userAgreement},
    {'title': 'Leave feedbac', 'icon': AppImages.leaveFeedback},
  ];

  final InAppReview inAppReview = InAppReview.instance;

  _launchURL({required String urlLink}) async {
    final Uri url = Uri.parse(urlLink);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Settings',
              style: theme.titleLarge,
            ),
          ],
        ),
      ),
      body: body(theme: theme),
    );
  }

  Widget body({TextTheme? theme}) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: List.generate(
          settingsList.length,
          (index) => InkWell(
            onTap: () async {
              switch (index) {
                case 0:
                  _launchURL(urlLink: 'https://www.doorward.com/privacy');
                  break;
                case 1:
                  _launchURL(
                      urlLink:
                          'https://play.google.com/store/apps/details?id=com.digitalpomegranate.doorward.Doorward&hl=en');
                  break;
                case 2:
                  if (await inAppReview.isAvailable()) {
                    inAppReview.requestReview();
                  }
                  break;
                default:
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        settingsList[index]['icon'] ?? '',
                        width: 35.w,
                        height: 35.w,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        settingsList[index]['title'] ?? '',
                        style: theme?.bodyMedium,
                      ),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
