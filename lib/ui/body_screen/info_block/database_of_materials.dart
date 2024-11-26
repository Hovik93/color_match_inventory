// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/ui/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DatabaseOfMaterials extends StatefulWidget {
  String? title;
  DatabaseOfMaterials({
    super.key,
    this.title,
  });

  @override
  State<DatabaseOfMaterials> createState() => _DatabaseOfMaterialsState();
}

class _DatabaseOfMaterialsState extends State<DatabaseOfMaterials> {
  List<Map<String, dynamic>> data = [
    {
      "title": "Textiles",
      "child": [
        {
          "title_child": "Color Absorption",
          "body_child":
              "Fabrics absorb and reflect light differently, impacting color perception. For example, lighter fabrics reflect more light and can make spaces feel airy, while darker textiles absorb light, creating a cozy atmosphere.",
        },
        {
          "title_child": "Patterns and Texture",
          "body_child":
              "The texture of textiles, such as smooth silk versus rough burlap, affects the way colors appear. Patterns can add visual interest but may complicate color coordination. When organizing, consider solid-colored textiles for a streamlined look or mix patterns for a more eclectic feel.",
        },
        {
          "title_child": "Durability and Care",
          "body_child":
              "Different textiles require varying maintenance levels, influencing their placement. For high-traffic areas, durable fabrics like polyester or canvas in darker shades are practical choices, while delicate fabrics may be better suited for decorative pillows or drapes.",
        }
      ]
    },
    {
      "title": "Metals",
      "child": [
        {
          "title_child": "Reflectivity and Finish",
          "body_child":
              "Metals can enhance or alter color perception due to their reflective properties. Polished metals, like chrome or stainless steel, reflect surrounding colors, creating a dynamic visual effect. Matte finishes absorb light and can provide a more subdued color palette.",
        },
        {
          "title_child": "Color Coordination",
          "body_child":
              "Metal finishes can either blend seamlessly with color schemes or stand out as statement pieces. For example, brass or gold fixtures can add warmth and elegance to a space, while silver or black metals might offer a more modern, sleek look.",
        },
        {
          "title_child": "Weight and Stability",
          "body_child":
              "Metals are often heavier than other materials, which can affect how they are used in organization. Ensure that shelves or storage units made of metal are properly anchored to prevent tipping, especially when organizing heavier items.",
        }
      ]
    },
    {
      "title": "Plastics",
      "child": [
        {
          "title_child": "Versatility in Color",
          "body_child":
              "Plastics come in a wide range of colors and finishes, making them an ideal choice for colorful organizational tools. They can be molded into various shapes and sizes, allowing for creative storage solutions.",
        },
        {
          "title_child": "Lightweight and Durable",
          "body_child":
              "Plastic storage bins are lightweight and easy to move, making them perfect for flexible organization. They can also be waterproof, ideal for areas prone to spills or moisture.",
        },
        {
          "title_child": "Sustainability Considerations",
          "body_child":
              "With growing awareness of environmental issues, choosing recycled or eco-friendly plastics can influence consumer choices. Clear plastic containers can help maintain a clean look while allowing for color coding through labels or colored contents.",
        }
      ]
    },
    {
      "title": "Wood",
      "child": [
        {
          "title_child": "Natural Aesthetics",
          "body_child":
              "Wood adds warmth and texture to a space. Different wood finishes can dramatically affect the perceived color scheme of a room. For example, light woods (like pine) create a more casual feel, while dark woods (like mahogany) can add sophistication.",
        },
        {
          "title_child": "Finish and Treatment",
          "body_child":
              "The finish of the wood (oiled, varnished, painted) influences color perception and maintenance. Painted wood can introduce a bold pop of color, while natural finishes allow the grain to show through, enhancing the organic look.",
        },
        {
          "title_child": "Weight and Structure",
          "body_child":
              "Wooden furniture is typically sturdier and can support heavier items, making it a good choice for organizing books or collectibles. However, heavier wood may require stronger wall anchors or floor supports.",
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
                'Database of Materials',
                style: theme?.bodyLarge?.copyWith(fontSize: 18),
              ),
            ),
            Text(
              'Understanding how various materials interact with color and organization can significantly enhance the functionality and aesthetics of your space. Here’s an overview of common materials and their characteristics.',
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
