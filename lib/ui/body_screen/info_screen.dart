import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/ui/body_screen/info_block/articles_on_color_psychology.dart';
import 'package:color_match_inventory/ui/body_screen/info_block/database_of_materials.dart';
import 'package:color_match_inventory/ui/body_screen/info_block/guides_on_organization.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  List<String> informationList = [
    'Guides on Organization',
    'Database of Materials',
    'Articles on Color Psychology',
  ];
  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Row(
          children: [
            Text(
              'Information materials',
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
          informationList.length,
          (index) => InkWell(
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return GuidesOnOrganization(
                      title: "Information materials",
                    );
                  }));
                  break;
                case 1:
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DatabaseOfMaterials(
                      title: "Information materials",
                    );
                  }));
                  break;
                case 2:
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ArticlesOnColorPsychology(
                      title: "Information materials",
                    );
                  }));
                  break;
                default:
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    informationList[index],
                    style: theme?.bodyMedium,
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
