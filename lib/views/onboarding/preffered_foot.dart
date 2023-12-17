import 'package:flutter/material.dart';
import 'package:soccermadeeasy/styles/colors.dart';

enum PreferredFoot { left, right }

class FootSelection extends StatelessWidget {
  const FootSelection({Key? key, this.onTapPreferredFoot, this.selectedFoot})
      : super(key: key);

  final Function(PreferredFoot)? onTapPreferredFoot;
  final PreferredFoot? selectedFoot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onTapPreferredFoot?.call(PreferredFoot.left),
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(right: 8), // Right margin for padding
                decoration: BoxDecoration(
                  color: selectedFoot == PreferredFoot.left
                      ? AppColors.tsnGreen
                      : AppColors.tsnGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.directions_walk, color: Colors.black),
                    Text(
                      'Left', 
                      style: TextStyle(
                        color: selectedFoot == PreferredFoot.left ? AppColors.tsnWhite : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onTapPreferredFoot?.call(PreferredFoot.right),
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(left: 8), // Left margin for padding
                decoration: BoxDecoration(
                  color: selectedFoot == PreferredFoot.right
                      ? AppColors.tsnGreen
                      : AppColors.tsnGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.directions_walk, color: Colors.black),
                    Text(
                      'Right', 
                      style: TextStyle(
                        color: selectedFoot == PreferredFoot.right ? AppColors.tsnWhite : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
