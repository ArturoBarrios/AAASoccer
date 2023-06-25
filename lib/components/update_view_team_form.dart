import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/SendMyEventsTeamRequestWidget.dart';
import 'package:soccermadeeasy/components/players_list_widget.dart';
import 'package:soccermadeeasy/components/send_players_request_widget.dart';
import 'package:soccermadeeasy/components/send_teams_request_widget.dart';

import '../views/game/update.dart';
import 'Mixins/event_mixin.dart';
import 'chats_list_widget.dart';
import 'create_event_payment.dart';
import 'create_event_request.dart';
import 'create_team_payment.dart';
import 'create_team_request.dart';
import 'events_list_widget.dart';
import 'get_chat_widget.dart';
import 'images_list_widget.dart';
import 'location_search_bar.dart';
import 'Mixins/images_mixin.dart';


class UpdateViewTeamForm extends StatefulWidget with EventMixin {
  final dynamic userObjectDetails;

  UpdateViewTeamForm({Key? key, @required this.userObjectDetails})
      : super(key: key);

  @override
  _UpdateViewTeamFormState createState() => _UpdateViewTeamFormState();
}

class _UpdateViewTeamFormState extends State<UpdateViewTeamForm> {
  LocationSearchBar locationSearchBar = new LocationSearchBar();
  CreateTeamPayment createTeamPaymentWidget = new CreateTeamPayment();
  CreateTeamRequest createTeamRequestWidget = new CreateTeamRequest();

  void setupRequestWidgetData(){
    print("setupRequestWidgetData()");          
  }

  void updateChatsList(dynamic createdChat) {
    setState(() {
      widget.userObjectDetails['team']['chats']['data'].add(createdChat);
    });
  }


  void loadInitialData(){
    dynamic setupRequestWidgetResp = widget.setupRequestWidgetData(widget.userObjectDetails);
    print("setupRequestWidgetResp: $setupRequestWidgetResp");
    createTeamPaymentWidget = setupRequestWidgetResp['createTeamPaymentWidget'];
    createTeamRequestWidget = setupRequestWidgetResp['createTeamRequestWidget'];
  }

  void addEventCallback(dynamic event){
    setState(() {
      widget.userObjectDetails['team']['events']['data'].add(event);
    });

  }
  void removeEventCallback(dynamic event){
    setState(() {
      widget.userObjectDetails['team']['events']['data'].remove(event);
    });
  }

  void addTeamCallback(dynamic team){
    setState(() {
      widget.userObjectDetails['team']['teams']['data'].add(team);
    });

  }



  @override 
  void initState() {
    super.initState();
    print("init state UpdateViewTeamForm");
    print("userObjectDetails: " + widget.userObjectDetails.toString());
    loadInitialData();
  }


  @override
  Widget build(BuildContext context) {
    // Access userObjectDetails via widget.userObjectDetails

    return SingleChildScrollView(
        child: Center(child: Expanded(child: Column(children: [
          Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.amber[600],
                  width: MediaQuery.of(context).size.width -
                      (MediaQuery.of(context).size.width * .1), //10% padding
                  height: 200.0,
                  child:
                  //map
                   MyMapPage(
                      latitude: widget.userObjectDetails['team']['location']['data'][0]
                          ['latitude'],
                      longitude: widget.userObjectDetails['team']['location']['data'][0]
                          ['longitude']),
                ),
                widget.userObjectDetails['isMine'] ? 
                  locationSearchBar = LocationSearchBar(initialValue: widget.userObjectDetails['team']['location']['data'][0]['name'])
                   :
                  Text(widget.userObjectDetails['team']['location']['data'][0]['name']) ,
               
                
                createTeamRequestWidget,                
                createTeamPaymentWidget,                
                GetChatWidget(objectEventsDetails: widget.userObjectDetails, updatechatsList: updateChatsList),
                ChatsListWidget(
                  chats: widget.userObjectDetails['team']['chats']['data']),
                SendPlayersRequestWidget(userObjectDetails: widget.userObjectDetails),                
                SendMyEventsTeamRequestWidget(userObjectDetails: widget.userObjectDetails, addEventcallback: addEventCallback),                
                widget.getJoinTeamWidget(context, widget.userObjectDetails, widget.userObjectDetails['team'], widget.userObject),          
                PlayerList(playersDetails: widget.userObjectDetails),
                EventsListWidget(objectEventsDetails: widget.userObjectDetails,),
                ImagesListWidget(details: widget.userObjectDetails),
                //add image
        ]))));
  }
}
