import 'package:flutter/material.dart';
import 'package:soccermadeeasy/styles/colors.dart';

import '../../components/models/button_model.dart';

class CustomTileList extends StatelessWidget {
  const CustomTileList({
    Key? key,
    this.tileList,
    this.selectedIndex,
  }) : super(key: key);

  final List<ButtonModel>? tileList;
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tileList?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (final _, final index) => ListTile(
        dense: true,
        minLeadingWidth: 1,
        contentPadding: EdgeInsets.zero,
        tileColor: selectedIndex == index
            ? AppColors.orangeColorShade500
            : tileList?[index].backgroundColor,
        leading: Icon(tileList?[index].prefixIconData),
        title: Text(
          tileList?[index].text ?? '',
        ),
        trailing: Icon(
            tileList?[index].suffixIconData ?? Icons.arrow_forward_ios_rounded),
        onTap: tileList?[index].onTap,
      ),
    );
  }
}
