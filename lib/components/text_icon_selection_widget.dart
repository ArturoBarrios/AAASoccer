import 'package:flutter/material.dart';

import '../styles/colors.dart';

class TextIconSelectionWidget extends StatelessWidget {
  final List<dynamic> items;
  final Function(String) onTap;
  final dynamic selectedItem;

  const TextIconSelectionWidget({
    Key? key,
    required this.items,
    required this.onTap,
    required this.selectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        bool isSelected = selectedItem == items[index];

        return GestureDetector(
          onTap: () => onTap(items[index]),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.tsnGreen : AppColors.tsnAlmostBlack,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColors.tsnGreen : AppColors.tsnAlmostBlack,
              ),
            ),
            child: Text(
              items[index],
              style: TextStyle(                
                fontSize: 16,
                color: AppColors.tsnWhite
              ),
            ),
          ),
        );
      },
    );
  }
}
