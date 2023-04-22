import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/views/request/view.dart';

import '../../commands/base_command.dart';
import '../../commands/event_command.dart';
import '../../commands/player_command.dart';
import '../../commands/team_command.dart';
import '../../commands/user_command.dart';
import '../../constants.dart';
import '../card_form_screen.dart';

mixin EventMixin {
  bool withRequest = false;  
  bool withPayment = false;  
  dynamic userObject; 
  List<String> participationRoles = [];
  dynamic eventUserParticipant;

  int selectIndex = 0;
  int chosenRequestType = 0;
  List requestUserTypes = [
    Constants.PLAYER.toString(),
    Constants.ORGANIZER.toString(),
    Constants.MANAGER.toString(),
    Constants.MAINCOACH.toString(),
    Constants.ASSISTANTCOACH.toString(),
    Constants.REF.toString(),
  ];
  List playerList = [];
  List playersSelectedList = [];
  List<int>? selectedPlayerIndexes;
  List<int>? selectedRequestTypeIndexes;
  List<String> selectedRequestTypeObjects = [];
  List<dynamic> selectedEventTeamObjects = [];
  List<int>? selectedEventTeamIndexes;
  List choices = [];
  List<String> teamEventList = ["Team", "Event"];
  String eventTeamChosen = "";
  List myEventsToChooseFrom = [];
  List myTeamsToChooseFrom = [];

  void setupPlayerList() {
    print("setupPlayerList");
    playerList = PlayerCommand().getAppModelPlayersNearMe();
  }

  void setupEventTeamToChoose(int index) {    
    eventTeamChosen = teamEventList[index];
    if (eventTeamChosen == "Event") {
      setupEventsToChooseFrom();
    } else {
      setupTeamsToChooseFrom();
    }
  }

  void setupEventsToChooseFrom() {
    print("setupEventsToChooseFrom");
    List<dynamic> myEvents = UserCommand().getAppModelMyEvents();
    myEventsToChooseFrom = myEvents;
    choices = myEventsToChooseFrom;
  }

  void setupTeamsToChooseFrom() {
    print("setupTeamsToChooseFrom");
    List<dynamic> myTeams = UserCommand().getAppModelMyTeams();
    myTeamsToChooseFrom = myTeams;
    choices = myTeamsToChooseFrom;
  }

  Future<void> sendTeamRequest(dynamic teamObject) async {    
    print("sendTeamRequest");
    print("selectedRequestTypeObjects.length: " +
        selectedRequestTypeObjects.length.toString());
    print(
        "playersSelectedList.length: " + playersSelectedList.length.toString());
    print(
        "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    print("send team request");
    for(int i = 0; i < selectedRequestTypeObjects.length; i++) {
      await TeamCommand().sendOrganizerTeamRequest(teamObject, selectedRequestTypeObjects[i]);
    }    

  }

  eventTeamsSelected(List<int>? indexes) {        
    print("eventTeamsSelected: " + indexes.toString());
    selectedEventTeamObjects = [];
    selectedEventTeamIndexes = indexes;
    for(int i = 0; i < indexes!.length; i++){
      selectedEventTeamObjects.add(choices[indexes[i]]);
    }
    print("selectedEventTeamObjects: " + selectedEventTeamObjects.toString());
  }

  void playersSelected(List<int> selectedIndexes) {
    print("playersSelected: $selectedIndexes");
    selectedPlayerIndexes = selectedIndexes;
    playersSelectedList = [];
    for (int i = 0; i < selectedIndexes.length; i++) {
      playersSelectedList.add(playerList[selectedIndexes[i]]);
    }
  }

  requestTypeSelected(List<int>? indexes) async{
    print("requestTypeSelected: " + indexes.toString());
    selectedRequestTypeIndexes = indexes;
    for (int i = 0; i < indexes!.length; i++) {
      selectedRequestTypeObjects.add(requestUserTypes[indexes[i]]);
    }
    
  }

   sendPlayerRequests(dynamic userPlayerObject){
    print("sendPlayerRequests");
    print("selectedEventTeamObjects: " + selectedEventTeamObjects.toString());
    print("selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    if(eventTeamChosen == "Event"){      
      print("send player event request");
      EventCommand().sendPlayerEventRequests(userPlayerObject,selectedEventTeamObjects, selectedRequestTypeObjects, "GAMEREQUEST" );
    }
    else{
      print("send player team request");
      TeamCommand().sendPlayerTeamRequests(userPlayerObject,selectedEventTeamObjects, selectedRequestTypeObjects);
    }
  }

  Future<void> sendPlayersTeamRequest(dynamic teamObject) async {
    print("sendPlayersEventRequest");
    print("selectedRequestTypeObjects.length: " +
        selectedRequestTypeObjects.length.toString());
    print(
        "playersSelectedList.length: " + playersSelectedList.length.toString());
    print(
        "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    print("send player event request");
    for (int i = 0; i < playersSelectedList.length; i++) {
      await TeamCommand().sendPlayerTeamRequests(playersSelectedList[i],
          [teamObject], selectedRequestTypeObjects);
    }
  }

  Future<void> sendPlayersEventRequest(dynamic eventObject) async {
    print("sendPlayersEventRequest");
    print("selectedRequestTypeObjects.length: " +
        selectedRequestTypeObjects.length.toString());
    print(
        "playersSelectedList.length: " + playersSelectedList.length.toString());
    print(
        "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    print("send player event request");
    String type = "GAMEREQUEST";      
    if(eventObject['event']['type']=="GAME"){
      type = "GAMEREQUEST";
    }
    else if(eventObject['event']['type']=="LEAGUE"){
      type = "LEAGUEREQUEST";
    }
    else if(eventObject['event']['type']=="TOURNAMENT"){
      type = "TOURNAMENTREQUEST";
    }
    else if(eventObject['event']['type']=="TRAINING"){
      type = "TRAININGREQUEST";
    }    
    else if(eventObject['event']['type']=="TRYOUT"){
      type = "TRYOUTREQUEST";
    }
    
    for (int i = 0; i < playersSelectedList.length; i++) {
      await EventCommand().sendPlayerEventRequests(playersSelectedList[i],
          [eventObject], selectedRequestTypeObjects, type);
    }
  }

  //send organizers event request
  Future<void> sendEventRequest(dynamic eventObject, String requestType) async {
    print("sendEventRequest");
    print("selectedRequestTypeObjects.length: " +
        selectedRequestTypeObjects.length.toString());
    print(
        "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    print("send player event request");
    for (int i = 0; i < selectedRequestTypeObjects.length; i++) {
      await EventCommand().sendOrganizerEventRequest(eventObject,
          selectedRequestTypeObjects[i], requestType);
    }
  }

  void loadEventInfo(dynamic event){
    print("loadEventInfo");
    userObject = UserCommand().getAppModelUser();    
    userObject['eventUserParticipants']['data'].forEach((eventUserParticipantElement) {
      if(eventUserParticipantElement['event']['_id'] == event['_id'] 
        ){
        eventUserParticipant = eventUserParticipantElement;
        participationRoles = BaseCommand().parseRoles(eventUserParticipant['roles']);
        print("participationRoles: $participationRoles");

      }

    });

       
  }

  void displayRoles(){
    if(participationRoles.length>0){
      

    }
  }

  //assumes you're adding a new role
  String addRoleToRoles(String addRole){
    String roles = "{";
    //get roles
    participationRoles.forEach((element) {
      roles += element+",";
    });
    //add new role
    roles += addRole;
    roles += "}";

    return roles;
  }

  GestureDetector getJoinGameWidget(BuildContext context, bool isMyEvent, dynamic event, dynamic userInput) {    
    if(!participationRoles.contains("PLAYER")){
      String roles = addRoleToRoles("PLAYER");
      if (isMyEvent) {
        return GestureDetector(
          onTap: () {
            print("onTap Join My Game");
            EventCommand().addUserToEvent(event, userInput, roles);
          },
          child: Text("Join my Game"),
        );
      } else {
        //!withPayment&&!withRequest
        if (!event['joinConditions']['withPayment'] &&
            !event['joinConditions']['withRequest']) {
          return GestureDetector(
            onTap: () {
              print("onTap Join Gameeeee");
              EventCommand().addUserToEvent(event, userInput, roles);
            },
            child: Text("Join Game(no immediate payment required)"),
          );
        }
        //!withPayment && withRequest
        else if (!event['joinConditions']['withPayment'] &&
            event['joinConditions']['withRequest']) {
          return GestureDetector(
            onTap: () {
              print("Send Request to Join with no payment required");
              selectedRequestTypeObjects.add("PLAYER");
              sendEventRequest(event, "GAMEREQUEST");
              selectedRequestTypeObjects = [];
              
            },
            child: Text("Send Request to Join(No Payment required to join)"),
          );
        }
        //withPayment && !withRequest
        else if (event['joinConditions']['withPayment'] &&
            !event['joinConditions']['withRequest']) {
          return GestureDetector(
            onTap: () {
              print("Send Request to Join with no payment required");
              purchaseEvent(context, event);
            },
            child: Text("Pay to Join Game"),
          );
        }
        //withPayment && withRequest
        else {
          return GestureDetector(
            onTap: () {
              print("Send Request to Join with no payment required");
            },
            child: Text("Send Request to Join(Payment required to join)"),
          );
        }
      }
    }
    else{
      return GestureDetector(
        onTap: () {
          print("onTap Leave Game");
        },
        child: Text("Leave Game"),
      );
      
    }


  }

  void purchaseEvent(BuildContext context, dynamic event) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CardFormScreen(priceObject: event)),
    );
    // await AdaptyPaymentService().makePurchase();
  }


}
