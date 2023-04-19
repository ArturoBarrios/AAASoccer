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
import '../components/Dialogues/animated_dialogue.dart';
import '../components/profile.dart';
import '../components/headers.dart';
//card widgets
import '../components/Cards/pickup_card2.dart';
import '../components/Cards/player_card.dart';
import '../components/Cards/training_card.dart';
import '../components/Cards/tryout_card.dart';
import '../components/Cards/tournament_card.dart';
import '../components/Cards/league_card.dart';
import '../components/Cards/team_card.dart';
import '../components/Cards/friend_card.dart';
import '../components/footers.dart';
import '../components/side_navs.dart';

//models
import '../models/home_page_model.dart';
import '../models/app_model.dart';
import '../models/chat_page_model.dart';
import '../enums/EventType.dart';
//views
//commands
import '../commands/home_page_command.dart';
import '../commands/tournament_command.dart';
import '../commands/event_command.dart';
import '../commands/league_command.dart';
import '../commands/team_command.dart';
import '../commands/user_command.dart';
import '../components/Buttons/seed_data_button.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../strings.dart';
import '../constants.dart';
import '../models/events_model.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  List<String> teamEventList = ["Team", "Event"];
  int selectIndex = 0;
  String eventTeamChosen = "";
  List myEventsToChooseFrom = [];
  List choices = [];
  List myTeamsToChooseFrom = [];
  List<int>? selectedEventTeamIndexes;
  List<dynamic> selectedEventTeamObjects = [];
  List<int>? selectedRequestTypeIndexes;
  List<String> selectedRequestTypeObjects = [];
  List<dynamic> userObjectSelections = [];
  List requestUserTypes = [
    Constants.PLAYER.toString(),
    Constants.ORGANIZER.toString(),
    Constants.MANAGER.toString(),
    Constants.MAINCOACH.toString(),
    Constants.ASSISTANTCOACH.toString(),
    Constants.REF.toString(),
  ];
  void setupEventTeamToChoose(int index) {
    eventTeamChosen = teamEventList[index];
    if (eventTeamChosen == "Event") {
      setupEventsToChooseFrom();
    } else {
      setupTeamsToChooseFrom();
    }
  }
 
  void setupEventsToChooseFrom() {
    print("setupEventsToChooseFrom");
    List<dynamic> myEvents = UserCommand().getAppModelMyEvents();
    myEventsToChooseFrom = myEvents;
    choices = myEventsToChooseFrom;
  }

  void setupTeamsToChooseFrom() {
    print("setupTeamsToChooseFrom");
    List<dynamic> myTeams = UserCommand().getAppModelMyTeams();
    myTeamsToChooseFrom = myTeams;
    choices = myTeamsToChooseFrom;
  }

  eventTeamsSelected(List<int>? indexes) {    
    print("eventTeamsSelected: " + indexes.toString());
    selectedEventTeamObjects = [];
    selectedEventTeamIndexes = indexes;
    for(int i = 0; i < indexes!.length; i++){
      selectedEventTeamObjects.add(choices[indexes[i]]);
    }
    print("selectedEventTeamObjects: " + selectedEventTeamObjects.toString());
  }
  requestTypesSelected(List<int>? indexes) async {
    print("requestTypesSelected: " + indexes.toString());    
    selectedRequestTypeIndexes = indexes;
    for(int i = 0; i < indexes!.length; i++){
      selectedRequestTypeObjects.add(requestUserTypes[indexes[i]]);      
    }    
  }

  Future<void> sendPlayerRequests() async{
    print("sendPlayerRequests");
    print("selectedEventTeamObjects: " + selectedEventTeamObjects.toString());
    print("selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    for(int i = 0; i<userObjectSelections.length;i++){
      if(eventTeamChosen == "Event"){
        print("send player event request");
        await EventCommand().sendPlayerEventRequests(userObjectSelections[i],selectedEventTeamObjects, selectedRequestTypeObjects);
      }
      else{
        print("send player team request");
        await TeamCommand().sendPlayerTeamRequests(userObjectSelections[i],selectedEventTeamObjects, selectedRequestTypeObjects);
      }

    }
  }




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

  //pretty sure this is obsolete now
  void _firstLoad() async {
    // setState(() {
    //   _isFirstLoadRunning = true;
    // });
    // try {
    //   final res =
    //       await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
    //   setState(() {
    //     getEventCards();
    //     // _posts = json.decode(res.body);
    //   });
    // } catch (err) {
    //   print("error");
    //   print(err);
    // }

    // setState(() {
    //   _isFirstLoadRunning = false;
    // });
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
    // print("getEventCards");
    //   HomePageModel().enabledSelections.forEach((object) {
    //     print("valueeeee: " + object.toString());
    //     //if event enabled
    //     if (object['enabled']) {
    //       events.forEach((k, eventMap) => {
    //             if (k == object['name'])
    //               {
    //                 eventMap.forEach((item) => {
    //                       eventsList.add(item),
    //                     })
    //               }
    //           });
    //     }
    //   });
    // print("event widgets length: ");
    // print(eventsList.length);
    return eventsList;
  }

  @override
  void initState() {
    print("init state");
    super.initState();
    _firstLoad();
    _selectEventController = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _selectEventController.removeListener(_loadMore);
    super.dispose();
  }

  Widget getCard(String selectedKey, dynamic selectedObject, Svg svgImage) {
    print("getCard()");
    print("selectedKey: " + selectedKey);
    print("selectedObject: " + selectedObject.toString());

    Widget card = Text(
        "null"); //PickupCard2(gameObject: selectedObject, svgImage: svgImage, isMyEvent: isMyEvent);

    if (selectedKey == Constants.PICKUP) {
      print("selected pickup: " + selectedObject.toString());
      bool isMyEvent = EventCommand().isMyEvent([selectedObject['event']]);
      card = PickupCard2(
          gameObject: selectedObject, svgImage: svgImage, isMyEvent: isMyEvent);
    } else if (selectedKey == Constants.TRAINING) {
      bool isMyEvent = EventCommand().isMyEvent([selectedObject['event']]);
      card = TrainingCard(trainingObject: selectedObject, svgImage: svgImage, isMyEvent: isMyEvent);
    } else if (selectedKey == Constants.TRYOUT) {
      print("selected tryout");
      bool isMyEvent = EventCommand().isMyEvent([selectedObject['event']]);
      card = TryoutCard(tryoutObject: selectedObject, svgImage: svgImage, isMyEvent: isMyEvent);
    } else if (selectedKey == Constants.TOURNAMENT) {
      //process tournament data for card
      TournamentCommand().currateTournamentData(selectedObject);
      
      bool isMyEvent = EventCommand().isMyEvent(selectedObject['events']['data']);
      card =
          TournamentCard(tournamentObject: selectedObject, svgImage: svgImage, isMyEvent: isMyEvent);
    } else if (selectedKey == Constants.LEAGUE) {
      //process league data for card
      LeagueCommand().currateLeagueData(selectedObject);
      bool isMyEvent = EventCommand().isMyEvent(selectedObject['events']['data']);
      card = LeagueCard(leagueObject: selectedObject, svgImage: svgImage, isMyEvent: isMyEvent);
    } else if (selectedKey == Constants.PLAYER) {
      card = PlayerCard(playerObject: selectedObject, svgImage: svgImage);
    } else if (selectedKey == Constants.TEAM) {
      bool isMyTeam = false;
      isMyTeam = TeamCommand().isMyTeam(selectedObject);
      card = TeamCard(teamObject: selectedObject, svgImage: svgImage, isMyTeam: isMyTeam);
    } else if (selectedKey == Constants.FRIEND) {
      card = FriendCard(friendObject: selectedObject, svgImage: svgImage);
    } else if (selectedKey == Constants.MYEVENTS) {
      print("testing EventType.GAME===Game.type ");
      print(EventType.GAME.name.toString() == selectedObject['type'].toString());
      if (selectedObject['event']['type'].toString() == EventType.GAME.name.toString()) {
        //get game object first
        dynamic gameObject = selectedObject['event']['games']['data'][0];
        gameObject['event'] = selectedObject['event'];
        card = PickupCard2(
            gameObject: gameObject, svgImage: svgImage, isMyEvent: true);
      }
    }

    return card;
  }

  void testFunction() {
    print("testFunction");
  }

  @override
  Widget build(BuildContext context) {
    int messagesLength =
        context.select<ChatPageModel, int>((value) => value.messagesLength);
    print("buildDDDDDD");
    bool isDialogueViewOpened = context
        .select<HomePageModel, bool>((value) => value.isDialogueViewOpened);

    String selectedKey =
        context.select<HomePageModel, String>((value) => value.selectedKey);

    List selectedObjects =
        context.select<HomePageModel, List>((value) => value.selectedObjects);
    
     userObjectSelections =
        context.select<HomePageModel, List>((value) => value.userObjectSelections);

    Map<String, dynamic> enabledSelections2 =
        context.select<HomePageModel, Map<String, dynamic>>(
            (value) => value.enabledSelections2);

    context.select<EventsModel, List<dynamic>>((value) => value.games);

    context.select<AppModel, List<dynamic>>((value) => value.myEvents);

    context.select<AppModel, List<dynamic>>((value) => value.teams);

    HomePageModel().enabledSelections2.forEach((k, v) => {
          context.select<HomePageModel, bool>(
              (value) => value.enabledSelections2[k]['enabled'])
        });

    
    

    print("selectedKey in build: " + selectedKey);

    return (Scaffold(
      appBar: Headers().getMainHeader(context),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.5, //<-- SEE HERE
        child: Drawer(child: SideNavs().getMainSideNav(context)),
      ),
      body:
          
          Stack(children: <Widget>[
        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [          
          
          Expanded(
              child: Column(children: <Widget>[
                
            // Padding(
            //     padding: EdgeInsets.all(10.0),
            //     child: SearchField(testText: testText)),
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _selectEventTypeController,
              itemCount: enabledSelections2.length,
              itemBuilder: (_, index) {
                String key = enabledSelections2.keys.elementAt(index);
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: SelectIconButton(
                      eventObject: enabledSelections2[key],
                      svgImage: svgImage,
                      index: index),
                );
              },
            )),
          ])),
          //logic/button for sending team/event requests to
          // multiple players 
          userObjectSelections.isNotEmpty ?           
          GestureDetector(
              onTap: () async{
                int? index = await showAnimatedDialog<int>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return ClassicListDialogWidget<dynamic>(
                    selectedIndex: selectIndex,
                    titleText: 'Title',
                    listType: ListType.singleSelect,
                    positiveText: "Next",                    
                    activeColor: Colors.green,
                    dataList: teamEventList);
              },
              animationType: DialogTransitionType.size,
              curve: Curves.linear,
            );
              print("index: " + index.toString());
              setupEventTeamToChoose(index!);
              if (eventTeamChosen != "") {
              List<int>? indexes = await showAnimatedDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return ClassicListDialogWidget<dynamic>(
                      selectedIndexes: selectedEventTeamIndexes,
                      titleText: 'Choose Players',
                      positiveText: "Next",
                      listType: ListType.multiSelect,
                      activeColor: Colors.green,
                      dataList: choices);
                },
                animationType: DialogTransitionType.size,
                curve: Curves.linear,
              );
              selectedEventTeamIndexes = indexes ?? selectedEventTeamIndexes;
              print('selectedIndex:${selectedEventTeamIndexes?.toString()}');
              eventTeamsSelected(selectedEventTeamIndexes);
            }
            if (selectedEventTeamIndexes!.isNotEmpty) {
              List<int>? requestIndexes = await showAnimatedDialog<dynamic>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return ClassicListDialogWidget<dynamic>(
                      selectedIndexes: selectedRequestTypeIndexes,
                      titleText: 'Choose User Type',
                      positiveText: "Send Request",
                      listType: ListType.multiSelect,
                      onNegativeClick: () {
                        print("onNegativeClick");
                        selectedEventTeamIndexes = [];
                        //pop
                        Navigator.pop(context);
                      },
                      activeColor: Colors.green,
                      dataList: requestUserTypes);
                },
                animationType: DialogTransitionType.size,
                curve: Curves.linear,
              );

              selectedRequestTypeIndexes =
                  requestIndexes ?? selectedRequestTypeIndexes;
              print('selectedIndex:${selectedRequestTypeIndexes?.toString()}');
              await requestTypesSelected(selectedRequestTypeIndexes);
              await sendPlayerRequests();
            }
              },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.blue,
              child: Center(child: Text("Send Event/Team Request")),
            
            )
          )
          : 
          Container()
          ,
          //list view
          Expanded(
            child: ListView.builder(
                controller: _selectEventController,
                itemCount: selectedObjects.length,
                itemBuilder: (_, index) => Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: getCard(
                          selectedKey, selectedObjects[index], svgImage),
                      // PickupCard2(
                      //     eventObject: selectedObjects[index],
                      //     svgImage: svgImage),
                    )),
          ),      
        ])
      ]),
      bottomNavigationBar: const Footers().getMainBottomNav(context),
    ));
  }
}
