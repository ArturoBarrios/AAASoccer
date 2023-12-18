import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/components/object_profile_main_image.dart';

import '../../models/pageModels/event_page_model.dart';
import '../../styles/colors.dart';
import '../../styles/font_sizes.dart';
import '../../svg_widgets.dart';
import '../../views/game/view.dart';
import '../../views/player/view.dart';
import '../../views/profile/profile.dart';
import '../Buttons/basic_elevated_button.dart';
import '../Buttons/circle_outline_icon.dart';
import '../follow_container.dart';
import '../get_join_event_widget.dart';
import '../join_condition.dart';

class TSNPlayerLineupCard extends StatelessWidget {
  final dynamic playerCardDetails;
  final Color backgroundColor;
  final Svg? svgImage;
  final double? width;
  final double? height;

  TSNPlayerLineupCard({
    required this.playerCardDetails,
    required this.backgroundColor,
    this.svgImage,
    this.width,
    this.height,
  });

  // goToPlayer(BuildContext context) {
  //   print("goToPlayer");
  //   dynamic profileDetails = {
  //     "user": widget.playerObject,
  //     "isMine": false,
  //     "userDetails": widget.playerDetails
  //   };
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => Profile(
  //               profileDetails: profileDetails,
  //             )),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    print("build TSNPlayerLineupCard");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    //event model data
    dynamic user = playerCardDetails['user'];
    // bool isProfilePrivate = playerCardDetails['isProfilePrivate'];
    dynamic objectImageInput = playerCardDetails['objectImageInput'];
    List followers = playerCardDetails['followers'];
    List following = playerCardDetails['following'];
    List eventUserParticipants = playerCardDetails['eventUserParticipants'];
    List teamUserParticipants = playerCardDetails['teamUserParticipants'];

    print("userrrrrrrrr: " + user.toString());

    return GestureDetector(
        onTap: () {
          print("onTap: " + user.toString());
          // Handle tap on the entire card here
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Profile(user: user)),
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
            height: screenHeight * .1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Stack(
              children: [
                // Padding(
                // padding: const EdgeInsets.all(8.0),
                // child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // First Column (Center Left)
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: screenHeight * .1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(2,2,2,2),
                                child: ObjectProfileMainImage(
                                    objectImageInput: objectImageInput),
                              ))
                          // Text("Center Left Text",
                          //   style: TextStyle(
                          //     color: AppColors.tsnWhite,
                          //     fontSize: FontSizes.m(context),
                          //   )
                          // ),
                        ],
                      ),
                    ),

                    // Padding between the first and second column
                    SizedBox(width: 10),

                    // Second Column
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // First Row in Second Column
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2,2,2,2),
                            child: Row(
                              children: [
                                Text(user['name'],
                                    style: TextStyle(color: AppColors.tsnBlack, fontSize: FontSizes.m(context), fontWeight: FontWeight.bold ))
                                // Add more columns here if desired
                              ],
                            ),
                          ),
                          // Second Row in Second Column
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2,2,2,2),
                            child: Row(
                              children: [
                                Text(user['skillLevel'],
                                    style: TextStyle(color: AppColors.tsnGrey))
                                // Add more columns here if desired
                              ],
                            ),
                          ),
                          // Third Row in Second Column
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2,2,2,2),
                            child: Row(
                              children: [
                                Icon(Icons.stadium, color: AppColors.tsnGreen),
                                SizedBox(width: 2),
                                Text(
                                    user['eventUserParticipants']
                                            .length
                                            .toString() +
                                        " Events",
                                    style: TextStyle(color: AppColors.tsnBlack))
                                // Add more columns here if desired
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Third Column (Far Right)
                    Flexible(
                      child: 
                      Padding(
                            padding: const EdgeInsets.fromLTRB(0,2,8,2),
                            child:Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(user['preferredPosition'],
                              style: TextStyle(
                                color: AppColors.tsnGreen,
                                fontSize: FontSizes.m(context),
                              )),
                          // Additional content here if needed
                        ],
                      )),
                    ),
                  ],
                ),
                // ),
              ],
            ),
          ),
        ));
  }
}
