import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/views/request/view.dart';

import '../../commands/base_command.dart';
import '../../commands/event_command.dart';
import '../../commands/images_command.dart';
import '../../commands/player_command.dart';
import '../../commands/requests_command.dart';
import '../../commands/team_command.dart';
import '../../commands/user_command.dart';
import '../../constants.dart';
import '../../views/chats/create.dart';
import '../Dialogues/animated_dialogu.dart';
import '../card_form_screen.dart';
import '../create_event_payment.dart';
import '../create_event_request.dart';
import '../create_team_payment.dart';
import '../create_team_request.dart';

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

  CreateEventRequest createEventRequestWidget = new CreateEventRequest();
  CreateEventPayment createEventPaymentWidget = new CreateEventPayment();
  CreateTeamPayment createTeamPaymentWidget = new CreateTeamPayment();
  CreateTeamRequest createTeamRequestWidget = new CreateTeamRequest();    

  void setupPlayerList() {
    print("setupPlayerList");
    playerList = PlayerCommand().getAppModelPlayersNearMe();
    print("playerList: " + playerList.toString());
    print("playerList length: " + playerList.length.toString());
    userObject = UserCommand().getAppModelUser();
  }

  Future<void> setupTeamList() async {
    print("setupTeamList");
    teamList = await TeamCommand().getAppModelTeamsNearMe();
    teamList.forEach((element) {
      print("teamList element: " + element.toString());
      
    });
    //add teamInEvent property
  }

  void setupMyTeams() {
    print("setupMyTeams");
    dynamic getAppModelMyTeams = UserCommand().getAppModelMyTeams();
    myTeamList = getAppModelMyTeams;
    
  }




  void setupEventsToChooseFrom() {
    print("setupEventsToChooseFrom");
    List<dynamic> myEvents = UserCommand().getAppModelMyEvents();
    myEventsToChooseFrom = myEvents;
    choices = myEventsToChooseFrom;
  }


  
  //used in Event View
  //send my team an event request
  sendEventRequestForMyTeam(Map<int, dynamic> indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList,
      dynamic userObjectDetails  ) {
    print("sendEventRequestForMyTeam: " + indexes.toString());
    indexes.forEach((mainIndex, secondaryIndexesThatIsNull) async {
      dynamic teamSelected = primaryList[mainIndex];
      if(userObjectDetails['isMine']){
        //add team to event
        print("add team to event");
      }
      else{
        TeamCommand().sendEventRequestForMyTeam(
          userObjectDetails['mainEvent'], teamSelected);

      }

    });   
  }
  
  //used in Team view
  //send a team request to my events
  Future<void> sendMyEventsRequestForTeam(Map<int, dynamic> indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList,
      dynamic userObjectDetails, Function addEventcallback  ) async {
    print("sendMyEventsRequestForTeam: " + indexes.toString());
    indexes.forEach((mainIndex, secondaryIndexesThatIsNull) async {
      dynamic eventSelected = primaryList[mainIndex];
      if(userObjectDetails['isMine']){
        //add team to event
        await EventCommand().addTeamToEvent(eventSelected, userObjectDetails['team']);        
        print("add team to event");
        addEventcallback(eventSelected);
      }
      
      //add team to my event

    });   
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
      List<dynamic> primaryList,
      List<dynamic> secondaryList) async {
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

  Future<void> sendTeamsEventRequest(dynamic event, Map<int, dynamic> indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList, dynamic userObjectDetails) async {
    print("sendTeamsEventRequest");
    print("primaryList: " + primaryList.toString());
    print("secondaryList: " + secondaryList.toString());
    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic teamChosen = primaryList[mainIndex];
      bool isMyTeam = false;
      isMyTeam = userObjectDetails['roles'].contains("ORGANIZER");
      //check if player is a team and organizer, if so, add to list
      if(event[userObjectDetails['isMine']] && isMyTeam){
        print("isMyTeam");
        teamList.remove(teamChosen);
        await EventCommand().addTeamToEvent(event, teamChosen);
        userObjectDetails['teams'].add(teamChosen);
      }
      else{
        await TeamCommand().sendTeamEventRequest(teamChosen, event);

      }
    });
  }

  Future<void> sendEventRequestForMyTeams(
      dynamic event,
      Map<int, dynamic> indexes,
      List<dynamic> primaryList,
      List<dynamic> secondaryList) async {
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
      await EventCommand().sendPlayerEventRequests(
          playerChosen, [userObjectDetails['mainEvent']], roles, type);
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

  Future<dynamic> createChat(
      BuildContext context,
      bool attachToEvent,
      bool attachToTeam,
      Map<int, dynamic> indexes,
      List<dynamic> primaryList,
      dynamic userObjectDetails) async {
    print("createChat");
    List<dynamic> selectedPlayers = [];
    indexes.forEach((mainIndex, secondaryIndexes) async{
      dynamic playerChosen = primaryList[mainIndex];
      selectedPlayers.add(playerChosen);
    });
    selectedPlayers.add(userObject);
    var chatObject = await Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => ChatCreate(
            eventObject: attachToEvent ? userObjectDetails['mainEvent'] : null,
            teamObject: attachToTeam ? userObjectDetails['team'] : null,
            players: selectedPlayers)),
);  
    return chatObject;
    // updateChatList(chatObject, userObjectDetails);

  }

  void updateChatList(dynamic newChat, dynamic userObjectDetails){
    print("updateChatList()");
    userObjectDetails['mainEvent']['chats']['data'].add(newChat);
  }

  Container getChatsWidget(BuildContext context, dynamic userObjectDetails) {
    print("getChatsWidget");

    return Container(
        child: Text("Number of Chats: " +
            userObjectDetails['chats'].length.toString()));
  }

  Container getChatWidget(BuildContext context, bool attachToEvent,
      bool attachToTeam, dynamic userObjectDetails, Function? createdChatFunction) {
    print("getChatWidget");

    print("participationRoles: $participationRoles");
    if (userObjectDetails['roles'].contains("ORGANIZER")) {
      return Container(
          child: GestureDetector(
              onTap: () async {
                if(!playerList.isEmpty){
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
                    dynamic createdChat = await createChat(context, attachToEvent, attachToTeam, result,primaryList, userObjectDetails);
                    if(createdChat != null){
                      createdChatFunction!(createdChat);
                    }
                  }
                  
                }
                else{
                  print("No players to add but yourself");
                  dynamic createdChat = await createChat(context, attachToEvent, attachToTeam, {}, [], userObjectDetails);
                  if(createdChat != null){
                      createdChatFunction!(createdChat);
                    }

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
    print("getTeamPriceWidget()");
    print("userObjectDetails: " + userObjectDetails.toString());
    if (userObjectDetails['price'] != null) {
      String teamAmount =
          (double.parse(userObjectDetails['price']['teamAmount']) / 100)
              .toStringAsFixed(2);
      String teamAmountPaid =
          (double.parse(userObjectDetails['teamAmountPaid']) / 100)
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
        return Container(
            child: Row(
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
        return Container(
            child: Row(
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
    print("getJoinGameWidget()");
    dynamic eventJoinCondition = getEventJoinConditions(event['joinConditions']['data']);
    print("eventJoinCondition: "+eventJoinCondition.toString());
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
        if (!eventJoinCondition['withPayment'] &&
            !eventJoinCondition['withRequest']) {
          //price exists(join with paying or not paying)
          if (userObjectDetails['price'] != null) {
            return Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  GestureDetector(
                    onTap: () {
                      print("!withPayment&&!withRequest");
                      purchaseEvent(context, event, roles, userObjectDetails);
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
        else if (!eventJoinCondition['withPayment'] &&
            eventJoinCondition['withRequest']) {
          return sendOrganizerPlayerEventRequest(context, userObjectDetails);
          // return Container(
          //     child: GestureDetector(
          //   onTap: () {
          //     print("!withPayment&&!withRequest");
          //     selectedRequestTypeObjects.add("PLAYER");
          //     sendEventRequest(event, {0: {}}, requestUserTypes, []);
          //     selectedRequestTypeObjects = [];
          //   },
          //   child: Text("Send Request to Join(No Payment required to join)"),
          // ));
        }
        //withPayment && !withRequest
        else if (eventJoinCondition['withPayment'] &&
            !eventJoinCondition['withRequest']) {
          //if amount is 0

          return Container(
              child: GestureDetector(
            onTap: () {
              print("withPayment && !withRequest");
              purchaseEvent(context, event, roles, userObjectDetails);
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
            if (requestElement['type'] != 'TEAMREQUEST' &&
                requestElement['event']['_id'] == event['_id']) {
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
                    purchaseEvent(context, event, roles, userObjectDetails);
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
              return sendOrganizerPlayerEventRequest(
                  context, userObjectDetails);
              // return Container(
              //     child: GestureDetector(
              //   onTap: () {
              //     selectedRequestTypeObjects.add("PLAYER");
              //     sendEventRequest(event, {0: {}}, requestUserTypes, []);
              //     selectedRequestTypeObjects = [];
              //   },
              //   child: Text("Request Denied, Resend Request"),
              // ));
            }
          } else {
            return sendOrganizerPlayerEventRequest(context, userObjectDetails);
            // return Container(
            //     child: GestureDetector(
            //   onTap: () {
            //     print("withPayment && withRequest");
            //     selectedRequestTypeObjects.add("PLAYER");
            //     sendEventRequest(event, {0: {}}, requestUserTypes, []);
            //     selectedRequestTypeObjects = [];
            //   },
            //   child: Text("Send Request to Join(Payment required to join)"),
            // ));
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

  dynamic getEventJoinConditions(dynamic joinConditions){
    print("getEventJoinConditions");
    print("joinConditions: "+joinConditions.toString());
    dynamic joinConditionResp = null;
    joinConditions.forEach((joinCondition) {
      print("joinCondition: "+ joinCondition.toString());
      if(joinCondition['forEvent']!=null){
        print("in ifffff");
        joinConditionResp = joinCondition;
      }
      
    });

    return joinConditionResp;

  }

  dynamic getTeamJoinConditions(dynamic joinConditions){
    print("getTeamJoinConditions");
    print("joinConditions: "+joinConditions.toString());
    dynamic joinConditionResp = null;
    joinConditions.forEach((joinCondition) {
      print("joinCondition: "+ joinCondition.toString());
      if(joinCondition['forEvent'] == null){
        joinConditionResp = joinCondition;
      }      
    });

    return joinConditionResp;

  }

  Map<String,dynamic> setupRequestWidgetData(dynamic userObjectDetails){
    print("setupRequestWidgetData()");

    CreateEventRequest createEventRequestWidget = new CreateEventRequest();
    CreateEventPayment createEventPaymentWidget = new CreateEventPayment();
    CreateTeamRequest createTeamRequestWidget = new CreateTeamRequest();
    CreateTeamPayment createTeamPaymentWidget = new CreateTeamPayment();
    dynamic setupRequestWidgetDataResp = {
      'createEventRequestWidget': createEventRequestWidget,
      'createEventPaymentWidget': createEventPaymentWidget,
      'createTeamRequestWidget': createTeamRequestWidget,
      'createTeamPaymentWidget': createTeamPaymentWidget,
    };
    dynamic joinConditions = [];
    if(userObjectDetails['mainEvent']!=null){
      joinConditions = userObjectDetails['mainEvent']['joinConditions']['data'];
    }
    else{
      joinConditions = userObjectDetails['team']['joinConditions']['data'];
    }
      joinConditions.forEach((joinCondition) {
        if(joinCondition['forEvent'] != null){
          createEventRequestWidget = new CreateEventRequest(withRequest: joinCondition['withRequest']);
          createEventPaymentWidget = new CreateEventPayment(withPayment: joinCondition['withPayment']);
                    
        }
        else{
          createTeamRequestWidget = new CreateTeamRequest(withRequest: joinCondition['withRequest']);
          createTeamPaymentWidget = new CreateTeamPayment(withPayment: joinCondition['withPayment']);
        } 
               
      });
    
    

    setupRequestWidgetDataResp['createEventRequestWidget'] = createEventRequestWidget;
    setupRequestWidgetDataResp['createEventPaymentWidget'] = createEventPaymentWidget;
    setupRequestWidgetDataResp['createTeamRequestWidget'] = createTeamRequestWidget;
    setupRequestWidgetDataResp['createTeamPaymentWidget'] = createTeamPaymentWidget;

    return setupRequestWidgetDataResp;
  }

  Container getJoinTeamWidget(BuildContext context, dynamic userObjectDetails,
      dynamic team, dynamic userInput) {
    print("getJoinTeamWidget");
    print(
        "userObjectDetails['roles']: " + userObjectDetails['roles'].toString());
    dynamic teamJoinCondition = getTeamJoinConditions(team['joinConditions']['data']);
    print("teamJoinCondition: "+teamJoinCondition.toString());
    //if not already a player
    if (!userObjectDetails['roles'].contains("PLAYER")) {
      String roles = addRoleToRoles("PLAYER");
      if (userObjectDetails['isMine']) {
        return Container(
            child: GestureDetector(
          onTap: () {
            print("onTap Join My Team");
            TeamCommand().addUserToTeam(team, userInput, roles);
          },
          child: Text("Join my Team"),
        ));
      } else {
        //!withPayment&&!withRequest
        if (!teamJoinCondition['withPayment'] &&
            !teamJoinCondition['withRequest']) {
          //price exists(join with paying or not paying)
          if (userObjectDetails['price'] != null) {
            return Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  GestureDetector(
                    onTap: () {
                      print("!withPayment&&!withRequest");
                      purchaseTeam(context, team, roles, userObjectDetails);
                    },
                    child: Text("Join Team, Pay Now"),
                  ),
                  Container(
                      child: GestureDetector(
                    onTap: () {
                      print("!withPayment&&!withRequest");
                      TeamCommand().addUserToTeam(team, userInput, roles);
                    },
                    child: Text("Join Team, Pay Later"),
                  ))
                ]));
          }
          //price does not exist
          else {
            return Container(
                child: GestureDetector(
              onTap: () {
                print("!withPayment&&!withRequest");
                TeamCommand().addUserToTeam(team, userInput, roles);
              },
              child: Text("Join Team, Pay Later"),
            ));
          }
        }
        //!withPayment&&withRequestt
        else if (!teamJoinCondition['withPayment'] &&
            teamJoinCondition['withRequest']) {
          return sendEventRequestForMyTeamWidget(context, userObjectDetails);
          // return Container(
          //     child: GestureDetector(
          //   onTap: () {
          //     print("!withPayment&&!withRequest");
          //     selectedRequestTypeObjects.add("PLAYER");
          //     sendTeamRequest(team, {0: {}}, requestUserTypes, []);
          //     selectedRequestTypeObjects = [];
          //   },
          //   child: Text("Send Request to Join(No Payment required to join)"),
          // ));
        }
        //withPayment && !withRequest
        else if (teamJoinCondition['withPayment'] &&
            !teamJoinCondition['withRequest']) {
          //if amount is 0

          return Container(
              child: GestureDetector(
            onTap: () {
              print("withPayment && !withRequest");
              purchaseTeam(context, team, roles, userObjectDetails);
            },
            child: Text("Pay to Join Team"),
          ));
        }
        //withPayment && withRequest
        //find request element, else send request
        else {
          print("elseeee");
          print("userObject['requestsSent']: ${userObject['requestsSent']}");
          //check team request status
          dynamic requestElementObject;
          userObject['requestsSent']['data'].forEach((requestElement) {
            print("requestElement: $requestElement");
            print("team: " + team.toString());
            if (requestElement['type'] != 'TEAMREQUEST' &&
                requestElement['team']['_id'] == team['_id']) {
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
                    purchaseTeam(context, team, roles, userObjectDetails);
                  },
                  child: Text("Pay to Join Team"),
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
              return sendEventRequestForMyTeamWidget(
                  context, userObjectDetails);
              // return Container(
              //     child: GestureDetector(
              //   onTap: () {
              //     selectedRequestTypeObjects.add("PLAYER");
              //     sendTeamRequest(team, {0: {}}, requestUserTypes, []);
              //     selectedRequestTypeObjects = [];
              //   },
              //   child: Text("Request Denied, Resend Request"),
              // ));
            }
          } else {
            return sendEventRequestForMyTeamWidget(context, userObjectDetails);
            // return Container(
            //     child: GestureDetector(
            //   onTap: () {
            //     print("withPayment && withRequest");
            //     selectedRequestTypeObjects.add("PLAYER");
            //     sendTeamRequest(team, {0: {}}, requestUserTypes, []);
            //     selectedRequestTypeObjects = [];
            //   },
            //   child: Text("Send Request to Join(Payment required to join)"),
            // ));
          }
        }
      }
    } else {
      return Container(
          child: GestureDetector(
        onTap: () {
          print("onTap Leave Team");
        },
        child: Text("Leave Team"),
      ));
    }
  }

  void purchaseTeam(BuildContext context, dynamic team, String roles,
      dynamic userObjectDetails) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardFormScreen(
              priceObject: team,
              roles: roles,
              userObjectDetails: userObjectDetails)),
    );
    // await AdaptyPaymentService().makePurchase();
  }

  void purchaseEvent(BuildContext context, dynamic event, String roles,
      dynamic userObjectDetails) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardFormScreen(
              priceObject: event['price'],
              roles: roles,
              userObjectDetails: userObjectDetails)),
    );
    // await AdaptyPaymentService().makePurchase();
  }

  //send player events/teams request
  Container sendPlayersRequestWidget(
      BuildContext context, dynamic userObjectDetails) {
    print("sendPlayersRequestWidget: " + userObjectDetails.toString());
    setupPlayerList();
    print("playersList: " + playerList.length.toString());
    if(userObjectDetails['isMine']){
      return Container(
          child: GestureDetector(
              onTap: () async {
                List<dynamic> primaryList = playerList;
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
                  if (userObjectDetails['mainEvent'] != null) {
                    sendPlayersEventRequest(
                        userObjectDetails, result, primaryList, secondaryList);
                  } else {
                    sendPlayersTeamRequest(
                        userObjectDetails, result, primaryList, secondaryList);
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
    else{
      return sendOrganizerPlayerEventRequest(context, userObjectDetails);                

    }
  }

  //send players events request
  Container sendPlayerEventsRequestWidget(
      BuildContext context, dynamic userObjectDetails) {
    print("sendPlayersRequestWidget: " + userObjectDetails.toString());

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
                if (userObjectDetails['mainEvent'] != null) {
                  sendPlayersEventRequest(
                      userObjectDetails, result, primaryList, secondaryList);
                } else {
                  sendPlayersTeamRequest(
                      userObjectDetails, result, primaryList, secondaryList);
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
    print("sendPlayersRequestWidget: " + userObjectDetails.toString());

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
                sendPlayersTeamRequest(
                    userObjectDetails, result, primaryList, secondaryList);
              }
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.blue,
              child: Center(child: Text("Send Player Team Request")),
            )));
  }

  Container sendMyEventsTeamRequestWidget(
    BuildContext context, dynamic userObjectDetails, Function callback
  ){
    print("sendMyEventsTeamRequestWidget");
    setupEventsToChooseFrom();
    return Container(
        child: GestureDetector(
            onTap: () async {
              List<dynamic> primaryList = myEventsToChooseFrom;
              List<dynamic> secondaryList = [];
              print("primaryList: "+ primaryList.toString());
              List<dynamic> myProcessedEventList = primaryList
                  .where((item1) => !userObjectDetails['team']['events']['data']
                      .any((item2) => item2["_id"] == item1["_id"]))
                  .map((item) => item['event'])
                  .toList();
              primaryList = myProcessedEventList;
              print("myProcessedEventList primaryList: " + primaryList.toString());
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
                sendMyEventsRequestForTeam(
                    result, primaryList, secondaryList, userObjectDetails, callback);
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
    print("sendTeamsRequestWidget: " + userObjectDetails.toString());
    setupTeamList();
        if(userObjectDetails['isMine']){
          print("isMine");
          return Container(
              child: GestureDetector(
                  onTap: () async {
                    List<dynamic> primaryList = [];
                    List<dynamic> secondaryList = [];
                    List<dynamic> processedTeamList = teamList
                        .where((item1) => !userObjectDetails['teams']
                            .any((item2) => item2["_id"] == item1["_id"]))
                        .map((item) => item['name'])
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
                      sendTeamsEventRequest(userObjectDetails['mainEvent'], result,
                          primaryList, secondaryList, userObjectDetails);
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    color: Colors.blue,
                    child: Center(child: Text("Send Teams Request")),
                  )));
        }
        else{
          return sendEventRequestForMyTeamWidget(context, userObjectDetails);                
        }
  }

  Container sendOrganizerPlayerEventRequest(
      BuildContext context, dynamic userObjectDetails) {
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
                await sendEventRequest(userObjectDetails['mainEvent'], result,
                    primaryList, secondaryList);
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
    print("sendEventRequestForMyTeamWidget");
    setupMyTeams();
    return Container(
        child: GestureDetector(
            onTap: () async {
              print("myTeamList before: " + myTeamList.toString());

              List<dynamic> myProcessedTeamList = myTeamList
                  .where((item1) => !userObjectDetails['teams']
                      .any((item2) => item2["_id"] == item1["_id"]))
                  .map((item) => item['team'])
                  .toList();
              List<dynamic> secondaryList = [];

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
                // teamsSelected(result, myProcessedTeamList);
                sendEventRequestForMyTeam(result, myProcessedTeamList,
                    secondaryList, userObjectDetails);
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

  
  
  Future<dynamic> getTeamListWidgetDetails(userObjectDetails) async {
    dynamic res = {
      'players': userObjectDetails['players'],
      'userParticipants': userObjectDetails['userParticipants'],
      'team': userObjectDetails['team'],
      'teams': userObjectDetails['teams'],
      'mainEvent': userObjectDetails['mainEvent'],
    };
    return res;
  }


}
