import 'package:flutter/material.dart';
import 'package:soccermadeeasy/styles/colors.dart';
import 'package:collection/collection.dart';

import 'custom_tile_list_with_title.dart';
import 'models/button_model.dart';
import 'models/tile_list_model.dart';

class UserChatOptionsBottomSheet extends StatelessWidget {
  const UserChatOptionsBottomSheet({
    Key? key,
    this.title,
    this.addNewChatButton,
    this.chatButton,
    this.chatList,
    this.currentUserId,
  }) : super(key: key);

  /// Title text.
  final String? title;

  /// Add new button.
  final ButtonModel? addNewChatButton;

  /// Chat button.
  final ButtonModel? chatButton;

  final List<dynamic>? chatList;

  final String? currentUserId;

  @override
  Widget build(final BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                Container(
                  height: 5,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: AppColors.grayColor,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (title != null) Text(title ?? ''),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: addNewChatButton?.onTap,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(Icons.add, color: Colors.green),
                            Text(
                              addNewChatButton?.text ?? '',
                              style: const TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (chatList != null)
                  CustomTileListWithTitle(
                      tileModelList: chatList
                              ?.mapIndexed((final index, final chat) {
                            final isAdded = List.from(chat['users']['data'])
                                .any((element) =>
                                    element['_id'] == currentUserId);

                            return TileListModel(
                              buttonList: [
                                ButtonModel(
                                  text: chat['name'],
                                  prefixIconData: Icons.chat,
                                  suffixIconData: isAdded ? Icons.done : null,
                                  onTap: () => chatButton?.onTapReturnWithValue
                                      ?.call(index),
                                ),
                              ],
                            );
                          }).toList() ??
                          []),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      );
}
