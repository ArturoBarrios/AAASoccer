import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:provider/provider.dart';

import '../../models/pageModels/event_page_model.dart';
import '../../styles/colors.dart';
import '../../styles/font_sizes.dart';
import '../../svg_widgets.dart';
import '../Buttons/basic_elevated_button.dart';
import '../Buttons/circle_outline_icon.dart';
import '../join_condition.dart';

class TSNPickupCard extends StatelessWidget {
  final List<Widget> topLeft;
  final List<Widget> topRight;
  final List<Widget> bottomLeft;
  final List<Widget> bottomRight;
  final Color backgroundColor;
  final Svg? svgImage;
  final double? width;
  final double? height;

  TSNPickupCard({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
    required this.backgroundColor,
    this.svgImage,
    this.width,
    this.height,
  });

  

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    //event model data
    dynamic mainEvent =
        context.select<EventPageModel, dynamic>((value) => value.mainEvent);
    dynamic objectImageInput = context.watch<EventPageModel>().objectImageInput;
    List<dynamic> roles =
        context.select<EventPageModel, List<dynamic>>((value) => value.roles);
    bool isMine = context.select<EventPageModel, bool>((value) => value.isMine);
    String startTime = context.select<EventPageModel, String>((value) => value.startTime);
    String endTime = context.select<EventPageModel, String>((value) => value.endTime);    
    bool isMember =
        context.select<EventPageModel, bool>((value) => value.isMember);
    String amountRemaining = context
        .select<EventPageModel, String>((value) => value.amountRemaining);
    String amountPaid =
        context.select<EventPageModel, String>((value) => value.amountPaid);
    String teamAmountRemaining = context
        .select<EventPageModel, String>((value) => value.amountRemaining);
    String teamAmountPaid =
        context.select<EventPageModel, String>((value) => value.teamAmountPaid);
    List userParticipants =
        context.select<EventPageModel, List>((value) => value.userParticipants);
    List teams = context.select<EventPageModel, List>((value) => value.teams);
    List players =
        context.select<EventPageModel, List>((value) => value.players);
    List chats = context.watch<EventPageModel>().chats;
    List payments = context.watch<EventPageModel>().payments;
    List fieldLocations = context.watch<EventPageModel>().fieldLocations;
    dynamic price = context.watch<EventPageModel>().price;
    JoinCondition eventRequestJoin = context.watch<EventPageModel>().eventRequestJoin;
    JoinCondition eventPaymentJoin = context.watch<EventPageModel>().eventPaymentJoin;
    JoinCondition teamRequestJoin = context.watch<EventPageModel>().teamRequestJoin;
    JoinCondition teamPaymentJoin = context.watch<EventPageModel>().teamPaymentJoin;




    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: backgroundColor,
      child: Container(
        width: width,
        height: screenHeight*.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            // ... Image part

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(startTime,
                                    style: TextStyle(
                                      color: AppColors.tsnWhite,                                      
                                      fontSize: FontSizes.xxs(context),
                                    )),
                                // Text("TL 1b"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: AppColors.tsnGreen),
                                Text(
                                  "Philadelphia, PA",
                               style: TextStyle(
                                      color: AppColors.tsnGrey,                                      
                                      fontSize: FontSizes.xxs(context),
                                    )),
                                // Text("TL 2b"),
                              ],
                            ),
                          ],
                        ),  
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                // Text("TR 1a"),
                                // Text("TR 1b"),
                              ],
                            ),
                            Row(
                              children: [
                               
                                  BasicElevatedButton(
                                    icon: Icons.person,
                                    height: screenHeight * 0.05,  // 10% of screen height
                                    width: screenWidth * 0.35,
                                    backgroundColor: AppColors.tsnDarkGrey, text: "5/12"
                                  ),

                                   // price['amount'] == 0 ? 
                                  BasicElevatedButton(
                                    customIcon: SVGWidgets().getSoccerBallSVGImage(),
                                    height: screenHeight * 0.05,  // 10% of screen height
                                    width: screenWidth * 0.35,
                                    backgroundColor: AppColors.tsnGreen, text: "Join"
                                  ),

                                  //  : 

                                // Text("TR 2a"),
                                // Text("TR 2b"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("BL 1a"),
                                Text("BL 1b"),
                              ],
                            ),
                            Row(
                              children: [
                                Text("BL 2a"),
                                Text("BL 2b"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text("BR 1a"),
                                Text("BR 1b"),
                              ],
                            ),
                            Row(
                              children: [
                                Text("BR 2a"),
                                Text("BR 2b"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
