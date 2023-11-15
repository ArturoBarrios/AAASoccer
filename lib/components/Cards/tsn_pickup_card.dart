import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/models/pageModels/event_page_model.dart';

import '../../models/pageModels/event_page_model.dart';
import '../../models/pageModels/event_page_model.dart';
import '../../models/pageModels/event_pages_model.dart';
import '../../styles/colors.dart';
import '../../styles/font_sizes.dart';
import '../../svg_widgets.dart';
import '../../views/game/view.dart';
import '../Buttons/basic_elevated_button.dart';
import '../Buttons/circle_outline_icon.dart';
import '../get_join_event_widget.dart';
import '../join_condition.dart';
import '../rating_widget.dart';

class TSNPickupCard extends StatefulWidget {
  final dynamic pickupCardDetails;
  final Color backgroundColor;
  final Svg? svgImage;
  final double? width;
  final double? height;

  TSNPickupCard({
    Key? key,
    required this.pickupCardDetails,
    required this.backgroundColor,
    this.svgImage,
    this.width,
    this.height,
  });

    @override
  _TSNPickupCardState createState() => _TSNPickupCardState();

}


class _TSNPickupCardState extends State<TSNPickupCard> {
  bool isLoading = true;
  EventPageModel eventModel = EventPageModel();
  
  loadInitialData(){
    eventModel = widget.pickupCardDetails['eventPageModelInstance'] as EventPageModel;

    setState(() {
      isLoading = false;
    });
  }
  
  @override
  initState() {
    super.initState();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

///testing shittt
    
    
    // int capacity = context.watch<EventsPageModel>().eventsPageModel.first.capacity;

    int capacity = context.select<EventPageModel, int>((value) => eventModel.capacity);


    //event model data
    dynamic mainEvent = widget.pickupCardDetails['mainEvent'];

    List<dynamic> roles = widget.pickupCardDetails['roles'];
    bool isMine = widget.pickupCardDetails['isMine'];
    String formattedEventTime = widget.pickupCardDetails['formattedEventTime'];
    bool isMember = widget.pickupCardDetails['isMember'];
    String amountRemaining = widget.pickupCardDetails['amountRemaining'];
    String amountPaid = widget.pickupCardDetails['amountPaid'];
    String teamAmountRemaining = widget.pickupCardDetails['teamAmountRemaining'];
    String teamAmountPaid = widget.pickupCardDetails['teamAmountPaid'];
    String location = widget.pickupCardDetails['location'];
    List organizers = widget.pickupCardDetails['organizers'];
    List fieldLocations = widget.pickupCardDetails['fieldLocations'];
    dynamic price = widget.pickupCardDetails['price'];
    JoinCondition eventRequestJoin = widget.pickupCardDetails['eventRequestJoin'];
    JoinCondition eventPaymentJoin = widget.pickupCardDetails['eventPaymentJoin'];
    JoinCondition teamRequestJoin = widget.pickupCardDetails['teamRequestJoin'];
    JoinCondition teamPaymentJoin = widget.pickupCardDetails['teamPaymentJoin'];
    int eventRating = widget.pickupCardDetails['eventRating'];
    int numberOfRatings = widget.pickupCardDetails['numberOfRatings'];
    // int capacity = pickupCardDetails['capacity'];
    int numberOfParticipants = widget.pickupCardDetails['numberOfParticipants'];

    print("fieldLocations: " + fieldLocations.toString());

    return 
    isLoading ? Text("loading....") :

    GestureDetector(
        onTap: () {
          // Handle tap on the entire card here
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PickupView(game: mainEvent, eventPageModelInstance: eventModel, )),
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
                            flex: 10,
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
                                    Text(location.toString(),
                                        style: TextStyle(
                                          color: AppColors.tsnGrey,
                                          fontSize: FontSizes.xxs(context),
                                        )),
                                    // Text("TL 2b"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    RatingWidget(rating: eventRating),
                                    // Icon(Icons.location_on,
                                    //     color: AppColors.tsnGreen),
                                    // Text(fieldLocations[0]['name'].toString(),
                                    //     style: TextStyle(
                                    //       color: AppColors.tsnGrey,
                                    //       fontSize: FontSizes.xxs(context),
                                    //     )),
                                    // Text("TL 2b"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 10,
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
                                    // Text("test capacity: "+ capacity.toString()),
                                    Expanded(
                                        flex: 9,
                                        child: BasicElevatedButton(
                                          icon: Icons.person,
                                          // height: screenHeight * 0.05,  // 10% of screen height
                                          // width: screenWidth * 0.35,
                                          backgroundColor:
                                              AppColors.tsnDarkGrey,
                                          text: numberOfParticipants.toString()
                                            +"/"+capacity.toString(),
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
                                            teamPaymentJoin: teamPaymentJoin     ,
                                            capacity: eventModel.capacity,
                    numberOfPlayers: numberOfParticipants,                                                                               
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
                                      image: SVGWidgets().pickup(),
                                      color: AppColors.tsnGreen,
                                    ),
                                    SizedBox(width: 6),
                                    Text("Pickup",
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
                                    RatingWidget(rating: eventRating),                                    
                                    // Text("BR 1a"),
                                    // Text("BR 1b"),
                                  ],
                                ),
                                Row(
                                  children: [                                   
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
