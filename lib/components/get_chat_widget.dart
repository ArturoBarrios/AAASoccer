import 'package:flutter/material.dart';

import '../commands/event_command.dart';
import '../commands/team_command.dart';
import '../commands/user_command.dart';
import '../views/chats/create.dart';
import '../views/game/view.dart';
import 'Dialogues/animated_dialogu.dart';

class GetChatWidget extends StatefulWidget {
  final dynamic mainEvent;
  final dynamic team;
  final List<dynamic> players;
  final bool isMine;
  final Function updatechatsList;

  GetChatWidget({required this.mainEvent, required this.team, required this.players, required this.isMine, required this.updatechatsList});

  @override
  _GetChatWidgetState createState() => _GetChatWidgetState();
}

class _GetChatWidgetState extends State<GetChatWidget> {  
  List playerList = [];
  dynamic userObject;

  Future<dynamic> createChat(
      BuildContext context,
      bool attachToEvent,
      bool attachToTeam,
      Map<int, dynamic> indexes,
      List<dynamic> primaryList,
      ) async {
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
                  attachToEvent ? widget.mainEvent : null,
              teamObject: attachToTeam ? widget.team : null,
              players: selectedPlayers)),
    );
    return chatObject;
    // updateChatList(chatObject, userObjectDetails);
  }

  Container getChatWidget(
      BuildContext context,
      bool attachToEvent,
      bool attachToTeam,      
      ) {
    print("getChatWidgett: "+widget.isMine.toString());
    
    if (widget.isMine) {
      return Container(
        height:100,
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
                        );
                    if (createdChat != null) {
                      widget.updatechatsList!(createdChat);
                    }
                  }
                } else {
                  print("No players to add but yourself");
                  dynamic createdChat = await createChat(context, attachToEvent,
                      attachToTeam, {}, []);
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
    playerList = widget.players;
    print("playerList: $playerList");
    //remove yourself
    playerList.removeWhere((element) => element['id'] == userObject['id']);
  }

  @override
  void initState() {
    super.initState();
    // loadInitialData();
  }

  @override
  Widget build(BuildContext context) {    
    print("initState() GetChatWidgett "+ widget.mainEvent );
    return Text("chattt");
    // widget.mainEvent != null ? 
    // getChatWidget(context, true, false)
    // : getChatWidget(context, false, true);
     
  }
}
