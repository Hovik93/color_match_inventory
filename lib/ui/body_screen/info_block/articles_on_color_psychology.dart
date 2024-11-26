// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/ui/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ArticlesOnColorPsychology extends StatefulWidget {
  String? title;
  ArticlesOnColorPsychology({
    super.key,
    this.title,
  });

  @override
  State<ArticlesOnColorPsychology> createState() =>
      _ArticlesOnColorPsychologyState();
}

class _ArticlesOnColorPsychologyState extends State<ArticlesOnColorPsychology> {
  List<Map<String, dynamic>> data = [
    {
      "title": "The Impact of Color on Perception",
      "child": [
        {
          "title_child": "Warm Colors",
          "body_child":
              "Colors like red, orange, and yellow tend to create an inviting and energizing atmosphere. However, they can also stimulate feelings of excitement or anxiety, depending on their intensity. Warm colors can be effective in spaces where activity is desired, but they may not be the best choice for storage areas that require calmness and focus.",
        },
        {
          "title_child": "Cool Colors",
          "body_child":
              "Blues, greens, and purples are often associated with calmness, relaxation, and tranquility. These colors can create a serene environment, making them ideal for spaces where organization and clarity are needed. They can help reduce stress and enhance concentration, making them perfect for areas dedicated to work or study.",
        },
        {
          "title_child": "Neutral Colors",
          "body_child":
              "Grays, beiges, and whites serve as versatile backdrops that can help other colors pop. Neutral tones promote balance and can create a clean, organized look. They are often used in storage solutions to provide a sophisticated and unobtrusive aesthetic.",
        }
      ]
    },
    {
      "title": "Colors and Organization",
      "child": [
        {
          "title_child": "Color Coding",
          "body_child":
              "Implementing a color-coded organization system can enhance efficiency and ease of access. For instance, using different colors for storage bins or labels can help categorize items, making it easier to locate them quickly. This technique not only improves visual clarity but also reduces cognitive load, making the organizational system more intuitive.",
        },
        {
          "title_child": "Creating Zones",
          "body_child":
              "Different colors can define specific areas within a space. For example, using blue for work-related items and green for relaxation can create a visual separation that enhances functionality. This zoning can help users mentally transition between tasks and encourage better organization.",
        },
        {
          "title_child": "Enhancing Visibility",
          "body_child":
              "Bright, vibrant colors can improve visibility, making it easier to find items in storage. Choosing colors that contrast well with their surroundings can help prevent items from blending into the background.",
        }
      ]
    },
    {
      "title": "Choosing a Color Scheme for Storage",
      "child": [
        {
          "title_child": "Consider the Space",
          "body_child":
              "Before selecting colors, consider the size and natural lighting of the space. Lighter colors can make small spaces appear larger and more open, while darker colors may create a cozy, intimate environment.",
        },
        {
          "title_child": "Personal Preferences",
          "body_child":
              "Individual preferences play a crucial role in color selection. Choose colors that resonate with you and evoke positive emotions. Consider your lifestyle and the feelings you want to promote within the space.",
        },
        {
          "title_child": "Functionality Over Aesthetics",
          "body_child":
              "While aesthetics are important, prioritize functionality. Choose colors that not only look good but also enhance the usability of the storage system. For example, bright colors for frequently accessed items can improve visibility and organization.",
        }
      ]
    }
  ];
  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          widget.title ?? '',
          style: theme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 1,
      ),
      body: body(theme: theme),
    );
  }

  Widget body({TextTheme? theme}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(
                'Articles on Color Psychology',
                style: theme?.bodyLarge?.copyWith(fontSize: 18),
              ),
            ),
            Text(
              'Understanding Color Psychology',
              style: theme?.bodyLarge?.copyWith(fontSize: 15),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Color psychology explores how colors impact human emotions, perceptions, and behaviors. It plays a significant role in design, influencing how we experience spaces and how organized we feel within them. Different colors evoke specific feelings and can be strategically used to create a desired atmosphere or enhance functionality in storage solutions.',
              style: theme?.titleMedium,
            ),
            ...List.generate(
              data.length,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${index + 1}. ${data[index]['title']}',
                    style: theme?.bodyLarge?.copyWith(fontSize: 18),
                  ),
                  ...List.generate(
                    data[index]['child'].length,
                    (childIndex) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: Text(
                            "${data[index]['child'][childIndex]['title_child']}:",
                            style: theme?.titleMedium,
                          ),
                        ),
                        Text(
                          data[index]['child'][childIndex]['body_child'],
                          style: theme?.titleMedium,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
