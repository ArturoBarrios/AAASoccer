import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/views/request/view.dart';

import '../../commands/base_command.dart';
import '../../commands/event_command.dart';
import '../../commands/player_command.dart';
import '../../commands/team_command.dart';
import '../../commands/user_command.dart';
import '../../constants.dart';
import '../../views/chats/create.dart';
import '../Dialogues/animated_dialogu.dart';
import '../card_form_screen.dart';

mixin EventMixin {
  bool withRequest = false;
  bool withPayment = false;
  dynamic userObject;
  List<String> participationRoles = [];
  dynamic eventUserParticipant;
  dynamic teamUserParticipant;
  dynamic event;
  dynamic team;

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
  List teamList = [];
  List myTeamList = [];
  List playersSelectedList = [];
  List<int>? selectedPlayerIndexes;
  List teamsSelectedList = [];
  List<int>? selectedTeamIndexes;
  List<int>? selectedRequestTypeIndexes = [];
  List<String> selectedRequestTypeObjects = [];
  List<dynamic> selectedEventTeamObjects = [];
  List<int>? selectedEventTeamIndexes;
  List choices = [];
  List<String> teamEventList = ["Team", "Event"];
  List<String> playersTeamsList = ["Team", "Players"];
  String eventTeamChosen = "";
  String playersTeamsChosen = "";
  List myEventsToChooseFrom = [];
  List myTeamsToChooseFrom = [];

  void setupPlayerList() {
    print("setupPlayerList");
    playerList = PlayerCommand().getAppModelPlayersNearMe();
  }

  void setupTeamList() {
    print("setupTeamList");
    teamList = TeamCommand().getAppModelTeamsNearMe();
    //add teamInEvent property
  }

  void setupMyTeams(){
    print("setupMyTeams");
    teamList = UserCommand().getAppModelMyTeams();
    myTeamList = teamList;
  }

  void setupEventTeamToChoose(int index) {
    eventTeamChosen = teamEventList[index];
    if (eventTeamChosen == "Event") {
      setupEventsToChooseFrom();
    } else {
      setupTeamsToChooseFrom();
    }
  }

  void setupPlayersTeamsToChoose(int index) {
    playersTeamsChosen = playersTeamsList[index];
    if (eventTeamChosen == "Players") {
      setupPlayerList();
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

  sendEventRequestForMyTeam(){
    print("sendEventRequestForMyTeam: " + teamsSelectedList.toString());
    for(int i = 0; i < teamsSelectedList.length; i++){
      TeamCommand().sendEventRequestForMyTeam(event, teamsSelectedList[i]);
    }
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
    for (int i = 0; i < selectedRequestTypeObjects.length; i++) {
      await TeamCommand()
          .sendTeamOrganizersRequest(teamObject, selectedRequestTypeObjects[i]);
    }
  }

  eventTeamsSelected(List<int>? indexes) {
    print("eventTeamsSelected: " + indexes.toString());
    selectedEventTeamObjects = [];
    selectedEventTeamIndexes = indexes;
    for (int i = 0; i < indexes!.length; i++) {
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

  void teamsSelected(Map<int,dynamic> selectedIndexes, List<dynamic> teamListUsed) {
    print("teamsSelected: $selectedIndexes");
    print("teamList: " +teamList.toString());
    // selectedTeamIndexes = selectedIndexes;
    // teamsSelectedList = [];
    selectedIndexes.forEach((key, secondarySelectedIndexes){
      print("key: " + key.toString());
      print("secondarySelectedIndexes: " + secondarySelectedIndexes.toString());
      teamsSelectedList.add(teamListUsed[key]);
    });
    // for (int i = 0; i < selectedIndexes.length; i++) {
    //   print("inside for loop");
    //   teamsSelectedList.add(teamList[selectedIndexes[i]]);
    //   print("teamList[selectedIndexes[i]]: " + teamList[selectedIndexes[i]].toString());
    // }
  }

  requestTypeSelected(List<int>? indexes) async {
    print("requestTypeSelected: " + indexes.toString());
    selectedRequestTypeIndexes = indexes;
    for (int i = 0; i < indexes!.length; i++) {
      selectedRequestTypeObjects.add(requestUserTypes[indexes[i]]);
    }
  }

  sendPlayerRequests(dynamic userPlayerObject) {
    print("sendPlayerRequests");
    print("selectedEventTeamObjects: " + selectedEventTeamObjects.toString());
    print(
        "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    if (eventTeamChosen == "Event") {
      print("send player event request");
      EventCommand().sendPlayerEventRequests(userPlayerObject,
          selectedEventTeamObjects, selectedRequestTypeObjects, "GAMEREQUEST");
    } else {
      print("send player team request");
      TeamCommand().sendPlayerTeamRequests(userPlayerObject,
          selectedEventTeamObjects, selectedRequestTypeObjects);
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
      await TeamCommand().sendPlayerTeamRequests(
          playersSelectedList[i], [teamObject], selectedRequestTypeObjects);
    }
  }

  Future<void> sendTeamsEventRequest(dynamic event) async {
    print("sendTeamsEventRequest");
    print("selectedRequestTypeObjects.length: " +
        selectedRequestTypeObjects.length.toString());
    print("teamsSelectedList: " + teamsSelectedList.toString());

    for (int i = 0; i < teamsSelectedList.length; i++) {
      await TeamCommand().sendTeamEventRequest(teamsSelectedList[i], event);
    }
  }
  
  Future<void> sendEventRequestForMyTeams(dynamic event) async {
    print("sendTeamsEventRequest");
    print("selectedRequestTypeObjects.length: " +
        selectedRequestTypeObjects.length.toString());
    print("teamsSelectedList: " + teamsSelectedList.toString());

    for (int i = 0; i < teamsSelectedList.length; i++) {
      await TeamCommand().sendTeamEventRequest(teamsSelectedList[i], event);
    }
  }

  String getRequestType(eventObject) {
    String type = "GAMEREQUEST";
    if (eventObject['type'] == "GAME") {
      type = "GAMEREQUEST";
    } else if (eventObject['type'] == "LEAGUE") {
      type = "LEAGUEREQUEST";
    } else if (eventObject['type'] == "TOURNAMENT") {
      type = "TOURNAMENTREQUEST";
    } else if (eventObject['type'] == "TRAINING") {
      type = "TRAININGREQUEST";
    } else if (eventObject['type'] == "TRYOUT") {
      type = "TRYOUTREQUEST";
    }
    return type;
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
    String type = getRequestType(eventObject);

    for (int i = 0; i < playersSelectedList.length; i++) {
      await EventCommand().sendPlayerEventRequests(playersSelectedList[i],
          [eventObject], selectedRequestTypeObjects, type);
    }
  }

  //send organizers event request
  Future<void> sendEventRequest(dynamic eventObject) async {
    print("sendEventRequest");
    print("selectedRequestTypeObjects.length: " +
        selectedRequestTypeObjects.length.toString());
    print(
        "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    print("send player event request");
    String requestType = getRequestType(eventObject);
    for (int i = 0; i < selectedRequestTypeObjects.length; i++) {
      await EventCommand().sendOrganizerEventRequest(
          eventObject, selectedRequestTypeObjects[i], requestType);
    }
  }

  void loadTeamInfo(dynamic team) {
    print("loadTeamInfo");
    this.team = team;
    userObject = UserCommand().getAppModelUser();
    userObject = UserCommand().getAppModelUser();
    userObject['teamUserParticipants']['data']
        .forEach((teamUserParticipantElement) {
      if (teamUserParticipantElement['team']['_id'] == team['_id']) {
        teamUserParticipant = teamUserParticipantElement;
        participationRoles =
            BaseCommand().parseRoles(teamUserParticipant['roles']);
        print("participationRoles: $participationRoles");
      }
    });
  }

  void loadEventInfo(dynamic event) {
    this.event = event;
    print("loadEventInfo");
    userObject = UserCommand().getAppModelUser();
    userObject['eventUserParticipants']['data']
        .forEach((eventUserParticipantElement) {
      if (eventUserParticipantElement['event']['_id'] == event['_id']) {
        eventUserParticipant = eventUserParticipantElement;
        participationRoles =
            BaseCommand().parseRoles(eventUserParticipant['roles']);
        print("participationRoles: $participationRoles");
      }
    });
  }

  void displayRoles() {
    if (participationRoles.length > 0) {}
  }

  //assumes you're adding a new role
  String addRoleToRoles(String addRole) {
    String roles = "{";
    //get roles
    participationRoles.forEach((element) {
      roles += element + ",";
    });
    //add new role
    roles += addRole;
    roles += "}";

    return roles;
  }

  void createChat(BuildContext context, bool attachToEvent, bool attachToTeam) {
    print("createChat");
    print("selectedPlayers: " + playersSelectedList.toString());
    playersSelectedList.add(userObject);
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return ChatCreate(
            eventObject: attachToEvent ? event : null,
            teamObject: attachToTeam ? team : null,
            players: playersSelectedList);
      },
    ));
  }

  Container getChatWidget(
      BuildContext context, bool attachToEvent, bool attachToTeam) {
    if (participationRoles.contains("ORGANIZER")) {
      return Container(
          child: GestureDetector(
              onTap: () async {
                print("Add New Chat Pressed");
                 Map<int,dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                    items: playerList,
                    singleSelect: false,
                    secondaryItems: [] );
                },
              );
              if (result.isNotEmpty) {
                // playersSelected(selectedPlayerIndexes!);
                // createChat(context, attachToEvent, attachToTeam);
              }





                // List<int>? playerIndexes = await showAnimatedDialog<dynamic>(
                //   context: context,
                //   barrierDismissible: true,
                //   builder: (BuildContext context) {
                //     return ClassicListDialogWidget<dynamic>(
                //         selectedIndexes: selectedPlayerIndexes,
                //         titleText: 'Choose Players',
                //         listType: ListType.multiSelect,
                //         positiveText: "Create Chat",
                //         activeColor: Colors.green,
                //         dataList: playerList);
                //   },
                //   animationType: DialogTransitionType.size,
                //   curve: Curves.linear,
                // );
                // selectedPlayerIndexes = playerIndexes ?? selectedPlayerIndexes;
                // print('selectedIndex:${selectedPlayerIndexes?.toString()}');
                // playersSelected(selectedPlayerIndexes!);
                // createChat(context, attachToEvent, attachToTeam);
              },
              child: Container(
                padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.pink[50],
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.pink,
                      size: 20,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text("Add New",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              )));
    } else {
      return Container();
    }
  }

  Container getPriceWidget(dynamic userEventDetails) {
    print("getPriceWidget()");

    if (userEventDetails['price'] != null) {
      String amount = (double.parse(userEventDetails['price']['amount']) / 100)
          .toStringAsFixed(2);
      String amountPaid = (double.parse(userEventDetails['amountPaid']) / 100)
          .toStringAsFixed(2);
      String amountRemaining =
          (double.parse(userEventDetails['amountRemaining']) / 100)
              .toStringAsFixed(2);
      if (!participationRoles.contains("ORGANIZER")) {
        if (amountRemaining == "0.00") {
          return Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Text("Price: \$${(amount)}"),
                IconButton(
                  icon: const Icon(Icons.check_circle),
                  tooltip: 'Go to the next page',
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute<void>(
                    //   builder: (BuildContext context) {
                    //     return Profile();
                    //   },
                    // ));
                  },
                ),
              ]));
        }
        //double.parse(amountRemaining)>0.00
        else {
          return Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Text(
                      "Price: \$${(amount)}",
                      style: TextStyle(fontSize: 16),
                    ),
                    userEventDetails['isMember']
                        ? Text(
                            "Remaining Balance: \$$amountRemaining",
                            style: TextStyle(fontSize: 16),
                          )
                        : Container()
                  ])
            ],
          ));
        }
      } else {
        return Container(child: Row());
      }
    } else {
      return Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("FREE!")],
      ));
    }
  }

  Container getJoinGameWidget(BuildContext context, dynamic userEventDetails,
      dynamic event, dynamic userInput) {
    print("userEventDetails: $userEventDetails");

    print("participationRoles: " + participationRoles.toString());
    //if not already a player
    if (!participationRoles.contains("PLAYER")) {
      String roles = addRoleToRoles("PLAYER");
      if (userEventDetails['isMyEvent']) {
        return Container(
            child: GestureDetector(
          onTap: () {
            print("onTap Join My Game");
            EventCommand().addUserToEvent(event, userInput, roles);
          },
          child: Text("Join my Game"),
        ));
      } else {
        //!withPayment&&!withRequest
        if (!event['joinConditions']['withPayment'] &&
            !event['joinConditions']['withRequest']) {
          //price exists(join with paying or not paying)
          if (userEventDetails['price'] != null) {
            return Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  GestureDetector(
                    onTap: () {
                      print("!withPayment&&!withRequest");
                      purchaseEvent(context, event, roles);
                    },
                    child: Text("Join Game, Pay Now"),
                  ),
                  Container(
                      child: GestureDetector(
                    onTap: () {
                      print("!withPayment&&!withRequest");
                      EventCommand().addUserToEvent(event, userInput, roles);
                    },
                    child: Text("Join Game, Pay Later"),
                  ))
                ]));
          }
          //price does not exist
          else {
            return Container(
                child: GestureDetector(
              onTap: () {
                print("!withPayment&&!withRequest");
                EventCommand().addUserToEvent(event, userInput, roles);
              },
              child: Text("Join Game, Pay Later"),
            ));
          }
        }
        //!withPayment&&withRequestt
        else if (!event['joinConditions']['withPayment'] &&
            event['joinConditions']['withRequest']) {
          return Container(
              child: GestureDetector(
            onTap: () {
              print("!withPayment&&!withRequest");
              selectedRequestTypeObjects.add("PLAYER");
              sendEventRequest(event);
              selectedRequestTypeObjects = [];
            },
            child: Text("Send Request to Join(No Payment required to join)"),
          ));
        }
        //withPayment && !withRequest
        else if (event['joinConditions']['withPayment'] &&
            !event['joinConditions']['withRequest']) {
          //if amount is 0

          return Container(
              child: GestureDetector(
            onTap: () {
              print("withPayment && !withRequest");
              purchaseEvent(context, event, roles);
            },
            child: Text("Pay to Join Game"),
          ));
        }
        //withPayment && withRequest
        //find request element, else send request
        else {
          print("elseeee");
          print("userObject['requestsSent']: ${userObject['requestsSent']}");
          //check event request status
          dynamic requestElementObject;
          userObject['requestsSent']['data'].forEach((requestElement) {
            print("requestElement: $requestElement");
            if (requestElement['event']['_id'] == event['_id']) {
              requestElementObject = requestElement;
            }
          });
          if (requestElementObject != null) {
            print("requestElementObject['status']: " +
                requestElementObject['status'].toString());
            if (requestElementObject['status'].toString() == "ACCEPTED") {
              //if not paid off
              if ((double.parse(userEventDetails['amountRemaining']) / 100)
                      .toStringAsFixed(2) !=
                  "0.00") {
                return Container(
                    child: GestureDetector(
                  onTap: () {
                    print("withPayment && withRequest");
                    purchaseEvent(context, event, roles);
                  },
                  child: Text("Pay to Join Game"),
                ));
              }
              //paid off
              else {
                return Container();
              }
            } else if (requestElementObject['status'].toString() == "PENDING") {
              return Container(
                  child: GestureDetector(
                onTap: () {
                  print("WAITING FOR REQUEST TO BE ACCEPTED");
                },
                child: Text("Request Pending"),
              ));
            } else {
              return Container(
                  child: GestureDetector(
                onTap: () {
                  selectedRequestTypeObjects.add("PLAYER");
                  sendEventRequest(event);
                  selectedRequestTypeObjects = [];
                },
                child: Text("Request Denied, Resend Request"),
              ));
            }
          } else {
            return Container(
                child: GestureDetector(
              onTap: () {
                print("withPayment && withRequest");
                selectedRequestTypeObjects.add("PLAYER");
                sendEventRequest(event);
                selectedRequestTypeObjects = [];
              },
              child: Text("Send Request to Join(Payment required to join)"),
            ));
          }
        }
      }
    } else {
      return Container(
          child: GestureDetector(
        onTap: () {
          print("onTap Leave Game");
        },
        child: Text("Leave Game"),
      ));
    }
  }

  void purchaseEvent(BuildContext context, dynamic event, String roles) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CardFormScreen(priceObject: event, roles: roles)),
    );
    // await AdaptyPaymentService().makePurchase();
  }

  Container sendPlayersRequestWidget(BuildContext context, dynamic userEventDetails) {
    return Container(
        child: GestureDetector(
            onTap: () async {
              List<int>? playerIndexes = await showAnimatedDialog<dynamic>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return ClassicListDialogWidget<dynamic>(
                      selectedIndexes: selectedPlayerIndexes,
                      titleText: 'Choose Players',
                      listType: ListType.multiSelect,
                      positiveText: "Next",
                      onPositiveClick: () async{
                        print("onPositiveClick: " );
                        
                        //navigation add

                      },                      

                      onListItemClick: ()  {
                        print("onListItemClick: ");
                         

                      },
                      activeColor: Colors.green,
                      dataList: myTeamList.where((item1) => !userEventDetails['teams'].any((item2) => item2["_id"] == item1["_id"])).toList());
                },
                animationType: DialogTransitionType.size,
                curve: Curves.linear,
              );
              selectedPlayerIndexes = playerIndexes ?? selectedPlayerIndexes;
              print('selectedIndex:${selectedPlayerIndexes?.toString()}');
              playersSelected(selectedPlayerIndexes!);

              if (playersSelectedList.length > 0) {
                List<int>? requestIndexes = await showAnimatedDialog<dynamic>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return ClassicListDialogWidget<dynamic>(
                        selectedIndexes: selectedRequestTypeIndexes,
                        titleText: 'Choose User Type',
                        positiveText: "Send Request",
                        listType: ListType.multiSelect,
                        activeColor: Colors.green,
                        dataList: requestUserTypes);
                  },
                  animationType: DialogTransitionType.size,
                  curve: Curves.linear,
                );

                selectedRequestTypeIndexes =
                    requestIndexes ?? selectedRequestTypeIndexes;
                print(
                    'selectedIndex:${selectedRequestTypeIndexes?.toString()}');
                requestTypeSelected(selectedRequestTypeIndexes);
                sendPlayersEventRequest(event);
              }
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.blue,
              child: Center(child: Text("Send Players Request")),
            )));
  }

  Container sendTeamsRequestWidget(BuildContext context, dynamic userEventDetails) {
    return Container(
        child: GestureDetector(
            onTap: () async {
              List<dynamic> processedTeamList = teamList
                .where((item1) => !userEventDetails['teams'].any((item2) => item2["_id"] == item1["_id"]))
                .map((item) => item['team'])
                .toList();
                //original list (just look at commented code below)
              // teamList.where((item1) => !userEventDetails['teams'].any((item2) => item2["_id"] == item1["_id"])).toList();
              Map<int,dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                    items: processedTeamList,
                    singleSelect: false,
                    secondaryItems: [] );
                },
              );
              if (result.isNotEmpty) {
                print('Selected items: $result');
                // teamsSelected(selectedPlayerIndexes!);
              // sendTeamsEventRequest(event);
                
              }




              // List<int>? playerIndexes = await showAnimatedDialog<dynamic>(
              //   context: context,
              //   barrierDismissible: true,
              //   builder: (BuildContext context) {
              //     return ClassicListDialogWidget<dynamic>(
              //         selectedIndexes: selectedPlayerIndexes,
              //         titleText: 'Choose Teams',
              //         listType: ListType.multiSelect,
              //         positiveText: "Send Request",
              //         activeColor: Colors.green,
              //         //only show teams that aren't in event
              //         dataList: teamList.where((item1) => !userEventDetails['teams'].any((item2) => item2["_id"] == item1["_id"])).toList());
              //   },
              //   animationType: DialogTransitionType.size,
              //   curve: Curves.linear,
              // );
              // selectedPlayerIndexes = playerIndexes ?? selectedPlayerIndexes;
              // print('selectedIndex:${selectedPlayerIndexes?.toString()}');
              // teamsSelected(selectedPlayerIndexes!);
              // sendTeamsEventRequest(event);
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.blue,
              child: Center(child: Text("Send Teams Request")),
            )));
  }

  Container sendOrganizerPlayerEventRequest(BuildContext context) {
    return Container(
      height: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: GestureDetector(
            onTap: () async {                            
              Map<int,dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                    items: requestUserTypes,
                    singleSelect: false,
                    secondaryItems: [] );
                },
              );
              if (result.isNotEmpty) {
                print('Selected items: $result');
                // await requestTypeSelected(selectedRequestTypeIndexes);
                // await sendEventRequest(event);
                
              }






              // print("onTap: ");
              // List<int>? requestIndexes = await showAnimatedDialog<dynamic>(
              //   context: context,
              //   barrierDismissible: true,
              //   builder: (BuildContext context) {
              //     return ClassicListDialogWidget<dynamic>(
              //         selectedIndexes: selectedRequestTypeIndexes,
              //         titleText: 'Choose User Type',
              //         positiveText: "Send Request",
              //         listType: ListType.multiSelect,
              //         activeColor: Colors.green,
              //         dataList: requestUserTypes);
              //   },
              //   animationType: DialogTransitionType.size,
              //   curve: Curves.linear,
              // );

              // selectedRequestTypeIndexes =
              //     requestIndexes ?? selectedRequestTypeIndexes;
              // print('selectedIndex:${selectedRequestTypeIndexes?.toString()}');
              // await requestTypeSelected(selectedRequestTypeIndexes);
              // await sendEventRequest(event);
            },
            child: Text("Send Player Request")),
      ),
    );
  }
  
  Container sendEventRequestForMyTeamWidget(BuildContext context, dynamic userEventDetails) {
    return Container(
        child: GestureDetector(
            onTap: () async {
              print("myTeamList before: "+myTeamList.toString());
              
            List<dynamic> myProcessedTeamList = myTeamList
    .where((item1) => !userEventDetails['teams'].any((item2) => item2["_id"] == item1["_id"]))
    .map((item) => item['team'])
    .toList();

              //  List<String> myTeamList = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
    Map<int,dynamic> result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnimatedDialog(
          items: myProcessedTeamList,
          singleSelect: false,
          secondaryItems: [] );
      },
    );
    if (result.isNotEmpty) {
      print('Selected items: $result');
      teamsSelected(result, myProcessedTeamList);
      sendEventRequestForMyTeam();
      
    }
    
  
            //   List<int>? teamIndexes = await showAnimatedDialog<dynamic>(
            //     context: context,
            //     barrierDismissible: true,
            //     builder: (BuildContext context) {
            //       return ClassicListDialogWidget<dynamic>(
            //           selectedIndexes: selectedTeamIndexes,
            //           titleText: 'Choose Teams',
            //           listType: ListType.multiSelect,
            //           positiveText: "Send Request",                      
            //           // onPositiveClick: () async{
            //           //   print("onPositiveClick: " );
            //           //   print("selectIndex: " + index.toString());
            //           //   //navigation add

            //           // },
            //           activeColor: Colors.green,
            //           dataList: myTeamList.where((item1) => !userEventDetails['teams'].any((item2) => item2["_id"] == item1["_id"])).toList());
            //     },
            //     animationType: DialogTransitionType.size,
            //     curve: Curves.linear,
            //   );
            //   selectedTeamIndexes = teamIndexes ?? selectedTeamIndexes;
            //   print('selectedIndex:${selectedTeamIndexes?.toString()}');
            //   teamsSelected(selectedTeamIndexes!);
            //   sendEventRequestForMyTeam();
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.green,
              child: Center(child: Text("Send My Teams Request")),
            )));
  }

  Container getParticipationRolesWidget() {
    if (participationRoles.length > 0) {
      return Container(child: Text("roles: " + participationRoles.toString()));
    } else {
      return Container();
    }
  }
}
