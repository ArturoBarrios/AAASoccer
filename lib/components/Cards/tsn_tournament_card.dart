import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:provider/provider.dart';

import '../../models/pageModels/event_page_model.dart';
import '../../styles/colors.dart';
import '../../styles/font_sizes.dart';
import '../../svg_widgets.dart';
import '../../views/game/view.dart';
import '../../views/tournament/view.dart';
import '../Buttons/basic_elevated_button.dart';
import '../Buttons/circle_outline_icon.dart';
import '../get_join_event_widget.dart';
import '../join_condition.dart';

class TSNTournamentCard extends StatelessWidget {
  final dynamic tournamentCardDetails;
  final Color backgroundColor;
  final Svg? svgImage;
  final double? width;
  final double? height;

  TSNTournamentCard({
    required this.tournamentCardDetails,
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
    dynamic mainEvent = tournamentCardDetails['mainEvent'];
    dynamic tournament = tournamentCardDetails['tournament'];
    dynamic groupStage = tournamentCardDetails['groupStage'];
    dynamic tournamentStage = tournamentCardDetails['tournamentStage'];

    List<dynamic> roles = tournamentCardDetails['roles'];
    bool isMine = tournamentCardDetails['isMine'];
    String formattedEventTime = tournamentCardDetails['formattedEventTime'];
    bool isMember = tournamentCardDetails['isMember'];
    String amountRemaining = tournamentCardDetails['amountRemaining'];
    String amountPaid = tournamentCardDetails['amountPaid'];
    String teamAmountRemaining = tournamentCardDetails['teamAmountRemaining'];
    String teamAmountPaid = tournamentCardDetails['teamAmountPaid'];
    List organizers = tournamentCardDetails['organizers'];
    List fieldLocations = tournamentCardDetails['fieldLocations'];
    dynamic price = tournamentCardDetails['price'];
    JoinCondition eventRequestJoin = tournamentCardDetails['eventRequestJoin'];
    JoinCondition eventPaymentJoin = tournamentCardDetails['eventPaymentJoin'];
    JoinCondition teamRequestJoin = tournamentCardDetails['teamRequestJoin'];
    JoinCondition teamPaymentJoin = tournamentCardDetails['teamPaymentJoin'];

    print("eventRequestJoin: " + eventRequestJoin.required.value.toString());

    return GestureDetector(
        onTap: () {
          // Handle tap on the entire card here
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TournamentView(tournament: mainEvent)),
          );
          print("Card Clicked");
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: backgroundColor,
          child: Container(
            width: width,
            height: screenHeight * .2,
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
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(formattedEventTime,
                                        style: TextStyle(
                                          color: AppColors.tsnWhite,
                                          fontSize: FontSizes.xxs(context),
                                        )),
                                    // Text("TL 1b"),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: AppColors.tsnGreen),
                                    Text("Philadelphia, PA",
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
                            flex: 12,
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
                                    Expanded(
                                        flex: 9,
                                        child: BasicElevatedButton(
                                          icon: Icons.person,
                                          // height: screenHeight * 0.05,  // 10% of screen height
                                          // width: screenWidth * 0.35,
                                          backgroundColor:
                                              AppColors.tsnDarkGrey,
                                          text: "5/12",
                                          fontSize: FontSizes.xxs(context),
                                        )),
                                    SizedBox(width: 6),
                                    //join widget
                                    Expanded(
                                      flex: 11,
                                      child:
                                        GetJoinEventWidget(
                                            mainEvent: mainEvent,
                                            roles: roles,
                                            isMine: isMine,
                                            price: price,
                                            amountRemaining: amountRemaining,                                        
                                            eventRequestJoin: eventRequestJoin,
                                            eventPaymentJoin: eventPaymentJoin,
                                            teamRequestJoin: teamRequestJoin,
                                            teamPaymentJoin: teamPaymentJoin                                                                                    
                                        )
                                    ),
                                    // Expanded(
                                    //     flex: 11,
                                    //     child:
                                    //         // price['amount'] == 0 ?
                                    //         BasicElevatedButton(
                                    //       icon: Icons.add,
                                    //       // height: screenHeight * 0.05,  // 10% of screen height
                                    //       // width: screenWidth * 0.35,
                                    //       backgroundColor: AppColors.tsnGreen,
                                    //       text: "Join",
                                    //       fontSize: FontSizes.s(context),
                                    //       onPressed: () {
                                    //         print("Join Button Pressed");
                                    //       },
                                    //     )),

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
                                    Text(mainEvent['name'],
                                        style: TextStyle(
                                          color: AppColors.tsnWhite,
                                          fontSize: FontSizes.m(context),
                                        ))
                                    // Text("BL 1a"),
                                    // Text("BL 1b"),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    Image(
                                      width: 20,
                                      height: 20,
                                      image: SVGWidgets().tournament(),
                                      color: AppColors.tsnGreen,
                                    ),
                                    SizedBox(width: 6),
                                    Text("Tournament",
                                        style: TextStyle(
                                          color: AppColors.tsnWhite,
                                          fontSize: FontSizes.xxs(context),
                                        ))
                                    // Text("BL 2a"),
                                    // Text("BL 2b"),
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
                                    // Text("BR 1a"),
                                    // Text("BR 1b"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image(
                                      // width: 20,
                                      // height: 60,
                                      image: SVGWidgets().rightRocket(),
                                      color: AppColors.tsnGrey,
                                    ),
                                    SizedBox(width: 2),
                                    Image(
                                      width: 20,
                                      height: 20,
                                      image: SVGWidgets().host(),
                                      color: AppColors.tsnLightGreen,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                        "Host: " +
                                            organizers[0]['user']['name']
                                                .toString(),
                                        style: TextStyle(
                                          color: AppColors.tsnGrey,
                                          fontSize: FontSizes.xxs(context),
                                        ))
                                    // Text("BR 2a"),
                                    // Text("BR 2b"),
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
        ));
  }
}
