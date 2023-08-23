import 'package:flutter/material.dart';

import 'custom_tile_list.dart';
import 'models/tile_list_model.dart';

class CustomTileListWithTitle extends StatelessWidget {
  const CustomTileListWithTitle({
    Key? key,
    this.tileModelList,
  }) : super(key: key);

  final List<TileListModel>? tileModelList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tileModelList?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (final _, final index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tileModelList?[index].title ?? '',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          CustomTileList(
            tileList: tileModelList?[index].buttonList,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
