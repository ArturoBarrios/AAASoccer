import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/views/request/view.dart';

import '../../commands/event_command.dart';
import '../../commands/player_command.dart';
import '../../commands/team_command.dart';
import '../../constants.dart';

mixin BaseCardMixin {
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

  void setupPlayerList() {
    print("setupPlayerList");
    playerList = PlayerCommand().getAppModelPlayersNearMe();
  }

  void playersSelected(List<int> selectedIndexes) {
    print("playersSelected: $selectedIndexes");
    selectedPlayerIndexes = selectedIndexes;
    playersSelectedList = [];
    for (int i = 0; i < selectedIndexes.length; i++) {
      playersSelectedList.add(playerList[selectedIndexes[i]]);
    }
  }

  requestTypeSelected(List<int>? indexes) {
    print("requestTypeSelected: " + indexes.toString());
    selectedRequestTypeIndexes = indexes;
    for (int i = 0; i < indexes!.length; i++) {
      selectedRequestTypeObjects.add(requestUserTypes[indexes[i]]);
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
}
