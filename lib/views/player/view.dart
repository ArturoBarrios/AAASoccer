import 'package:flutter/material.dart';
import '../../components/profile.dart';
import 'package:soccermadeeasy/constants.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../commands/user_command.dart';

class PlayerView extends StatefulWidget {
  const PlayerView(
      {Key? key, required this.userPlayerObject})
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

  List myEventsToChooseFrom = [];
    List myTeamsToChooseFrom = [];
    List choices = [];


  void setupEventsToChooseFrom() {
      print("setupEventsToChooseFrom");
      List<dynamic> myEvents = UserCommand().getAppModelMyEvents();
      myEventsToChooseFrom = myEvents;
    }

    void setupTeamsToChooseFrom() {
      print("setupTeamsToChooseFrom");
      List<dynamic> myTeams = UserCommand().getAppModelMyTeams();
      myTeamsToChooseFrom = myTeams;
    }

    void setupChoices() {
      setupEventsToChooseFrom();
      setupTeamsToChooseFrom();
      //set choices to be the list of myEventsToChooseFrom and myEventsToChooseFrom
      choices = [...myEventsToChooseFrom, ...myTeamsToChooseFrom];
      print("choices: " + choices.toString());
    }

    

    List<int>? selectedEventTeamIndexes;
    List<int>? selectedRequestTypeIndexes;
    List<dynamic> selectedEventTeamObjects = [];

    eventTeamsSelected(List<int>? indexes) {
      print("eventTeamsSelected: " + indexes.toString());
      selectedEventTeamIndexes = indexes;
    }


  bool _isLoading = false;

  void goBack(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print("PlayerView build()");
    print("PlayerView widget.playerObject: " + widget.userPlayerObject.toString());
    setupChoices();
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

            GestureDetector(
              onTap: () async {
                List<int>? indexes = await showAnimatedDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return ClassicListDialogWidget<dynamic>(
                        selectedIndexes: selectedEventTeamIndexes,
                        titleText: 'Choose Event/Team',
                        positiveText: "Next",
                        listType: ListType.multiSelect,                                                                                                    
                          // showAnimatedDialog<int>(
                          //   context: context,
                          //   barrierDismissible: true,
                          //   builder: (BuildContext context) {
                          //     return ClassicListDialogWidget<dynamic>(
                          //         selectedIndex: selectIndex,
                          //         titleText: 'Choose User Type',
                          //         positiveText: "Send Request",
                          //         listType: ListType.multiSelect,
                          //         onPositiveClick: () {
                          //           // chosenRequestType = requestUserTypes[index!];
                          //           print("Choose User Type: " + selectIndex.toString());
                          //           // sendPlayerRequest();
                          //         },
                          //         activeColor: Colors.green,
                          //         dataList: requestUserTypes);
                          //   },
                          //   animationType: DialogTransitionType.size,
                          //   curve: Curves.linear,
                          // );                          

                        
                        activeColor: Colors.green,
                        dataList: choices);
                  },
                  animationType: DialogTransitionType.size,
                  curve: Curves.linear,
                );
                selectedEventTeamIndexes = indexes ?? selectedEventTeamIndexes;
                print('selectedIndex:${selectedEventTeamIndexes?.toString()}');
                eventTeamsSelected(selectedEventTeamIndexes);

                if(selectedEventTeamIndexes!.isNotEmpty){
                  
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

                        selectedRequestTypeIndexes = requestIndexes ?? selectedRequestTypeIndexes;
                        print('selectedIndex:${selectedRequestTypeIndexes?.toString()}');
                        eventTeamsSelected(selectedRequestTypeIndexes);

                
                }
              },
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: const Icon(Icons.send)),
              ),
            ),
      ])),
    );
  }
}
