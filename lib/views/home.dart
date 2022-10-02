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
import '../components/profile.dart';
import '../components/header.dart';
//card widgets
import '../components/Cards/pickup_card.dart';
import '../components/Cards/pickup_card2.dart';
//models
import '../models/home_page_model.dart';
import '../models/app_model.dart';
//commands
import '../commands/home_page_command.dart';
import '../components/Buttons/seed_data_button.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../strings.dart';
import '../models/events_model.dart';

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
  Svg svgImage = SVGWidgets().getSoccerBallSVGImage();

  String test = "";



  Map<String, dynamic> events = {
    StringConstants.PICKUPGAMESTITLE: [
      {
        "name": "Pickup1",
        "description": "pickup at the soccer field.",
        'image': SVGWidgets().getSoccerBallSVGImage(),
      },
      {
        "name": "Pickup2",
        "description": "pickup at the soccer field.",
        'image': SVGWidgets().getSoccerBallSVGImage(),
      },
      {
        "name": "Pickup3",
        "description": "pickup at the soccer field.",
        'image': SVGWidgets().getSoccerBallSVGImage(),
      },
      {
        "name": "Pickup4",
        "description": "pickup at the soccer field.",
        'image': SVGWidgets().getSoccerBallSVGImage(),
      }
    ],
    StringConstants.TOURNAMENTSTITLE: [
      {
        "name": "Tournament1",
        "description": "Tournament at the soccer field.",
        'image': SVGWidgets().getSoccerBallSVGImage(),
      },
      {
        "name": "Tournament2",
        "description": "pickup at the soccer field.",
        'image': SVGWidgets().getSoccerBallSVGImage(),
      },
      {
        "name": "Tournament3",
        "description": "pickup at the soccer field.",
        'image': SVGWidgets().getSoccerBallSVGImage(),
      },
      {
        "name": "Tournament4",
        "description": "pickup at the soccer field.",
        'image': SVGWidgets().getSoccerBallSVGImage(),
      }
    ],
    StringConstants.LEAGUESTITLE: [],
    StringConstants.TEAMSTITLE: [],
    StringConstants.TRYOUTSTITLE: []
  };

  void cardTapped() {
    print("cardTapped");
    setState(() => {
          // HomePageModel().isDialogueViewOpened = true,
          HomePageCommand().cardTapped()
        });
  }

  // We will fetch data from this Rest api
  final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // At the beginning, we fetch the first 20 posts
  int _page = 0;
  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int _limit = 20;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List _posts = [];
  List eventsList = [];
  List eventsEnabledList = [];

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res =
          await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
      setState(() {
        getEventCards();
        // _posts = json.decode(res.body);
      });
    } catch (err) {
      print("error");
      print(err);
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // The controller for the ListView
  late ScrollController _selectEventTypeController = ScrollController();
  late ScrollController _selectEventController = ScrollController();

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _selectEventController.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        final res =
            await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            getEventCards();
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        // if (kDebugMode) {
        //   print('Something went wrong!');
        // }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  //can add filtering and sorting here
  List getEventCards() {
      HomePageModel().enabledSelections.forEach((object) {
        print("valueeeee: " + object.toString()); 
        //if event enabled
        if (object['enabled']) {
          events.forEach((k, eventMap) => {
                if (k == object['name'])
                  {
                    eventMap.forEach((item) => {
                          eventsList.add(item),
                        })
                  }
              });
        }
      });
      // print("event widgets length: ");
      // print(eventsList.length);
      return eventsList;
  }

  @override
  void initState() {
    super.initState();    
    _firstLoad();
    _selectEventController = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _selectEventController.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDialogueViewOpened = context
        .select<HomePageModel, bool>((value) => value.isDialogueViewOpened);

    List selectedObjects = context
        .select<HomePageModel, List>((value) => value.selectedObjects);
    
    List enabledSelections = context
        .select<HomePageModel, List>((value) => value.enabledSelections);
    Map<String, dynamic> enabledSelections2 = context
        .select<HomePageModel, Map<String, dynamic>>((value) => value.enabledSelections2);

    //track selection 'enabled' state
    for(var i = 0;i<HomePageModel().enabledSelections.length;i++){
      context.select<HomePageModel, bool>((value) => value.enabledSelections[i]['enabled']);
    }

    HomePageModel().enabledSelections2.forEach((k, v) => {
      context.select<HomePageModel, bool>((value) => value.enabledSelections2[k]['enabled'])
      
    });

  print("selectedObjects: " + selectedObjects.toString());
    String testText =
        context.select<HomePageModel, String>((value) => value.testText);

    //events
    List games = context.select<EventsModel, List>((value) => value.games);

    return (Scaffold(
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
      // _isFirstLoadRunning
      //     ? const Center(
      //         child: const CircularProgressIndicator(),
      //       )
      //     : 
          Stack(children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Column(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: SearchField(testText: testText)),
                      Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: _selectEventTypeController,
                              itemCount: enabledSelections2.length,                                       
                              itemBuilder: (_, index){
                                String key = enabledSelections2.keys.elementAt(index);
                                return 
                                  Card(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 10),
                                      child: SelectIconButton(
                                          eventObject: enabledSelections2[key],
                                          svgImage: svgImage,
                                          index: index),
                                );
                              },
                                  )),
                    ])),

                    //list view
                    Expanded(
                      child: ListView.builder(
                          controller: _selectEventController,
                          itemCount: selectedObjects.length,
                          itemBuilder: (_, index) => Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child: PickupCard2(
                                    eventObject: selectedObjects[index],
                                    svgImage: svgImage),
                              )),
                    ),

                    // when the _loadMore function is running
                    // if (_isLoadMoreRunning == true)
                    //   const Padding(
                    //     padding: EdgeInsets.only(top: 0, bottom: 0),
                    //     child: Center(
                    //       child: CircularProgressIndicator(),
                    //     ),
                    //   ),

                    // When nothing else to load
                    // if (_hasNextPage == false)
                    // Container(
                    //   padding: const EdgeInsets.only(top: 30, bottom: 40),
                    //   color: Colors.amber,
                    //   child: const Center(
                    //     child: Text('You have fetched all of the content'),
                    //   ),
                    // ),
                  ])
            ]),
      bottomNavigationBar: const BottomNav(),
    ));
  }
}
