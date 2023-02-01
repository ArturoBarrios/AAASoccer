import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import '../../components/profile.dart';
import '../../models/app_model.dart';

class SendPlayerRequestView extends StatefulWidget {
  const SendPlayerRequestView(
      {Key? key, required this.playerObject})
      : super(key: key);
  final Map<String, dynamic> playerObject;
  
  @override
  _SendPlayerRequestViewState createState() => _SendPlayerRequestViewState();
}

class _SendPlayerRequestViewState extends State<SendPlayerRequestView> {
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

//selection list(Team Request, Friend Invite)
  @override
  Widget build(BuildContext context) {
    print("SendPlayerRequestView build()");
    print("SendPlayerRequestView widget.playerObject: " + widget.playerObject.toString());
    List myEvents = context.select<AppModel, List>((value) => value.myEvents);
    List myTeams = context.select<AppModel, List>((value) => value.myTeams);
    List<String> selections = ["Teams", "Events"]; 
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
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Profile();
                },
              ));
            },
          ),
        ],
      ),
      body:
        Stack(children: <Widget>[
          
          
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [    
                    Text("Send Player Request"),  
                    Expanded(
                        child: Column(children: <Widget>[
                      // Padding(
                      //     padding: EdgeInsets.all(10.0),
                      //     child: SearchField(testText: testText)),
                      Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: null,
                              itemCount: selections.length,                                       
                              itemBuilder: (_, index)=>

                              Text("Select")                              

                                
                                 
                              
                                  )),
                    ])),


                    //List View              
                    Expanded(
                        child: Column(children: <Widget>[                        
                    Expanded(
                      child: ListView.builder(
                          controller: null,
                          itemCount: myEvents.length+myTeams.length,
                          itemBuilder: (_, index) => Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child:    
                                  Text("choose this: " )
                                  // PickupCard2(
                                  //     eventObject: selectedObjects[index],
                                  //     svgImage: svgImage),
                                                   
                              )),
                    ),             
                        ])),
                  ])])
    );
  }
}
