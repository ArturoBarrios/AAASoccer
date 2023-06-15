import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/players_list_widget.dart';

import '../views/game/update.dart';
import 'Mixins/event_mixin.dart';
import 'create_event_payment.dart';
import 'create_event_request.dart';
import 'create_team_payment.dart';
import 'create_team_request.dart';
import 'events_list_widget.dart';
import 'location_search_bar.dart';


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
               
                // if (widget.userObjectDetails['isMine'])
                createTeamRequestWidget,
                // if (widget.userObjectDetails['isMine'])
                createTeamPaymentWidget,
                widget.getChatWidget(context, false, true, widget.userObjectDetails, updateChatsList),
                widget.sendPlayersRequestWidget(context, widget.userObjectDetails),
                widget.getJoinTeamWidget(context, widget.userObjectDetails, widget.userObjectDetails['team'], widget.userObject),          
                PlayerList(playersDetails: widget.userObjectDetails),
                EventsListWidget(teamsDetails: widget.userObjectDetails,),
                //add image
        ]))));
  }
}
