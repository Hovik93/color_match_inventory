// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:color_match_inventory/base/colors.dart';
import 'package:color_match_inventory/ui/body_screen/add_thing/new_thing.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddScreen extends StatefulWidget {
  String? title;
  AddScreen({
    super.key,
    this.title,
  });

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => NewThing(
            title: 'Home',
          ),
        ),
      );
    });
    super.initState();
  }

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
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: body(theme: theme),
    );
  }

  Widget body({TextTheme? theme}) {
    return Container();
  }
}
