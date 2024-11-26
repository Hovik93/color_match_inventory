import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/ui/body_screen/quiz_block/quiz_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Quiz',
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Center(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Color-Coding Quiz',
                style: theme?.displayLarge,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  'Instructions',
                  style: theme?.bodyLarge,
                ),
              ),
              Text(
                'Answer the following questions honestly to discover your ideal color palette and organization tips. Choose the option that best reflects your preferences.',
                textAlign: TextAlign.center,
                style: theme?.titleMedium,
              ),
            ],
          ))),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return QuizQuestion(
                  title: 'Quiz',
                );
              }));
            },
            child: Container(
              height: 44.w,
              margin: EdgeInsets.symmetric(
                vertical: 20.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary,
              ),
              child: Center(
                child: Text(
                  'Start',
                  style: theme?.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
