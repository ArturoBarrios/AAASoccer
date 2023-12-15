import 'package:flutter/material.dart';

import '../styles/colors.dart';

class SelectionListWidget extends StatelessWidget {
  final List<Map<String, String>> selections;
  final Function(int) onTap;
  final int selectedIndex;

  const SelectionListWidget({
    Key? key,
    required this.selections,
    required this.onTap,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("CustomSelectableChipList build()");
    print("selections: " + selections.toString());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
        itemCount: selections.length,
        itemBuilder: (BuildContext context, int index) {
          final item = selections[index];
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: selectedIndex == index ? AppColors.tsnGreen : AppColors.tsnGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: item['title']!='' ? item['title']! + ': ' : '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: item['description'] ?? '',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
