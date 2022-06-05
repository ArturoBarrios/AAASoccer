import 'package:flutter/material.dart';

//import widgets
import '../components/bottom_nav.dart';
import '../components/select_icon_button.dart';
import '../components/search_field.dart';
import '../components/animated_dialogue.dart';
//card widgets
import '../components/Cards/pickup_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final cardsMap = <Map>[
    {"key": 0, "opened": false},
    {"key": 1, "opened": false},
    {"key": 2, "opened": false}
  ];
  double globalPadding = 10.0;
  bool cardViewIsVisible = false;

  void showCardView() {
    setState(() => {
          cardViewIsVisible = true,
        });
  }

  void hideCardView() {
    setState(() => {cardViewIsVisible = false});
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.green.shade600,
      ),
      body: Stack(children: <Widget>[
        Container(constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width),
                child: AnimatedDialogue()),
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
                                showCardView();
                              },
                              child: PickupCard(),
                            ),
                            InkWell(
                                onTap: () {
                                  showCardView();
                                },
                                child: PickupCard()),
                            InkWell(
                                onTap: () {
                                  showCardView();
                                },
                                child: PickupCard()),
                          ])),
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
