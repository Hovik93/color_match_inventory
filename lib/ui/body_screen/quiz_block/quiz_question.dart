// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/ui/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class QuizQuestion extends StatefulWidget {
  String? title;
  QuizQuestion({
    super.key,
    this.title,
  });

  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  List<Map<String, dynamic>> questions = [
    {
      "question": "What colors do you find most calming?",
      "answer": [
        {
          "A": "Blue",
          "point": 1,
        },
        {
          "B": "Green",
          "point": 2,
        },
        {
          "C": "Purple",
          "point": 3,
        },
        {
          "D": "Neutral colors (beige, gray)",
          "point": 4,
        },
      ]
    },
    {
      "question": "Which colors do you feel most energized by?",
      "answer": [
        {
          "A": "Red",
          "point": 1,
        },
        {
          "B": "Yellow",
          "point": 2,
        },
        {
          "C": "Orange",
          "point": 3,
        },
        {
          "D": "Bright colors (pink, turquoise)",
          "point": 4,
        },
      ]
    },
    {
      "question": "How do you prefer to organize your belongings?",
      "answer": [
        {
          "A": "By type (clothes, gadgets, etc.)",
          "point": 1,
        },
        {
          "B": "By color",
          "point": 2,
        },
        {
          "C": "By size",
          "point": 3,
        },
        {
          "D": "By frequency of use",
          "point": 4,
        },
      ]
    },
    {
      "question": "What color do you dislike the most?",
      "answer": [
        {
          "A": "Brown",
          "point": 1,
        },
        {
          "B": "Black",
          "point": 2,
        },
        {
          "C": "Neon colors",
          "point": 3,
        },
        {
          "D": "Other (please specify)",
          "point": 4,
        },
      ]
    },
    {
      "question": "Which best describes your living space?",
      "answer": [
        {
          "A": "Minimalistic with soft colors",
          "point": 1,
        },
        {
          "B": "Colorful and vibrant",
          "point": 2,
        },
        {
          "C": "A mix of both",
          "point": 3,
        },
        {
          "D": "Dark and moody",
          "point": 4,
        },
      ]
    },
    {
      "question": "What colors do you wear most often?",
      "answer": [
        {
          "A": "Earth tones (greens, browns)",
          "point": 1,
        },
        {
          "B": "Pastels (soft pinks, baby blues)",
          "point": 2,
        },
        {
          "C": "Bold colors (red, royal blue)",
          "point": 3,
        },
        {
          "D": "Monochrome (black, white)",
          "point": 4,
        },
      ]
    },
    {
      "question": "What emotion do you want your storage space to evoke?",
      "answer": [
        {
          "A": "Calmness",
          "point": 1,
        },
        {
          "B": "Creativity",
          "point": 2,
        },
        {
          "C": "Energy",
          "point": 3,
        },
        {
          "D": "Sophistication",
          "point": 4,
        },
      ]
    },
    {
      "question":
          "How do you feel about using multiple colors in your organization?",
      "answer": [
        {
          "A": "I love it!",
          "point": 1,
        },
        {
          "B": "A few colors are enough.",
          "point": 2,
        },
        {
          "C": "I prefer one color.",
          "point": 3,
        },
        {
          "D": "It depends on the items.",
          "point": 4,
        },
      ]
    },
    {
      "question": "Which seasonal colors do you gravitate towards?",
      "answer": [
        {
          "A": "Spring pastels",
          "point": 1,
        },
        {
          "B": "Summer bright colors",
          "point": 2,
        },
        {
          "C": "Autumn earthy tones",
          "point": 3,
        },
        {
          "D": "Winter cool tones",
          "point": 4,
        },
      ]
    },
    {
      "question":
          "If you could describe your personal style in one word, what would it be?",
      "answer": [
        {
          "A": "Classic",
          "point": 1,
        },
        {
          "B": "Trendy",
          "point": 2,
        },
        {
          "C": "Eclectic",
          "point": 3,
        },
        {
          "D": "Simple",
          "point": 4,
        },
      ]
    },
  ];

  List<Map<String, dynamic>> results = [
    {
      'minPoint': 10,
      'maxPoint': 15,
      'title': 'Calm & Serene',
      'palette': {
        'Palette': 'Soft blues, greens, and neutrals.',
      },
      'tips': {
        'Tips':
            'Use these colors for calming spaces like bedrooms or reading nooks. Incorporate storage bins in soft colors to reduce stress.',
      }
    },
    {
      'minPoint': 16,
      'maxPoint': 24,
      'title': 'Bright & Energetic',
      'palette': {
        'Palette': 'Bright reds, yellows, and oranges.',
      },
      'tips': {
        'Tips':
            'These colors are perfect for play areas or creative spaces. Use them to highlight frequently accessed items to maintain energy.',
      }
    },
    {
      'minPoint': 25,
      'maxPoint': 33,
      'title': 'Balanced & Classic',
      'palette': {
        'Palette':
            'A mix of warm and cool colors, including browns and beiges.',
      },
      'tips': {
        'Tips':
            'Use classic colors to create a sophisticated environment. Organize items by size within neutral color containers for a timeless look.',
      }
    },
    {
      'minPoint': 34,
      'maxPoint': 40,
      'title': 'Eclectic & Fun',
      'palette': {
        'Palette': 'A vibrant mix of colors, including neons and pastels.',
      },
      'tips': {
        'Tips':
            'Embrace a playful approach to organization. Use colorful labels and bins to make your storage more visually appealing and engaging.',
      }
    },
  ];

  int selectedAnswerIndex = -1;
  int questionNumber = 0;
  int points = 0;
  int tempPoints = 0;

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
        selectedIndex: 3,
      ),
      body: body(theme: theme),
    );
  }

  Widget body({TextTheme? theme}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(questions.length, (index) {
            if (questionNumber == index) {
              return questionsBlock(theme: theme, index: index);
            } else {
              return const SizedBox.shrink();
            }
          }),
          questionNumber >= 10
              ? resultBlock(theme: theme)
              : const SizedBox.shrink(),
          GestureDetector(
            onTap: () {
              if (selectedAnswerIndex != -1 || questionNumber >= 10) {
                if (questionNumber < 10) {
                  ++questionNumber;
                  points = points + tempPoints;
                  selectedAnswerIndex = -1;
                } else {
                  selectedAnswerIndex = -1;
                  questionNumber = 0;
                  points = 0;
                  tempPoints = 0;
                }
              }

              setState(() {});
            },
            child: Container(
              height: 44.w,
              margin: EdgeInsets.symmetric(
                vertical: 20.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: selectedAnswerIndex == -1 && questionNumber < 10
                    ? AppColors.primaryLight
                    : AppColors.primary,
              ),
              child: Center(
                child: Text(
                  questionNumber < 10 ? 'Next' : 'Try again',
                  style: theme?.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget questionsBlock({TextTheme? theme, required int index}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              "${index + 1}. ${questions[index]['question']}",
              style: theme?.bodyMedium?.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ...List.generate(
            questions[index]['answer'].length,
            (i) {
              return GestureDetector(
                onTap: () {
                  selectedAnswerIndex = i;
                  tempPoints = questions[index]['answer'][i]['point'];
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColors.primary,
                    ),
                    color: i == selectedAnswerIndex
                        ? AppColors.primary
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == selectedAnswerIndex
                              ? AppColors.orange
                              : AppColors.gray,
                        ),
                        child: Center(
                          child: Text(
                            questions[index]['answer'][i].keys.first,
                            style: theme?.titleLarge?.copyWith(
                                color: i == selectedAnswerIndex
                                    ? AppColors.white
                                    : AppColors.primary),
                          ),
                        ),
                      ),
                      Text(
                        questions[index]['answer'][i].values.first,
                        style: theme?.bodyMedium?.copyWith(
                            color: i == selectedAnswerIndex
                                ? AppColors.white
                                : AppColors.primary),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget resultBlock({TextTheme? theme}) {
    String title = '';
    String palette = '';
    String paletteValue = '';
    String tips = '';
    String tipsValue = '';
    for (var i = 0; i < results.length; i++) {
      if (points >= results[i]['minPoint'] &&
          points <= results[i]['maxPoint']) {
        title = results[i]['title'];
        palette = results[i]['palette'].keys.first;
        paletteValue = results[i]['palette'].values.first;
        tips = results[i]['tips'].keys.first;
        tipsValue = results[i]['tips'].values.first;
      }
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$points points',
              style: theme?.displayLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                title,
                style: theme?.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '$palette: $paletteValue',
                textAlign: TextAlign.center,
                style: theme?.bodyMedium,
              ),
            ),
            Text(
              '$tips: $tipsValue',
              textAlign: TextAlign.center,
              style: theme?.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
