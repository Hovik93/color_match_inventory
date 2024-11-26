// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:color_match_inventory/base/colors.dart';
import 'package:flutter/material.dart';

class TextFieldRadius extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextInputType? inputType;
  final int? maxLines;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged; 

  const TextFieldRadius({
    super.key,
    this.label,
    this.hint,
    this.inputType,
    this.maxLines,
    this.suffixIcon,
    this.controller,
    this.onChanged,
  });

  @override
  State<TextFieldRadius> createState() => _TextFieldRadiusState();
}

class _TextFieldRadiusState extends State<TextFieldRadius> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null && widget.label != ''
            ? Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  widget.label ?? '',
                  style: theme.titleSmall,
                ),
              )
            : const SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextField(
            onChanged: widget.onChanged,
            keyboardType: widget.inputType,
            maxLines: widget.maxLines,
            controller: widget.controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.primary,
                ),
              ),
              hintText: widget.hint,
              hintStyle: theme.titleSmall?.copyWith(
                color: AppColors.black.withOpacity(0.3),
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              suffixIcon: widget.suffixIcon != null
                  ? IconButton(
                      onPressed: () {
                        _selectDate();
                      },
                      icon:
                          widget.suffixIcon ?? const Icon(Icons.calendar_month),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toString().split(' ')[0];
      });
      if (widget.onChanged != null) {
        widget.onChanged!(controller.text); 
      }
    }
  }
}
