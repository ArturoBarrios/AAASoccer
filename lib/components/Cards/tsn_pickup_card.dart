import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/models/pageModels/event_page_model.dart';

import '../../commands/base_command.dart';
import '../../models/pageModels/event_page.dart';
import '../../models/pageModels/event_page_model.dart';
import '../../models/pageModels/event_page_model.dart';
import '../../models/pageModels/events_page_model.dart';
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
  EventPage? eventPageInstance;
  
  loadInitialData(){
    eventPageInstance = widget.pickupCardDetails['eventPageInstance'];

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
    print("in build tsn pickup card");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider<EventPage>.value(
      value: eventPageInstance!,
      child: Consumer<EventPage>(
        builder: (context, event, child) {
          return 
          isLoading ? Text("loading....") 
          :

    GestureDetector(
        onTap: () {
          // Handle tap on the entire card here
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PickupView(game: event.mainEvent, eventPageInstance: eventPageInstance!, )),
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
    child: Column(
      children: [
        // Top Section
        Expanded(
          child: Row(
            children: [
              // Top-left section
              Expanded(
                child: 
                Padding(
              padding: const EdgeInsets.fromLTRB(4,4,4,4),
              child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.av_timer_rounded, color: AppColors.tsnGreyerWhite),
                        Text(event.formattedEventTime, style: TextStyle(color: AppColors.tsnWhite, fontSize: FontSizes.xxs(context))),
                      ],
                    ),
                    SizedBox(height: 6),
                    GestureDetector(
                      onTap: () => BaseCommand().launchLocationInBrowser(event.fieldLocations[0]['location']['latitude'], event.fieldLocations[0]['location']['longitude']),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: AppColors.tsnGreen),
                          Text(event.location.toString(), style: TextStyle(color: AppColors.tsnGreen, fontSize: FontSizes.xxs(context))),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        RatingWidget(rating: event.fieldRating),
                      ],
                    ),
                  ],
                )),
              ),
              // Top-right section
              Expanded(
                child: 
                Padding(
              padding: const EdgeInsets.fromLTRB(4,8,8,4),
              child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 9,
                          child: BasicElevatedButton(
                            icon: Icons.person,
                            softWrap: false,
                            iconColor: AppColors.tsnGrey,
                            backgroundColor: AppColors.tsnDarkGrey,
                            text: event.numberOfParticipants.toString() + "/" + event.capacity.toString(),
                            fontSize: FontSizes.xxs(context),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          flex: 11,
                          child: GetJoinEventWidget(
                            mainEvent: event.mainEvent,
                            roles: event.roles,
                            isMine: event.isMine,
                            price: event.price,
                            amountRemaining: event.amountRemaining,
                            eventRequestJoin: event.eventRequestJoin,
                            eventPaymentJoin: event.eventPaymentJoin,
                            teamRequestJoin: event.teamRequestJoin,
                            teamPaymentJoin: event.teamPaymentJoin,
                            capacity: event.capacity,
                            numberOfPlayers: event.numberOfParticipants,
                            fieldRating: event.fieldRating,
                            hostRating: event.hostRating,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
        // Bottom Section
        Expanded(
          child: Row(
            children: [
              // Bottom-left section
              Expanded(
                child: 
                Padding(
              padding: const EdgeInsets.fromLTRB(4,4,4,8),
              child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        event.mainEvent['name'] + " another thing to make the name that much longer!",
                        style: TextStyle(color: AppColors.tsnWhite, fontSize: FontSizes.m(context)),
                      ),
                   
                  ],
                )),
              ),
              // Bottom-right section
              Expanded(
                child: 
                Padding(
              padding: const EdgeInsets.fromLTRB(4,4,8,4),
              child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image(
                          width: 20,
                          height: 20,
                          image: SVGWidgets().host(),
                          color: AppColors.tsnLightGreen,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Host: " + event.organizers[0]['user']['name'],
                          style: TextStyle(color: AppColors.tsnGrey, fontSize: FontSizes.xxs(context)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RatingWidget(rating: event.hostRating),
                      ],
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),

    );
          // Your widget that needs to update with changes in EventPage

        },
      ),
     );
  }
}
