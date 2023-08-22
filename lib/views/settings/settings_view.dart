import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/models/button_model.dart';
import 'package:soccermadeeasy/styles/colors.dart';

import '../../components/custom_tile_list.dart';
import '../../components/custom_tile_list_with_title.dart';
import '../../components/models/tile_list_model.dart';
import '../home.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  void onTapHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Stack(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => onTapHome(context),
                  icon: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: const [
                    SizedBox(width: 20),
                    Text(
                      'Settings',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomTileListWithTitle(
                      tileModelList: [
                        TileListModel(
                          title: 'GENERAL',
                          buttonList: [
                            ButtonModel(
                              text: 'Account',
                              prefixIconData: Icons.person,
                              onTap: () {},
                            ),
                            ButtonModel(
                              text: 'Notifications',
                              prefixIconData: Icons.notifications,
                              onTap: () {},
                            ),
                          ],
                        ),
                        TileListModel(
                          title: 'FEEDBACK',
                          buttonList: [
                            ButtonModel(
                              text: 'Report a bug',
                              prefixIconData: Icons.warning_amber_rounded,
                              onTap: () {},
                            ),
                            ButtonModel(
                              text: 'Send feedback',
                              prefixIconData: Icons.send,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomTileList(
                tileList: [
                  ButtonModel(
                    text: 'Delete',
                    prefixIconData: Icons.delete,
                    backgroundColor: AppColors.redColorShade200,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
