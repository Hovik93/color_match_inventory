// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/ui/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GuidesOnOrganization extends StatefulWidget {
  String? title;
  GuidesOnOrganization({
    super.key,
    this.title,
  });

  @override
  State<GuidesOnOrganization> createState() => _GuidesOnOrganizationState();
}

class _GuidesOnOrganizationState extends State<GuidesOnOrganization> {
  List<Map<String, dynamic>> data = [
    {
      "title": "Color-Coded Organization",
      "tip":
          "When organizing clothes, hang similar colors together in your wardrobe. This not only saves time when choosing outfits but also adds a pleasing aesthetic to your closet.",
      "child": [
        {
          "title_child": "Visual Appeal",
          "body_child":
              "Using color to organize items can make your space look cohesive and visually appealing. For instance, arranging books or files by color can transform a cluttered shelf into a work of art.",
        },
        {
          "title_child": "Quick Identification",
          "body_child":
              "Color coding makes it easier to locate items quickly. For example, designate a specific color for each category (e.g., red for urgent documents, blue for personal items) to streamline searches.",
        }
      ]
    },
    {
      "title": "Organizing by Type",
      "tip":
          "Label containers clearly to indicate contents, making it easier to find and return items to their proper place.",
      "child": [
        {
          "title_child": "Group Similar Items",
          "body_child":
              "Keep items of the same type together. For example, group all kitchen utensils in one drawer or container, and store all cleaning supplies in one area.",
        },
        {
          "title_child": "Use Appropriate Containers",
          "body_child":
              "Choose storage containers that suit the type of items being stored. Clear bins for craft supplies allow you to see contents at a glance, while sturdy boxes can hold heavier items.",
        }
      ]
    },
    {
      "title": "Seasonal Rotation",
      "tip":
          "Use this time to reorganize your closet by color, making it easier to find appropriate attire for the upcoming season.",
      "child": [
        {
          "title_child": "Adapt Organization to Seasons",
          "body_child":
              "Rotate seasonal items, such as clothing or decor, to keep your space organized. Store out-of-season clothes in labeled bins and place seasonal items where they are easily accessible.",
        },
        {
          "title_child": "Declutter Regularly",
          "body_child":
              "Take the opportunity during seasonal changes to declutter. Assess items that haven’t been used in the past season and consider donating or discarding them.",
        }
      ]
    },
    {
      "title": "Utilize Vertical Space",
      "tip":
          "In the kitchen, use vertical storage for spices or utensils. Group items by color or function to create a visually appealing arrangement.",
      "child": [
        {
          "title_child": "Maximize Storage",
          "body_child":
              "Install shelves or wall-mounted organizers to make use of vertical space. This is especially useful for smaller rooms where floor space is limited.",
        },
        {
          "title_child": "Hang Items",
          "body_child":
              "Use hooks or pegboards to hang tools, bags, or accessories. Colorful items can also add decor while keeping everything organized.",
        }
      ]
    },
    {
      "title": "Digital Organization",
      "tip":
          "Regularly review and delete unnecessary files or photos to maintain an organized digital space.",
      "child": [
        {
          "title_child": "Organize Files and Photos",
          "body_child":
              "Just as with physical items, color coding can be applied to digital files. Use folders with color codes to differentiate between work, personal, and important documents.",
        },
        {
          "title_child": "Tagging and Naming",
          "body_child":
              "Use descriptive names and tags for files to make them easily searchable. For photos, consider tagging based on events or colors to streamline organization.",
        }
      ]
    },
    {
      "title": "Maintain Organization",
      "tip":
          "Make it a family activity to review and organize shared spaces, reinforcing the importance of maintaining an orderly environment.",
      "child": [
        {
          "title_child": "Set a Routine",
          "body_child":
              "Develop a habit of returning items to their designated spots after use. This minimizes clutter and keeps your space organized.",
        },
        {
          "title_child": "Regularly Review",
          "body_child":
              "Schedule time monthly or seasonally to reassess your organization system. Adjust it as necessary to accommodate new items or changes in your lifestyle.",
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
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Guides on Organization',
                style: theme?.bodyLarge?.copyWith(fontSize: 18),
              ),
            ),
            Text(
              'Effective organization not only enhances the aesthetics of your space but also improves functionality and accessibility. Here are some tips and recommendations to help you organize your belongings based on color and type.',
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
