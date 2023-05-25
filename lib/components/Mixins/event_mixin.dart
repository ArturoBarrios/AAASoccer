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
    print("playerList: " + playerList.toString());
    print("playerList length: " + playerList.length.toString());
    userObject = UserCommand().getAppModelUser();       
  }

  void setupTeamList() {
    print("setupTeamList");
    teamList = TeamCommand().getAppModelTeamsNearMe();
    //add teamInEvent property
  }

  void setupMyTeams() {
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

  sendEventRequestForMyTeam(dynamic userObjectDetails) {
    print("sendEventRequestForMyTeam: " + teamsSelectedList.toString());
    for (int i = 0; i < teamsSelectedList.length; i++) {
      TeamCommand().sendEventRequestForMyTeam(userObjectDetails['mainEvent'], teamsSelectedList[i]);
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

  void teamsSelected(
      Map<int, dynamic> selectedIndexes, List<dynamic> teamListUsed) {
    print("teamsSelected: $selectedIndexes");
    print("teamList: " + teamList.toString());
    // selectedTeamIndexes = selectedIndexes;
    // teamsSelectedList = [];
    selectedIndexes.forEach((key, secondarySelectedIndexes) {
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

  Future<void> sendPlayersTeamRequest(
    dynamic userObjectDetails, 
    Map<int, dynamic> indexes, 
    List<dynamic> primaryList, List<dynamic> secondaryList
    ) async {
    print("sendPlayersTeamRequest");
    print("userObjectDetails: " + userObjectDetails['team'].toString());
    print("indexes: " + indexes.toString());
    print("primaryList: " + primaryList.toString());
    print("secondaryList: " + secondaryList.toString());    
    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic playerChosen = primaryList[mainIndex];
      dynamic roles = [];
      secondaryIndexes.forEach((secondaryIndex, blankValue) async {
        roles.add(secondaryList[secondaryIndex]);
        print("roles: " + roles.toString());      

        await TeamCommand().sendPlayerTeamRequests(
          playerChosen, [userObjectDetails['team']], roles);
      });
    });    
  }  

  Future<void> sendTeamsEventRequest(dynamic event, 
    Map<int, dynamic> indexes,
    List<dynamic> primaryList, List<dynamic> secondaryList
  ) async {
    print("sendTeamsEventRequest");
    print("primaryList: " + primaryList.toString());
    print("secondaryList: " + secondaryList.toString());
    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic teamChosen = primaryList[mainIndex];
      await TeamCommand().sendTeamEventRequest(teamChosen, event);
    });
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

  Future<void> sendPlayersEventRequest(
      dynamic userObjectDetails,
      Map<int, dynamic> indexes,
      List<dynamic> primaryList,
      List<dynamic> secondaryList) async {
    
    print("sendPlayersEventRequest");
    print("primaryList: " + primaryList.toString());
    print("secondaryList: " + secondaryList.toString());
    
    String type = getRequestType(userObject['mainEvent']);


    
    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic playerChosen = primaryList[mainIndex];
      dynamic roles = [];
      secondaryIndexes.forEach((secondaryIndex, blankValue) {
        roles.add(secondaryList[secondaryIndex]);
      });
      print("roles: " + roles.toString());
      await EventCommand()
          .sendPlayerEventRequests(playerChosen, [userObjectDetails['mainEvent']], roles, type);
    });
  }

  //send organizers event request
  Future<void> sendEventRequest(dynamic eventObject, Map<int, dynamic> indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList) async {
    print("sendEventRequest");
    print("primaryList: " + primaryList.toString());
    print("secondaryList: " + secondaryList.toString());
    String requestType = getRequestType(eventObject);

    indexes.forEach((mainIndex, secondaryIndexesThatIsNull) async {
      dynamic role = primaryList[mainIndex];
      await EventCommand()
          .sendOrganizerEventRequest(eventObject, role, requestType);
    });

    // for (int i = 0; i < selectedRequestTypeObjects.length; i++) {
    //   await EventCommand().sendOrganizerEventRequest(
    //       eventObject, selectedRequestTypeObjects[i], requestType);
    // }
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

  void createChat(BuildContext context, bool attachToEvent, bool attachToTeam,
      Map<int, dynamic> indexes, List<dynamic> primaryList, dynamic userObjectDetails) {
    print("createChat");
    List<dynamic> selectedPlayers = [];
    indexes.forEach((mainIndex, secondaryIndexes) {
      dynamic playerChosen = primaryList[mainIndex];
      selectedPlayers.add(playerChosen);
    });
    selectedPlayers.add(userObject);    
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return ChatCreate(
            eventObject: attachToEvent ? userObjectDetails['mainEvent'] : null,
            teamObject: attachToTeam ? userObjectDetails['team'] : null,
            players: selectedPlayers);
      },
    ));
  }

  Container getChatsWidget(BuildContext context, dynamic userObjectDetails){
    print("getChatsWidget");
    
    return Container(
      child: Text("Number of Chats: "+ userObjectDetails['chats'].length.toString() ) 
      );
  }

  Container getChatWidget(
      BuildContext context, bool attachToEvent, bool attachToTeam,
       dynamic userObjectDetails) {
    print("getChatWidget");
    
    print("participationRoles: $participationRoles");
    if (userObjectDetails['roles'].contains("ORGANIZER")) {
      return Container(
          child: GestureDetector(
              onTap: () async {
                print("Add New Chat Pressed");
                List<dynamic> primaryList = playerList;
                List<dynamic> secondaryList = [];
                Map<int, dynamic> result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AnimatedDialog(
                        items: primaryList,
                        singleSelect: false,
                        secondaryItems: secondaryList);
                  },
                );
                if (result.isNotEmpty) {
                  createChat(context, attachToEvent, attachToTeam, result,
                      primaryList, userObjectDetails);
                }
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

  Container getTeamPriceWidget(dynamic userObjectDetails) {
    print("getPriceWidget()");
    print("userObjectDetails: " + userObjectDetails.toString());
    if (userObjectDetails['price'] != null) {
      String teamAmount = (double.parse(userObjectDetails['price']['teamAmount']) / 100)
          .toStringAsFixed(2);
      String teamAmountPaid = (double.parse(userObjectDetails['teamAmountPaid']) / 100)
          .toStringAsFixed(2);
      String teamAmountRemaining =
          (double.parse(userObjectDetails['teamAmountRemaining']) / 100)
              .toStringAsFixed(2);
      if (!userObjectDetails['roles'].contains("ORGANIZER")) {
        if (teamAmountRemaining == "0.00") {
          return Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Text("Price: \$${(teamAmount)}"),
                IconButton(
                  icon: const Icon(Icons.check_circle),
                  tooltip: 'Go to the next page',
                  onPressed: () {},
                ),
              ]));
        }
        //double.parse(teamAmountRemaining)>0.00
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
                      "Price: \$${(teamAmount)}",
                      style: TextStyle(fontSize: 16),
                    ),
                    userObjectDetails['isMember']
                        ? Text(
                            "Remaining Balance: \$$teamAmountRemaining",
                            style: TextStyle(fontSize: 16),
                          )
                        : Container()
                  ])
            ],
          ));
        }
      } else {
        return Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Text(
                      "Set Price: \$${(teamAmount)}",
                      style: TextStyle(fontSize: 16),
                    ),
                    
                  ])
            ],

        ));
      }
    } else {
      return Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("FREE!")],
      ));
    }
  }

  Container getPriceWidget(dynamic userObjectDetails) {
    print("getPriceWidget()");
    print("userObjectDetails: " + userObjectDetails.toString());
    if (userObjectDetails['price'] != null) {
      String amount = (double.parse(userObjectDetails['price']['amount']) / 100)
          .toStringAsFixed(2);
      String amountPaid = (double.parse(userObjectDetails['amountPaid']) / 100)
          .toStringAsFixed(2);
      String amountRemaining =
          (double.parse(userObjectDetails['amountRemaining']) / 100)
              .toStringAsFixed(2);
      if (!userObjectDetails['roles'].contains("ORGANIZER")) {
        if (amountRemaining == "0.00") {
          return Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Text("Price: \$${(amount)}"),
                IconButton(
                  icon: const Icon(Icons.check_circle),
                  tooltip: 'Go to the next page',
                  onPressed: () {},
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
                    userObjectDetails['isMember']
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
        return Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Text(
                      "Set Price: \$${(amount)}",
                      style: TextStyle(fontSize: 16),
                    ),
                    
                  ])
            ],

        ));
      }
    } else {
      return Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("FREE!")],
      ));
    }
  }

  Container getJoinGameWidget(BuildContext context, dynamic userObjectDetails,
      dynamic event, dynamic userInput) {
    print("userObjectDetails['roles']: "+ userObjectDetails['roles'].toString());
    
    //if not already a player
    if (!userObjectDetails['roles'].contains("PLAYER")) {
      String roles = addRoleToRoles("PLAYER");
      if (userObjectDetails['isMine']) {
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
          if (userObjectDetails['price'] != null) {
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
              sendEventRequest(event, {0: {}}, requestUserTypes, []);
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
            print("event: " + event.toString());
            if (requestElement['type']!='TEAMREQUEST' && requestElement['event']['_id'] == event['_id']) {
              requestElementObject = requestElement;
            }
          });
          if (requestElementObject != null) {
            print("requestElementObject['status']: " +
                requestElementObject['status'].toString());
            if (requestElementObject['status'].toString() == "ACCEPTED") {
              //if not paid off
              if ((double.parse(userObjectDetails['amountRemaining']) / 100)
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
                  sendEventRequest(event, {0: {}}, requestUserTypes, []);
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
                sendEventRequest(event, {0: {}}, requestUserTypes, []);
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

  //send player events/teams request
  Container sendPlayersRequestWidget(
      BuildContext context, dynamic userObjectDetails) {
        print("sendPlayersRequestWidget: "+ userObjectDetails.toString());
        
    return Container(
        child: GestureDetector(
            onTap: () async {
              List<dynamic> primaryList = playerList;
              List<dynamic> secondaryList = requestUserTypes;
              Map<int, dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                      items: playerList,
                      singleSelect: false,
                      secondaryItems: requestUserTypes);
                },
              );
              if (result.isNotEmpty) {
                  print("result: " + result.toString());
                if(userObjectDetails['mainEvent'] != null){
                  sendPlayersEventRequest(
                      userObjectDetails, result, primaryList, secondaryList);
                 
                }
                else{
                  sendPlayersTeamRequest(userObjectDetails, result , primaryList, secondaryList);
                }
              }
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.blue,
              child: Center(child: Text("Send Players Request")),
            )));
  }


  //send players events request
  Container sendPlayerEventsRequestWidget(
      BuildContext context, dynamic userObjectDetails) {
        print("sendPlayersRequestWidget: "+ userObjectDetails.toString());
        
    return Container(
        child: GestureDetector(
            onTap: () async {
              List<dynamic> primaryList = myEventsToChooseFrom;
              List<dynamic> secondaryList = requestUserTypes;
              Map<int, dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                      items: primaryList,
                      singleSelect: false,
                      secondaryItems: secondaryList);
                },
              );
              if (result.isNotEmpty) {
                  print("result: " + result.toString());
                if(userObjectDetails['mainEvent'] != null){
                  sendPlayersEventRequest(
                      userObjectDetails, result, primaryList, secondaryList);
                 
                }
                else{
                  sendPlayersTeamRequest(userObjectDetails, result , primaryList, secondaryList);
                }
              }
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.blue,
              child: Center(child: Text("Send Players Request")),
            )));
  }

  Container sendPlayerTeamsRequestWidget(
      BuildContext context, dynamic userObjectDetails) {
        print("sendPlayersRequestWidget: "+ userObjectDetails.toString());
        
    return Container(
        child: GestureDetector(
            onTap: () async {
              List<dynamic> primaryList = myTeamsToChooseFrom;
              List<dynamic> secondaryList = requestUserTypes;
              Map<int, dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                      items: myTeamsToChooseFrom,
                      singleSelect: false,
                      secondaryItems: secondaryList);
                },
              );
              if (result.isNotEmpty) {
                print("result: " + result.toString());               
                sendPlayersTeamRequest(userObjectDetails, result , primaryList, secondaryList);               
              }
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.blue,
              child: Center(child: Text("Send Player Team Request")),
            )));
  }

  Container sendTeamsRequestWidget(
      BuildContext context, dynamic userObjectDetails) {
    return Container(
        child: GestureDetector(
            onTap: () async {
              List<dynamic> primaryList = playerList;
              List<dynamic> secondaryList = [];
              List<dynamic> processedTeamList = teamList
                  .where((item1) => !userObjectDetails['teams']
                      .any((item2) => item2["_id"] == item1["_id"]))
                  .map((item) => item['team'])
                  .toList();
              primaryList = processedTeamList;
              //original list (just look at commented code below)
              // teamList.where((item1) => !userObjectDetails['teams'].any((item2) => item2["_id"] == item1["_id"])).toList();
              Map<int, dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                      items: primaryList,
                      singleSelect: false,
                      secondaryItems: secondaryList);
                },
              );
              if (result.isNotEmpty) {
                print('Selected items: $result');
                sendTeamsEventRequest(
                    userObjectDetails['mainEvent'], result, primaryList, secondaryList);
              }
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.blue,
              child: Center(child: Text("Send Teams Request")),
            )));
  }

  Container sendOrganizerPlayerEventRequest(BuildContext context, dynamic userObjectDetails) {
    return Container(
      height: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: GestureDetector(
            onTap: () async {
              List<dynamic> primaryList = requestUserTypes;
              List<dynamic> secondaryList = [];
              Map<int, dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                      items: primaryList,
                      singleSelect: false,
                      secondaryItems: secondaryList);
                },
              );
              if (result.isNotEmpty) {
                print('Selected items: $result');
                // await requestTypeSelected(selectedRequestTypeIndexes);
                await sendEventRequest(
                    userObjectDetails['mainEvent'], result, primaryList, secondaryList);
              }
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.green,
              child: Center(child: Text("Send Player Request")),
            )),
      ),
    );
  }

  Container sendEventRequestForMyTeamWidget(
      BuildContext context, dynamic userObjectDetails) {
    return Container(
        child: GestureDetector(
            onTap: () async {
              print("myTeamList before: " + myTeamList.toString());

              List<dynamic> myProcessedTeamList = myTeamList
                  .where((item1) => !userObjectDetails['teams']
                      .any((item2) => item2["_id"] == item1["_id"]))
                  .map((item) => item['team'])
                  .toList();

              //  List<String> myTeamList = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
              Map<int, dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                      items: myProcessedTeamList,
                      singleSelect: false,
                      secondaryItems: []);
                },
              );
              if (result.isNotEmpty) {
                print('Selected items: $result');
                teamsSelected(result, myProcessedTeamList);
                sendEventRequestForMyTeam(userObjectDetails);
              }
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

  Future<dynamic> getPlayerListWidgetDetails(userObjectDetails) async{
    dynamic res = {
      'players': userObjectDetails['players'],
      'userParticipants': userObjectDetails['userParticipants'],
    };
    return res;
  }


}
