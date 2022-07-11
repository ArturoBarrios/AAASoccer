import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
//amplify auth packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import '../services/amplify_auth_service.dart' as AmplifyAuth;
//import widgets
import '../components/bottom_nav.dart';
import '../components/select_icon_button.dart';
import '../components/search_field.dart';
import '../components/animated_dialogue.dart';
//card widgets
import '../components/Cards/pickup_card.dart';
//models
import '../models/home_page_model.dart';
//commands
import '../commands/home_page_command.dart';
import '../components/Buttons/seed_data_button.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();

}

class _Home extends State<Home> {
  final cardsMap = <Map>[
    {"key": 0, "opened": false},
    {"key": 1, "opened": false},
    {"key": 2, "opened": false}
  ];
  double globalPadding = 10.0;
  


  

  void cardTapped() {
    print("cardTapped");
    setState(() => {
          // HomePageModel().isDialogueViewOpened = true,        
          HomePageCommand().cardTapped()
        });
  }

 


  @override
  Widget build(BuildContext context) {
    bool isDialogueViewOpened = context.select<HomePageModel, bool>((value) => value.isDialogueViewOpened);
    return (Scaffold(
      appBar: AppBar(
        title: Text(isDialogueViewOpened.toString()),
        backgroundColor: Colors.green.shade600,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
             AmplifyAuth.AmplifyAuthService().signOut();
            },
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: const Center(
                      child: Text(
                        'This is the next page',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
      body: Stack(children: <Widget>[
          //  Container(
          //   constraints: BoxConstraints.expand(
          //       height: MediaQuery.of(context).size.height,
          //       width: MediaQuery.of(context).size.width),
          //   child: 
          //   SeedDataButton()),
        Container(constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width),
                child: AnimatedDialogue(isVisible: isDialogueViewOpened)),
        Container(
            constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width),
            child: Column(
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.all(10.0), child: SearchField()),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const <Widget>[
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: SelectIconButton()),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: SelectIconButton()),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: SelectIconButton()),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: SelectIconButton()),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: SelectIconButton()),
                      ]),
                ),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: <Widget>[
                      Row(children: const <Widget>[
                        Expanded(
                            flex: 10,
                            child:
                                //texts
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Pickup"))),
                        Expanded(
                            flex: 10,
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Text("See All"))),
                      ]),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: <Widget>[
                            InkWell(
                              onTap: () {
                                // openCardView();
                              },
                              child: GestureDetector(
                                  onTap: () {cardTapped();},
                                  child: PickupCard()),
                            ),
                            InkWell(
                                onTap: () {
                                  // openCardView();
                                },
                                child: GestureDetector(
                                  onTap: () {cardTapped();},
                                  child: PickupCard())),
                            InkWell(
                                onTap: () {
                                  // openCardView();
                                },
                                child: GestureDetector(
                                  onTap: () {cardTapped();},
                                  child: PickupCard())),
                          ])),
                          SeedDataButton()
                    ])),
                // Stack(
                //         children: [
                //           Positioned(
                //             top: 24.0,
                //           child: AnimatedDialogue()
                //           )
                //         ],
                //       )
              ],
            ))
      ]),
      bottomNavigationBar: const BottomNav(),
    ));
  }
}
