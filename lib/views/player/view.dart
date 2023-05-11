import 'package:flutter/material.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/profile.dart';
import 'package:soccermadeeasy/constants.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../commands/user_command.dart';
import '../../commands/event_command.dart';
import '../../commands/team_command.dart';

//import singleListDialog.dart
import '../../components/singleListDialog.dart';

class PlayerView extends StatefulWidget with EventMixin {
   PlayerView({Key? key, required this.userPlayerObject})
      : super(key: key);
  final Map<String, dynamic> userPlayerObject;

  @override
  _PlayerViewState createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

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

  // List myEventsToChooseFrom = [];
  // List myTeamsToChooseFrom = [];
  // List choices = [];
  // String eventTeamChosen = "";

  void setupEventTeamToChoose(int index) {
    widget.setupEventTeamToChoose(index);
    // eventTeamChosen = teamEventList[index];
    // if (eventTeamChosen == "Event") {
    //   setupEventsToChooseFrom();
    // } else {
    //   setupTeamsToChooseFrom();
    // }
  }

  // void setupEventsToChooseFrom() {
  //   print("setupEventsToChooseFrom");
  //   List<dynamic> myEvents = UserCommand().getAppModelMyEvents();
  //   myEventsToChooseFrom = myEvents;
  //   choices = myEventsToChooseFrom;
  // }

  // void setupTeamsToChooseFrom() {
  //   print("setupTeamsToChooseFrom");
  //   List<dynamic> myTeams = UserCommand().getAppModelMyTeams();
  //   myTeamsToChooseFrom = myTeams;
  //   choices = myTeamsToChooseFrom;
  // }

  // List<String> teamEventList = ["Team", "Event"];
  // List<int>? selectedEventTeamIndexes;
  // List<int>? selectedRequestTypeIndexes;
  // List<dynamic> selectedEventTeamObjects = [];
  // List<String> selectedRequestTypeObjects = [];

  eventTeamsSelected(List<int>? indexes) {    
    widget.eventTeamsSelected(indexes);
    // print("eventTeamsSelected: " + indexes.toString());
    // selectedEventTeamObjects = [];
    // selectedEventTeamIndexes = indexes;
    // for(int i = 0; i < indexes!.length; i++){
    //   selectedEventTeamObjects.add(choices[indexes[i]]);
    // }
    // print("selectedEventTeamObjects: " + selectedEventTeamObjects.toString());
  }

  requestTypesSelected(List<int>? indexes) async {
    widget.requestTypeSelected(indexes);
    // print("requestTypesSelected: " + indexes.toString());    
    // selectedRequestTypeIndexes = indexes;
    // for(int i = 0; i < indexes!.length; i++){
    //   selectedRequestTypeObjects.add(requestUserTypes[indexes[i]]);      
    // }
    // await sendPlayerRequests();
  }


  void goBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    widget.setupEventsToChooseFrom();
    widget.setupTeamsToChooseFrom();
  }

  @override
  Widget build(BuildContext context) {
    print("PlayerView build()");
    print("PlayerView widget.playerObject: " +
        widget.userPlayerObject.toString());
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: new Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Find Soccer Near You")),
        backgroundColor: Colors.orange.shade500,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Go to the next page',
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute<void>(
              //   builder: (BuildContext context) {
              //     return Profile();
              //   },
              // ));
            },
          ),
        ],
      ),
      body: Center(
          child: Column(children: [
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Name'),
        ),
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Home'),
        ),
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Away'),
        ),
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Player'),
        ),
        TextField(
          controller: surfaceController,
          decoration: new InputDecoration.collapsed(hintText: 'Surface'),
        ),
        TextField(
          controller: fieldSizeController,
          decoration: new InputDecoration.collapsed(hintText: 'Field Size'),
        ),
        TextField(
          controller: privateController,
          decoration: new InputDecoration.collapsed(hintText: 'Private'),
        ),
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Price'),
        ),
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Location'),
        ),
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Images'),
        ),

        GestureDetector(
            onTap: () {
              goBack();
            },
            child: Text("Back to Home")),
        //choose event or team
        GestureDetector(
          onTap: () async {
            int? index = await showAnimatedDialog<int>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return ClassicListDialogWidget<dynamic>(
                    selectedIndex: widget.selectIndex,
                    titleText: 'Title',
                    listType: ListType.singleSelect,
                    positiveText: "Next",
                    // onPositiveClick: () async{
                    //   print("onPositiveClick: " );
                    //   print("selectIndex: " + index.toString());
                    //   //navigation add
                     
                    // },
                    activeColor: Colors.green,
                    dataList: widget.teamEventList);
              },
              animationType: DialogTransitionType.size,
              curve: Curves.linear,
            );
            print("index: " + index.toString());
            setupEventTeamToChoose(index!);
            if (widget.eventTeamChosen != "") {
              List<int>? indexes = await showAnimatedDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return ClassicListDialogWidget<dynamic>(
                      selectedIndexes: widget.selectedEventTeamIndexes,
                      titleText: 'Choose Event/Team',
                      positiveText: "Next",
                      listType: ListType.multiSelect,
                      activeColor: Colors.green,
                      dataList: widget.choices);
                },
                animationType: DialogTransitionType.size,
                curve: Curves.linear,
              );
              widget.selectedEventTeamIndexes = indexes ?? widget.selectedEventTeamIndexes;
              print('selectedIndex:${widget.selectedEventTeamIndexes?.toString()}');
              eventTeamsSelected(widget.selectedEventTeamIndexes);
            }
            if (widget.selectedEventTeamIndexes!.isNotEmpty) {
              List<int>? requestIndexes = await showAnimatedDialog<dynamic>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return ClassicListDialogWidget<dynamic>(
                      selectedIndexes: widget.selectedRequestTypeIndexes,
                      titleText: 'Choose User Type',
                      positiveText: "Send Request",
                      listType: ListType.multiSelect,
                      onNegativeClick: () {
                        print("onNegativeClick");
                        widget.selectedEventTeamIndexes = [];
                        //pop
                        Navigator.pop(context);
                      },
                      activeColor: Colors.green,
                      dataList: widget.requestUserTypes);
                },
                animationType: DialogTransitionType.size,
                curve: Curves.linear,
              );

              widget.selectedRequestTypeIndexes =
                  requestIndexes ?? widget.selectedRequestTypeIndexes;
              print('selectedIndex:${widget.selectedRequestTypeIndexes?.toString()}');
              requestTypesSelected(widget.selectedRequestTypeIndexes);
              widget.sendPlayerRequests(widget.userPlayerObject);
            }
          },
          child: Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: const Icon(Icons.send)),
          ),
        ),

        widget.sendPlayerTeamsRequestWidget(context, widget.userPlayerObject),
        widget.sendPlayerEventsRequestWidget(context, widget.userPlayerObject)
      ])),
    );
  }
}
