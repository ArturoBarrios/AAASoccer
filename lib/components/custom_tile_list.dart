import 'package:flutter/material.dart';

import '../../components/models/button_model.dart';

class CustomTileList extends StatelessWidget {
  const CustomTileList({
    Key? key,
    this.tileList,
  }) : super(key: key);

  final List<ButtonModel>? tileList;

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
        tileColor: tileList?[index].backgroundColor,
        leading: Icon(tileList?[index].prefixIconData ?? Icons.person),
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
