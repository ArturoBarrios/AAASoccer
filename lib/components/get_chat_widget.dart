import 'package:flutter/material.dart';

import '../commands/event_command.dart';
import '../commands/team_command.dart';
import '../commands/user_command.dart';
import '../views/chats/create.dart';
import '../views/game/view.dart';
import 'Dialogues/animated_dialogu.dart';

class GetChatWidget extends StatefulWidget {
  final Map<String, dynamic> objectEventsDetails;
  final Function updatechatsList;

  GetChatWidget({required this.objectEventsDetails, required this.updatechatsList});

  @override
  _GetChatWidgetState createState() => _GetChatWidgetState();
}

class _GetChatWidgetState extends State<GetChatWidget> {
  List<String> participationRoles = [];
  List playerList = [];
  dynamic userObject;

  Future<dynamic> createChat(
      BuildContext context,
      bool attachToEvent,
      bool attachToTeam,
      Map<int, dynamic> indexes,
      List<dynamic> primaryList,
      dynamic userObjectDetails) async {
    print("createChat");
    List<dynamic> selectedPlayers = [];
    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic playerChosen = primaryList[mainIndex];
      selectedPlayers.add(playerChosen);
    });
    selectedPlayers.add(userObject);
    var chatObject = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatCreate(
              eventObject:
                  attachToEvent ? userObjectDetails['mainEvent'] : null,
              teamObject: attachToTeam ? userObjectDetails['team'] : null,
              players: selectedPlayers)),
    );
    return chatObject;
    // updateChatList(chatObject, userObjectDetails);
  }

  Container getChatWidget(
      BuildContext context,
      bool attachToEvent,
      bool attachToTeam,
      dynamic userObjectDetails,
      ) {
    print("getChatWidget");

    print("participationRoles: $participationRoles");
    if (userObjectDetails['roles'].contains("ORGANIZER")) {
      return Container(
          child: GestureDetector(
              onTap: () async {
                if (!playerList.isEmpty) {
                  print("Add New Chat Pressed");
                  List<dynamic> primaryList = playerList;
                  List<dynamic> secondaryList = [];
                  Map<int, dynamic> result = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AnimatedDialog(
                        details: {"title": "IDK"},
                        items: primaryList,
                        singleSelect: false,
                        secondaryItems: secondaryList,
                        goToFunctions: [],
                      );
                    },
                  );
                  if (result.isNotEmpty) {
                    dynamic createdChat = await createChat(
                        context,
                        attachToEvent,
                        attachToTeam,
                        result,
                        primaryList,
                        userObjectDetails);
                    if (createdChat != null) {
                      widget.updatechatsList!(createdChat);
                    }
                  }
                } else {
                  print("No players to add but yourself");
                  dynamic createdChat = await createChat(context, attachToEvent,
                      attachToTeam, {}, [], userObjectDetails);
                  if (createdChat != null) {
                    widget.updatechatsList!(createdChat);
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

  void loadInitialData() {
    userObject = UserCommand().getAppModelUser();
    playerList = widget.objectEventsDetails['players'];
    print("playerList: $playerList");
    //remove yourself
    playerList.removeWhere((element) => element['id'] == userObject['id']);
  }

  @override
  void initState() {
    super.initState();
    print("initState() GetChatWidget");
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {    
    return
    widget.objectEventsDetails['mainEvent'] != null ? 
    getChatWidget(context, true, false, widget.objectEventsDetails)
    : getChatWidget(context, false, true, widget.objectEventsDetails);
     
  }
}
