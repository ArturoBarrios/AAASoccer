import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/models/button_model.dart';
import 'package:soccermadeeasy/styles/colors.dart';

import '../../commands/base_command.dart';
import '../../components/Buttons/basic_elevated_button.dart';
import '../../components/Dialogues/bug_feedback_dialogue.dart';
import '../../components/custom_tile_list.dart';
import '../../components/custom_tile_list_with_title.dart';
import '../../components/headers.dart';
import '../../components/models/tile_list_model.dart';
import '../../styles/font_sizes.dart';
import '../account_details_update.dart';
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
      appBar: Headers(
              playerStepperButton: ButtonModel(
                prefixIconData: Icons.play_circle_fill_rounded,
                onTap: () {},
              ),
            ).getMainHeader(context),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   color: Colors.blue,
              //   padding: const EdgeInsets.symmetric(vertical: 20),
              //   child: Row(
              //     children: const [
              //       SizedBox(width: 20),
              //       Text(
              //         'Settings',
              //         style:
              //             TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              //       ),
              //     ],
              //   ),
              // ),
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
                              text: 'Update Account Details',
                              prefixIconData: Icons.person,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                         AccountDetailsUpdate(),
                                  ),
                                );
                              
                              },
                            ),
                            // ButtonModel(
                            //   text: 'Notifications',
                            //   prefixIconData: Icons.notifications,
                            //   onTap: () {},
                            // ),
                          ],
                        ),
                        // TileListModel(
                        //   title: 'FEEDBACK',
                        //   buttonList: [
                        //     ButtonModel(
                        //       text: 'Report a bug',
                        //       prefixIconData: Icons.warning_amber_rounded,
                        //       onTap: () {
                        //         showDialog(
                        //           context: context,
                        //           builder: (BuildContext context) {
                        //             return BugFeedbackWidget(
                        //               onSubmitCallback: () {
                        //                 // Logic for submit action
                        //               },
                        //               onCancelCallback: () {
                        //                 // Logic for cancel action
                        //               },
                        //             );
                        //           },
                        //         );
                        //       },
                        //     ),
                        //     ButtonModel(
                        //       text: 'Send feedback',
                        //       prefixIconData: Icons.send,
                        //       onTap: () {},
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Align(
          //     alignment: Alignment.bottomCenter,
          //     child: CustomTileList(
          //       tileList: [
          //         ButtonModel(
          //           text: 'Delete',
          //           prefixIconData: Icons.delete,
          //           backgroundColor: AppColors.redColorShade200,
          //           onTap: () {},
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
      bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(
                  top: 26.0, bottom: 16.0, left: 16.0, right: 16.0),
              child:BasicElevatedButton(
    backgroundColor: AppColors.tsnRed,
    text: "Delete Account",
    fontSize: FontSizes.s(context),
    onPressed: () async {
      BaseCommand().delete(context);
    },
  ))
    );
  }
}
