import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:provider/provider.dart';

import '../../commands/user_command.dart';
import '../../models/pageModels/event_page_model.dart';
import '../../styles/colors.dart';
import '../../styles/font_sizes.dart';
import '../../svg_widgets.dart';
import '../../views/game/view.dart';
import '../../views/team/view.dart';
import '../Buttons/basic_elevated_button.dart';
import '../Buttons/circle_outline_icon.dart';
import '../get_join_event_widget.dart';
import '../get_join_team_widget.dart';
import '../join_condition.dart';

class TSNTeamCard extends StatefulWidget {
  
  TSNTeamCard({
    Key? key,
    required this.teamCardDetails,
    required this.backgroundColor,
    this.svgImage,
    this.width,
    this.height,
  }) : super(key: key);

  final dynamic teamCardDetails;
  final Color backgroundColor;
  final Svg? svgImage;
  final double? width;
  final double? height;

  @override
  State<TSNTeamCard> createState() => _TSNTeamCard();


}

class _TSNTeamCard extends State<TSNTeamCard> {
  dynamic currentUser = null;

  void loadInitialData(){
    print("loadInitialData() in TSNTeamCard");
    currentUser = UserCommand().getAppModelUser();
  }

  @override initState(){
    super.initState();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    //event model data
    dynamic team = widget.teamCardDetails['team'];

    List<dynamic> roles = widget.teamCardDetails['roles'];
    bool isMine = widget.teamCardDetails['isMine'];    
    bool isMember = widget.teamCardDetails['isMember'];
    String amountRemaining = widget.teamCardDetails['amountRemaining'];
    String amountPaid = widget.teamCardDetails['amountPaid'];    
    List players = widget.teamCardDetails['players'];    
    List organizers = widget.teamCardDetails['organizers'];    
    List teamLocations = widget.teamCardDetails['teamLocations'];    
    dynamic price = widget.teamCardDetails['price'];    
    JoinCondition teamRequestJoin = widget.teamCardDetails['teamRequestJoin'];
    JoinCondition teamPaymentJoin = widget.teamCardDetails['teamPaymentJoin'];
    

    return GestureDetector(
        onTap: () {
          // Handle tap on the entire card here
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TeamView(teamObject: team)),
          );
          print("Card Clicked");
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: widget.backgroundColor,
          child: Container(
            width: widget.width,
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
                                    // Text(formattedEventTime,
                                    //     style: TextStyle(
                                    //       color: AppColors.tsnWhite,
                                    //       fontSize: FontSizes.xxs(context),
                                    //     )),
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
                                    // join widget
                                    Expanded(
                                      flex: 11,
                                      child:
                                        GetJoinTeamWidget(
                                          user: currentUser,
                                          team: team,
                                          roles: roles,
                                          isMine: isMine,
                                          price: price,
                                          amountRemaining: amountRemaining,
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

                                        Expanded(flex: 9,
                                        child: 
                                    Text(team['name'],
                                        style: TextStyle(
                                          color: AppColors.tsnWhite,
                                          fontSize: FontSizes.m(context),
                                        )))
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
                                      image: SVGWidgets().pickup(),
                                      color: AppColors.tsnGreen,
                                    ),
                                    SizedBox(width: 6),
                                    Text("Team",
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
