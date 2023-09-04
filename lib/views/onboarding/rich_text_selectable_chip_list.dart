import 'package:flutter/material.dart';

import 'rich_text_selectable_chip.dart';

class RichTextSelectableChipList extends StatelessWidget {
  const RichTextSelectableChipList({
    Key? key,
    required this.richTextList,
    this.selectedIndex,
    this.onTap,
  }) : super(key: key);

  final List<List<TextSpan>> richTextList;

  final int? selectedIndex;

  final void Function(int)? onTap;

  @override
  Widget build(final BuildContext context) => ListView.separated(
        itemCount: richTextList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (final context, final index) =>
            const SizedBox(height: 10),
        itemBuilder: (final _, final index) => RichTextSelectableChip(
          richText: richTextList[index],
          isSelected: selectedIndex == index,
          onTap: () => onTap?.call(index),
        ),
      );
}
