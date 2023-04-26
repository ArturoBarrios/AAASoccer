import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/commands/team_command.dart';
import '../../commands/event_command.dart';
import '../../commands/player_command.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/headers.dart';
import '../../constants.dart';

class TeamView extends StatefulWidget with EventMixin {
  TeamView({Key? key, required this.teamObject, required this.isMyTeam})
      : super(key: key);
  final Map<String, dynamic> teamObject;
  final bool isMyTeam;

  @override
  _TeamViewState createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  bool _isLoading = false;

  void goBack() {
    Navigator.pop(context);
  }

  // int selectIndex = 0;
  // int chosenRequestType = 0;
  // List requestUserTypes = [
  //   Constants.PLAYER.toString(),
  //   Constants.ORGANIZER.toString(),
  //   Constants.MANAGER.toString(),
  //   Constants.MAINCOACH.toString(),
  //   Constants.ASSISTANTCOACH.toString(),
  //   Constants.REF.toString(),
  // ];
  // List playerList = [];
  // List playersSelectedList = [];
  // List<int>? selectedPlayerIndexes;
  // List<int>? selectedRequestTypeIndexes;
  // List<String> selectedRequestTypeObjects = [];

  void setupPlayerList() {
    widget.setupPlayerList();
    // print("setupPlayerList");
    // playerList = PlayerCommand().getAppModelPlayersNearMe();
  }

  void playersSelected(List<int> selectedIndexes) {
    widget.playersSelected(selectedIndexes);
    // print("playersSelected: $selectedIndexes");
    // selectedPlayerIndexes = selectedIndexes;
    // playersSelectedList = [];
    // for (int i = 0; i < selectedIndexes.length; i++) {
    //   playersSelectedList.add(playerList[selectedIndexes[i]]);
    // }
  }

  requestTypeSelected(List<int>? indexes) {
    widget.requestTypeSelected(indexes);
    // print("requestTypeSelected: " + indexes.toString());
    // selectedRequestTypeIndexes = indexes;
    // for (int i = 0; i < indexes!.length; i++) {
    //   selectedRequestTypeObjects.add(requestUserTypes[indexes[i]]);
    // }    
  }

  Future<void> sendPlayersTeamRequest() async {
    widget.sendPlayersTeamRequest(widget.teamObject);
    // print("sendPlayersTeamRequest");
    // print("selectedRequestTypeObjects.length: " +
    //     selectedRequestTypeObjects.length.toString());
    // print(
    //     "playersSelectedList.length: " + playersSelectedList.length.toString());
    // print(
    //     "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    // print("send player team request");
    // for (int i = 0; i < playersSelectedList.length; i++) {
    //   await TeamCommand().sendPlayerTeamRequests(playersSelectedList[i],
    //       [widget.teamObject], selectedRequestTypeObjects);
    // }
  }

  Future<void> sendTeamRequest() async {
    widget.sendTeamRequest(widget.teamObject);
    // print("sendTeamRequest");
    // print("selectedRequestTypeObjects.length: " +
    //     selectedRequestTypeObjects.length.toString());
    // print(
    //     "playersSelectedList.length: " + playersSelectedList.length.toString());
    // print(
    //     "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    // print("send team request");
    // for(int i = 0; i < selectedRequestTypeObjects.length; i++) {
    //   await TeamCommand().sendOrganizerTeamRequest(widget.teamObject, selectedRequestTypeObjects[i]);
    // }
    

  }

   Container getChatWidget() {
    return widget.getChatWidget(context, false, true);
  }

  @override 
  void initState() {
    super.initState();
    widget.loadTeamInfo(widget.teamObject);
  }

  @override
  Widget build(BuildContext context) {
    print("build() in TeamView");
    print("teamObject: " + widget.teamObject.toString());
    setupPlayerList();
    return Scaffold(
      appBar:
          Headers().getBackHeader(context, "Team " + widget.teamObject['name']),
      body: Center(
          child: Column(children: [
        Text("isMyTeam: " + widget.isMyTeam.toString()),
        widget.isMyTeam
            ? Container(
                height: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                      onTap: () async {
                        print("onTap: ");

                        List<int>? playerIndexes =
                            await showAnimatedDialog<dynamic>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return ClassicListDialogWidget<dynamic>(
                                selectedIndexes: widget.selectedPlayerIndexes,
                                titleText: 'Choose Players',
                                listType: ListType.multiSelect,
                                positiveText: "Next",
                                activeColor: Colors.green,
                                dataList: widget.playerList);
                          },
                          animationType: DialogTransitionType.size,
                          curve: Curves.linear,
                        );
                        widget.selectedPlayerIndexes =
                            playerIndexes ?? widget.selectedPlayerIndexes;
                        print(
                            'selectedIndex:${widget.selectedPlayerIndexes?.toString()}');
                        playersSelected(widget.selectedPlayerIndexes!);

                        if (widget.playersSelectedList.length > 0) {
                          List<int>? requestIndexes =
                              await showAnimatedDialog<dynamic>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return ClassicListDialogWidget<dynamic>(
                                  selectedIndexes: widget.selectedRequestTypeIndexes,
                                  titleText: 'Choose User Type',
                                  positiveText: "Send Request",
                                  listType: ListType.multiSelect,
                                  activeColor: Colors.green,
                                  dataList: widget.requestUserTypes);
                            },
                            animationType: DialogTransitionType.size,
                            curve: Curves.linear,
                          );

                          widget.selectedRequestTypeIndexes =
                              requestIndexes ?? widget.selectedRequestTypeIndexes;
                          print(
                              'selectedIndex:${widget.selectedRequestTypeIndexes?.toString()}');
                          await requestTypeSelected(widget.selectedRequestTypeIndexes);
                          await sendPlayersTeamRequest();
                        }
                      },
                      child: Text("Invite Players")),
                ),
              )
            : Container(
                height: 20,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: GestureDetector(onTap: () async {
                      List<int>? requestIndexes =
                          await showAnimatedDialog<dynamic>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ClassicListDialogWidget<dynamic>(
                              selectedIndexes: widget.selectedRequestTypeIndexes,
                              titleText: 'Choose User Type',
                              positiveText: "Send Request",
                              listType: ListType.multiSelect,
                              activeColor: Colors.green,
                              dataList: widget.requestUserTypes);
                        },
                        animationType: DialogTransitionType.size,
                        curve: Curves.linear,
                      );

                      widget.selectedRequestTypeIndexes =
                          requestIndexes ?? widget.selectedRequestTypeIndexes;
                      print(
                          'selectedIndex:${widget.selectedRequestTypeIndexes?.toString()}');
                      await requestTypeSelected(widget.selectedRequestTypeIndexes);
                      await sendTeamRequest();
                    },
                    child: Text("Request to Join")
                    ),

                    )),

                    getChatWidget()
      ])),
    );
  }
}
