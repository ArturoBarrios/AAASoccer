import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/players_list_widget.dart';
import 'package:soccermadeeasy/components/price_widget.dart';

import '../views/game/update.dart';
import 'Mixins/event_mixin.dart';
import 'chats_list_widget.dart';
import 'create_event_payment.dart';
import 'create_event_request.dart';
import 'create_team_payment.dart';
import 'create_team_request.dart';
import 'location_search_bar.dart';

class UpdateViewForm extends StatefulWidget with EventMixin {
  final dynamic userObjectDetails;

  UpdateViewForm({Key? key, @required this.userObjectDetails})
      : super(key: key);

  @override
  _UpdateViewFormState createState() => _UpdateViewFormState();
}

class _UpdateViewFormState extends State<UpdateViewForm> {
  LocationSearchBar locationSearchBar = new LocationSearchBar();
  CreateEventRequest createEventRequestWidget = new CreateEventRequest();
  CreateEventPayment createEventPaymentWidget = new CreateEventPayment();
  CreateTeamPayment createTeamPaymentWidget = new CreateTeamPayment();
  CreateTeamRequest createTeamRequestWidget = new CreateTeamRequest();

  void setupRequestWidgetData() {
    print("setupRequestWidgetData()");
  }

  void updateChatsList(dynamic createdChat) {
    setState(() {
      widget.userObjectDetails['mainEvent']['chats']['data'].add(createdChat);
    });
  }

  void loadInitialData() {
    dynamic setupRequestWidgetResp =
        widget.setupRequestWidgetData(widget.userObjectDetails);
    print("setupRequestWidgetResp: $setupRequestWidgetResp");
    createEventRequestWidget =
        setupRequestWidgetResp['createEventRequestWidget'];
    createEventPaymentWidget =
        setupRequestWidgetResp['createEventPaymentWidget'];
    createTeamPaymentWidget = setupRequestWidgetResp['createTeamPaymentWidget'];
    createTeamRequestWidget = setupRequestWidgetResp['createTeamRequestWidget'];
  }

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    // Access userObjectDetails via widget.userObjectDetails

    return SingleChildScrollView(
        child: Center(
            child: Expanded(
                child: Column(children: [
      Container(
        margin: const EdgeInsets.all(10.0),
        color: Colors.amber[600],
        width: MediaQuery.of(context).size.width -
            (MediaQuery.of(context).size.width * .1), //10% padding
        height: 200.0,
        child:
            //map
            MyMapPage(
                latitude: widget.userObjectDetails['mainEvent']['location']
                    ['data'][0]['latitude'],
                longitude: widget.userObjectDetails['mainEvent']['location']
                    ['data'][0]['longitude']),
      ),
      widget.userObjectDetails['isMine']
          ? locationSearchBar = LocationSearchBar(
              initialValue: widget.userObjectDetails['mainEvent']['location']
                  ['data'][0]['name'])
          : Text(widget.userObjectDetails['mainEvent']['location']['data'][0]
              ['name']),
      widget.sendPlayersRequestWidget(context, widget.userObjectDetails),

      widget.sendTeamsRequestWidget(context, widget.userObjectDetails),
      widget.getChatWidget(
          context, true, false, widget.userObjectDetails, updateChatsList),
      ChatsListWidget(
          chats: widget.userObjectDetails['mainEvent']['chats']['data']),

      // if (widget.userObjectDetails['isMine'])
      createEventRequestWidget,
      // if (widget.userObjectDetails['isMine'])
      createEventPaymentWidget,
      // if (widget.userObjectDetails['isMine'])
      createTeamRequestWidget,
      // if (widget.userObjectDetails['isMine'])
      createTeamPaymentWidget,

      PlayerList(playersDetails: widget.userObjectDetails),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PriceWidget(
              userEventDetails: widget.userObjectDetails,
              teamPrice: false,
              eventPrice: true)
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PriceWidget(
              userEventDetails: widget.userObjectDetails,
              teamPrice: true,
              eventPrice: false)
        ],
      ),
    ]))));
  }
}
