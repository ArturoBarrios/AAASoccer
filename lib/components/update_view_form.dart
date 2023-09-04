import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/players_list_widget.dart';
import 'package:soccermadeeasy/components/price_widget.dart';
import 'package:soccermadeeasy/components/requests_list.dart';
import 'package:soccermadeeasy/components/rsvp_widget.dart';
import 'package:soccermadeeasy/components/send_players_request_widget.dart';
import 'package:soccermadeeasy/components/send_teams_request_widget.dart';
import 'package:soccermadeeasy/components/teams_list_widget.dart';

import '../commands/base_command.dart';
import '../commands/user_command.dart';
import '../views/game/update.dart';

import 'Mixins/event_mixin.dart';
import 'chats_list_widget.dart';
import 'create_event_payment.dart';
import 'create_event_request.dart';
import 'create_team_payment.dart';
import 'create_team_request.dart';
import 'event_date_widget.dart';
import 'get_chat_widget.dart';
import 'get_join_event_widget.dart';
import 'league_table_widget.dart';
import 'location_search_bar.dart';
import 'images_list_widget.dart';

class UpdateViewForm extends StatefulWidget with EventMixin {
  final dynamic userObjectDetails;

  UpdateViewForm({Key? key, required this.userObjectDetails}) : super(key: key);

  @override
  _UpdateViewFormState createState() => _UpdateViewFormState();
}

class _UpdateViewFormState extends State<UpdateViewForm> {
  LocationSearchBar locationSearchBar = const LocationSearchBar();
  CreateEventRequest createEventRequestWidget = CreateEventRequest();
  CreateEventPayment createEventPaymentWidget = CreateEventPayment();
  CreateTeamPayment createTeamPaymentWidget = CreateTeamPayment();
  CreateTeamRequest createTeamRequestWidget = CreateTeamRequest();
  dynamic images = [];

  void setupRequestWidgetData() {
    print("setupRequestWidgetData()");
  }

  void updateChatsList(dynamic createdChat) {
    setState(() {
      widget.userObjectDetails['mainEvent']['chats']['data'].add(createdChat);
      // BaseCommand().updateUserEventDetailsModel(widget.userObjectDetails);
    });
  }

 

  void loadInitialData() {
    print("loadInitialData()");
    dynamic setupRequestWidgetResp =
        widget.setupRequestWidgetData(widget.userObjectDetails);
    print("setupRequestWidgetResp: $setupRequestWidgetResp");
    createEventRequestWidget =
        setupRequestWidgetResp['createEventRequestWidget'];
    createEventPaymentWidget =
        setupRequestWidgetResp['createEventPaymentWidget'];
    createTeamPaymentWidget = setupRequestWidgetResp['createTeamPaymentWidget'];
    createTeamRequestWidget = setupRequestWidgetResp['createTeamRequestWidget'];
    images = widget.userObjectDetails['mainEvent']['images']['data'];
    print("images: " + images.toString());

    //remove chats that don't belong to you
    dynamic appModelUser = UserCommand().getAppModelUser();
    var chats = widget.userObjectDetails['mainEvent']['chats']['data'];
    var filteredChats = [];

    for (var chat in chats) {
      var users = chat['users']['data'];
      if (users.any((user) => user['_id'] == appModelUser['_id'])) {
        filteredChats.add(chat);
      }
    }
    widget.userObjectDetails['mainEvent']['chats']['data'] = filteredChats;
  }

  void updateRsvpStatus(Map<String, dynamic> rsvpStatus) {
    setState(() {
      widget.userObjectDetails['mainEvent']['rsvp']['data'].add(rsvpStatus);
      // BaseCommand().updateUserEventDetailsModel(widget.userObjectDetails);
    });
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
          child: Column(
            children: [
              EventDateWidget(canEdit: widget.userObjectDetails['isMine'], startTime: widget.userObjectDetails['startTime'], endTime: widget.userObjectDetails['endTime']),

              // Container(
              //   margin: const EdgeInsets.all(10.0),
              //   color: Colors.amber[600],
              //   width: MediaQuery.of(context).size.width -
              //       (MediaQuery.of(context).size.width * .1), //10% padding
              //   height: 200.0,
              //   child:

                    //map
              //       MyMapPage(
              //           latitude: widget.userObjectDetails['mainEvent']
              //               ['location']['data'][0]['latitude'],
              //           longitude: widget.userObjectDetails['mainEvent']
              //               ['location']['data'][0]['longitude']),
              // ),
              // GetJoinEventWidget(userObjectDetails: widget.userObjectDetails),
              // RequestsList(objectDetails: {
              //   "requests": widget.userObjectDetails['mainEvent']['requests']
              //       ['data']
              // }),
              // RSVPWidget(
              //   onRsvpStatusChanged: () {},
              //   currentStatus: '',
              // ),
              // widget.userObjectDetails['isMine']
              //     ? locationSearchBar = LocationSearchBar(
              //         initialValue: widget.userObjectDetails['mainEvent']
              //             ['location']['data'][0]['name'])
              //     : Text(widget.userObjectDetails['mainEvent']['location']
              //         ['data'][0]['name']),
              widget.userObjectDetails['mainEvent']['type'].toString() ==
                      "LEAGUE"
                  ? LeagueTableWidget(
                      userEventDetails: widget.userObjectDetails,
                    )
                  : Container(),
              // PlayerList(playersDetails: widget.userObjectDetails),
              // TeamsListWidget(userObjectDetails: widget.userObjectDetails),
              // SendPlayersRequestWidget(
              //     userObjectDetails: widget.userObjectDetails),
              // SendTeamsRequestWidget(
              //     userObjectDetails: widget.userObjectDetails,
              //     addTeamCallback: addTeamCallback),
              // GetChatWidget(
              //     objectEventsDetails: widget.userObjectDetails,
              //     updatechatsList: updateChatsList),
              ChatsListWidget(
                chats: widget.userObjectDetails['mainEvent']['chats']['data'],
              ),
              
              createEventRequestWidget,
              createEventPaymentWidget,              
              createTeamRequestWidget,              
              createTeamPaymentWidget,

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
              ImagesListWidget(details: widget.userObjectDetails),
            ],
          ),
        ),
      ),
    );
  }

  bool isEventOrTeam() {
    return widget.userObjectDetails['mainEvent']['type'].toString() ==
            "EVENT" ||
        widget.userObjectDetails['mainEvent']['type'].toString() == "TEAM";
  }
}
