import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:provider/provider.dart';

import '../../commands/user_command.dart';
import '../../models/pageModels/event_page_model.dart';
import '../../styles/colors.dart';
import '../../styles/font_sizes.dart';
import '../../svg_widgets.dart';
import '../../views/game/view.dart';
import '../../views/group/view.dart';
import '../Buttons/basic_elevated_button.dart';
import '../Buttons/circle_outline_icon.dart';
import '../get_join_event_widget.dart';
import '../get_join_group_widget.dart';
import '../join_condition.dart';

class TSNGroupCard extends StatefulWidget {
  
  TSNGroupCard({
    Key? key,
    required this.groupCardDetails,
    required this.backgroundColor,
    this.svgImage,
    this.width,
    this.height,
  }) : super(key: key);

  final dynamic groupCardDetails;
  final Color backgroundColor;
  final Svg? svgImage;
  final double? width;
  final double? height;

  @override
  State<TSNGroupCard> createState() => _TSNGroupCard();


}

class _TSNGroupCard extends State<TSNGroupCard> {
  dynamic currentUser = null;

  void loadInitialData(){
    print("loadInitialData() in TSNGroupCard");
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
    dynamic group = widget.groupCardDetails['group'];

    List<dynamic> roles = widget.groupCardDetails['roles'];
    bool isMine = widget.groupCardDetails['isMine'];    
    bool isMember = widget.groupCardDetails['isMember'];
    String amountRemaining = widget.groupCardDetails['amountRemaining'];
    String amountPaid = widget.groupCardDetails['amountPaid'];    
    List players = widget.groupCardDetails['players'];    
    List organizers = widget.groupCardDetails['organizers'];    
    List groupLocations = widget.groupCardDetails['groupLocations'];    
    dynamic price = widget.groupCardDetails['price'];    
    JoinCondition groupRequestJoin = widget.groupCardDetails['groupRequestJoin'];
    JoinCondition groupPaymentJoin = widget.groupCardDetails['groupPaymentJoin'];
    

    return GestureDetector(
        onTap: () {
          // Handle tap on the entire card here
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GroupView(groupObject: group)),
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
                                      
                                    //     GetJoinGroupWidget(
                                    //       user: currentUser,
                                    //       group: group,
                                    //       roles: roles,
                                    //       isMine: isMine,
                                    //       price: price,
                                    //       amountRemaining: amountRemaining,
                                    //     )
                                    Text("TR 2a"),
                                    ),
                                   
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
                                    Text(group['name'],
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
                                    Text("Group",
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
