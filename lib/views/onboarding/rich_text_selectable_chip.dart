import 'package:flutter/material.dart';
import 'package:soccermadeeasy/styles/colors.dart';

class RichTextSelectableChip extends StatelessWidget {
  const RichTextSelectableChip(
      {Key? key, this.richText, this.onTap, this.isSelected = false})
      : super(key: key);

  final List<TextSpan>? richText;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.orangeColorShade500 : AppColors.grayColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: RichText(
          text: TextSpan(
            children: richText,
          ),
        ),
      ),
    );
  }
}
