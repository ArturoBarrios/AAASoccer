import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import '../../commands/event_command.dart';
import '../../components/headers.dart';
import '../../constants.dart';

class TryoutView extends StatefulWidget {
  const TryoutView(
    { Key? key, required this.isMyEvent, required this.tryout })
    : super(key: key);

    final bool isMyEvent;
    final dynamic tryout;

  @override
  _TryoutViewState createState() => _TryoutViewState();
}

class _TryoutViewState extends State<TryoutView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();
  


  bool _isLoading = false;

  void goBack(){
    Navigator.pop(context);
  }

  List<int>? selectedRequestTypeIndexes;
  List requestUserTypes = [
    Constants.PLAYER.toString(),
    Constants.ORGANIZER.toString(),
    Constants.MANAGER.toString(),
    Constants.MAINCOACH.toString(),
    Constants.ASSISTANTCOACH.toString(),
    Constants.REF.toString(),
  ];  
  List<String> selectedRequestTypeObjects = [];

  requestTypeSelected(List<int>? indexes) {
    print("requestTypeSelected: " + indexes.toString());
    selectedRequestTypeIndexes = indexes;
    for (int i = 0; i < indexes!.length; i++) {
      selectedRequestTypeObjects.add(requestUserTypes[indexes[i]]);
    }    
  }

  Future<void> sendEventRequest() async {
    print("sendEventRequest");
    print("selectedRequestTypeObjects.length: " +
        selectedRequestTypeObjects.length.toString());    
    print(
        "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    print("send player event request");
    for(int i = 0;i<selectedRequestTypeObjects.length;i++){
      await EventCommand().sendOrganizerEventRequest(widget.tryout, selectedRequestTypeObjects[i], Constants.TRYOUTREQUEST.toString());
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headers().getBackHeader(context, "Tryout"),
      body: Center(
          child: Column(children: [
            !widget.isMyEvent ? 
            Container(
                height: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                      onTap: () async {
                        print("onTap: ");
                        List<int>? requestIndexes =
                            await showAnimatedDialog<dynamic>(
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
                        await requestTypeSelected(selectedRequestTypeIndexes);
                        await sendEventRequest();
                      },
                      child: Text("Send Request")),
                ),
              ) :
              Container(),
        
        
      ])),
    );
  }
}
