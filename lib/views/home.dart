import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
//amplify auth packages

import 'package:soccermadeeasy/extensions/filter_extension.dart';
import 'package:soccermadeeasy/extensions/show_bottom_sheet.dart';
import 'package:soccermadeeasy/extensions/snackbar_dialogue.dart';
import 'package:soccermadeeasy/views/splash_screen.dart';

import '../commands/base_command.dart';
import '../commands/rating_command.dart';
import '../components/Buttons/basic_elevated_button.dart';
import '../components/Dialogues/animated_dialogu.dart';
import '../components/Dialogues/rating_dialogue.dart';
import '../components/Loading/loading_screen.dart';
import '../components/models/button_model.dart';
import '../graphql/fragments/event_fragments.dart';
import '../models/componentModels/filter_result_model.dart';

//import widgets
import '../components/select_icon_button.dart';

import '../components/headers.dart';
//card widgets
import '../components/footers.dart';
import '../components/side_navs.dart';

//models
import '../models/pageModels/home_page_model.dart';
import '../models/pageModels/app_model.dart';
import '../models/pageModels/chat_page_model.dart';
//views
//commands
import '../commands/home_page_command.dart';
import '../commands/event_command.dart';
import '../commands/team_command.dart';
import '../commands/user_command.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../strings.dart';
import '../constants.dart';
import '../models/events_model.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../components/search_field.dart';
import '../styles/colors.dart';
import '../styles/font_sizes.dart';
import 'location/map.dart';
import 'onboarding/onboarding_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  FilterResultModel? _filterResultModel;
  dynamic userObject;
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

  Future<void> setupTeamsToChooseFrom() async {
    print("setupTeamsToChooseFrom");
    List<dynamic> myTeams = await UserCommand().getAppModelMyTeams();
    myTeamsToChooseFrom = myTeams;
    choices = myTeamsToChooseFrom;
  }

  eventTeamsSelected(List<int>? indexes) {
    print("eventTeamsSelected: " + indexes.toString());
    selectedEventTeamObjects = [];
    selectedEventTeamIndexes = indexes;
    for (int i = 0; i < indexes!.length; i++) {
      selectedEventTeamObjects.add(choices[indexes[i]]);
    }
    print("selectedEventTeamObjects: " + selectedEventTeamObjects.toString());
  }

  requestTypesSelected(List<int>? indexes) async {
    print("requestTypesSelected: " + indexes.toString());
    selectedRequestTypeIndexes = indexes;
    for (int i = 0; i < indexes!.length; i++) {
      selectedRequestTypeObjects.add(requestUserTypes[indexes[i]]);
    }
  }

  Future<void> sendPlayerRequests() async {
    print("sendPlayerRequests");
    print("selectedEventTeamObjects: " + selectedEventTeamObjects.toString());
    print(
        "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    for (int i = 0; i < userObjectSelections.length; i++) {
      if (eventTeamChosen == "Event") {
        print("send player event request");
        await EventCommand().sendPlayerEventRequests(
            userObjectSelections[i],
            selectedEventTeamObjects,
            selectedRequestTypeObjects,
            "GAMEREQUEST");
      } else {
        print("send player team request");
        await TeamCommand().sendPlayerTeamRequests(userObjectSelections[i],
            selectedEventTeamObjects, selectedRequestTypeObjects);
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

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List _posts = [];
  List eventsList = [];
  List eventsEnabledList = [];

  dynamic selectedKey = "";
  List selectedObjects = [];

  // The controller for the ListView
  late ScrollController _selectEventTypeController = ScrollController();
  late ScrollController _selectEventController = ScrollController();

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
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
  void dispose() {
    _selectEventController.removeListener(_loadMore);
    super.dispose();
  }

  void testFunction() {
    print("testFunction");
  }

  void updateUpdatedCards(bool value) {
    HomePageCommand().updateUpdatedCards(value);
  }

  Future<void> loadPlayerDetails() async {
    print("loadPlayerDetails");
    // await TwilioServices().configureTwilio();

    ///////////////////////// add back in when shortcode is ready
    // print("resppp: " + resp.toString());
    // if (resp['success']) {
    await BaseCommand().setupInitialAppModels();
    BaseCommand().initialConditionsMet();

    print("initialConditionsMett");
    // } else {
    //   print("try again....");

    // }
  }

  Future<void> loadInitialData() async {
    await loadPlayerDetails();
    print("loadInitialData");
    _selectEventController = ScrollController()..addListener(_loadMore);
    userObject = UserCommand().getAppModelUser();
    print("selectedkeyyyy: ${HomePageModel().selectedKey}");
    // await HomePageCommand().eventTypeTapped(HomePageModel().selectedKey);
    await HomePageCommand().setCards();
    updateUpdatedCards(false);

    String xHoursAgoTimestamp = BaseCommand().xHoursAgoString(24);
    //check if rating dialogue should display
    dynamic allUserEventParticipantsInput = {
      "userId": userObject['_id'],
      "startTime": xHoursAgoTimestamp,
      "eventFragment": EventFragments().userEventParticipants()
    };
    // Map<String, dynamic> getAllUserEventParticipantsResp = await EventCommand()
    //     .getAllUserEventParticipants(allUserEventParticipantsInput);
    // if (getAllUserEventParticipantsResp['success']) {
    //   List<dynamic> allMyEvents = getAllUserEventParticipantsResp['data'];
    //   EventCommand().setMyEvents(allMyEvents);
    await RatingCommand().showRating(context);
    // }
  }

  void changeFilterResult(final FilterResultModel? filterResult) {
    setState(() {
      _filterResultModel = filterResult;
    });
  }

  Future<void> onFilterResult(
      {required final BuildContext context,
      final FilterResultModel? filterResult,
      final String? key,
      final List<dynamic>? objects}) async {
    Navigator.of(context).pop();

    if (filterResult?.rangeResult == null) {
      ScaffoldMessenger.of(context).show(
        type: SnackBarType.failure,
        behavior: SnackBarBehavior.floating,
        message: 'Make some filtering',
      );

      return;
    }
    HomePageCommand().changeFilteringStatus(true);
    changeFilterResult(filterResult);
    final filter = objects.filterByPriceAmount(
        selectedKey: key, rangeAmount: filterResult?.rangeResult);
    if (filter?.isNotEmpty ?? false) {
      HomePageCommand().filterObjects(filter ?? []);
    } else {
      HomePageCommand().filterObjects([]);
      ScaffoldMessenger.of(context).show(
        type: SnackBarType.failure,
        behavior: SnackBarBehavior.floating,
        message: 'No result found',
      );
    }
    await HomePageCommand().setCards();
  }

  Future<void> clearFiltering({bool isPop = true}) async {
    if (isPop) {
      Navigator.of(context).pop();
    }
    changeFilterResult(null);
    HomePageCommand().changeFilteringStatus(false);
    HomePageCommand().filterObjects([]);
    await HomePageCommand().setCards();
    setState(() {});
  }

  bool hideShowSelectionItems(Map<dynamic, dynamic> items) {
    bool value = items.values.any((item) =>
        (!item['showExplore'] || !item['showMyActivity']) && item['enabled']);
    print("hasVisibleItems: " + value.toString());
    return !value;
  }

  bool showExplore(Map<dynamic, dynamic> enabledSelections) {
    // Iterate through each key-value pair in the map
    for (var entry in enabledSelections.entries) {
      // Check if 'showExplore' is true and 'enabled' is also true
      if (entry.value["showExplore"] == true &&
          entry.value["enabled"] == true) {
        // If any entry meets the conditions, return true
        return true;
      }
    }
    // If no entries meet the conditions, return false
    return false;
  }

  bool showMyActivity(Map<dynamic, dynamic> enabledSelections) {
    // Iterate through each key-value pair in the map
    for (var entry in enabledSelections.entries) {
      // Check if 'showExplore' is true and 'enabled' is also true
      if (entry.value["showMyActivity"] == true &&
          entry.value["enabled"] == true) {
        // If any entry meets the conditions, return true
        return true;
      }
    }
    // If no entries meet the conditions, return false
    return false;
  }

  Future<void> showBottomSheet(
          BuildContext context, String key, List<dynamic> objects) async =>
      context.showFilterBottomSheet(
          filterResult: _filterResultModel,
          confirmButton: ButtonModel(
              text: 'Apply',
              onTapReturnWithValue: (final value) async => onFilterResult(
                  context: context,
                  filterResult: value as FilterResultModel,
                  key: key,
                  objects: objects)),
          cancelButton: ButtonModel(
            text: 'Cancel',
            onTap: () => Navigator.of(context).pop(),
          ),
          clearButton: ButtonModel(
            text: 'Clear',
            onTap: clearFiltering,
          ));

  @override
  void initState() {
    print("initState() in home");
    super.initState();
    loadInitialData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // showAgreementDialogues(context);
    });
  }

  Future<void> onReload() async {
    print("onReload()");
    BaseCommand().stopReloadTimer();
    await HomePageCommand().setCards();
    BaseCommand().resetReloadTimer();
  }

 


Container getDayText(int index, dynamic selectedKey) {  
  print("getDayText: " + index.toString());
    List objectsList = HomePageCommand().getHomePageObjectsList();
    print("objectsList length: " + objectsList.length.toString());  
    // print("objectsList[index]: " + objectsList[index].toString());  

    dynamic eventObject = objectsList[index];
    dynamic previousObject = index == 0 ? null : objectsList[index - 1];
    print("Constants.MYEVENTS.toString(): " + Constants.MYEVENTS.toString());
    print("selectedKey: " + selectedKey.toString());
    if (selectedKey.toString() == Constants.MYEVENTS.toString()) {
      eventObject = eventObject['event'];
      previousObject = previousObject == null ? null : previousObject['event'];
    }
    DateTime eventDate = DateTime.fromMillisecondsSinceEpoch(int.parse(eventObject['startTime']));
    DateTime today = DateTime.now();
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));

    // Check if the event is today or tomorrow
    bool isToday = eventDate.year == today.year &&
                  eventDate.month == today.month &&
                  eventDate.day == today.day;
    bool isTomorrow = eventDate.year == tomorrow.year &&
                      eventDate.month == tomorrow.month &&
                      eventDate.day == tomorrow.day;

    // For the first index or if the date is different from the previous event
    if (index == 0 || (index > 0 && (previousObject == null || !isSameDay(eventDate, previousObject['startTime'])))) {
      String dayText;
      if (isToday) {
        dayText = 'Today';
      } else if (isTomorrow) {
        dayText = 'Tomorrow';
      } else {
        dayText = DateFormat('EEEE, MMMM d').format(eventDate);
      }
      return Container(
        child: Text(dayText, style: TextStyle(fontSize: FontSizes.lg(context), 
          fontWeight: FontWeight.bold, color: AppColors.tsnDarkGrey )),
      );
    } else {
      // Return an empty Container for the same day
      return Container();
    }

  

}

bool isSameDay(DateTime currentDate, String previousDateMillis) {
  DateTime previousDate = DateTime.fromMillisecondsSinceEpoch(int.parse(previousDateMillis));
  return currentDate.year == previousDate.year &&
         currentDate.month == previousDate.month &&
         currentDate.day == previousDate.day;
}


  bool isLocationPageSelected() {
    if (AppModel().selectedPages[Constants.LOCATIONSPAGE]['enabled']) {
      return true;
    } else {
      return false;
    }
  }

  showAgreementDialogues(BuildContext context) async {
    print("nicerrrrrr");
    // if(!currentUser['hasAcceptedTermsAndConditions']){
    await BaseCommand().showAgreementDialog(context);
    // if(agreementToShow == "TermsAndConditions"){

    // }
    // else if(agreementToShow == "PrivacyPolicy"){

    // }
    // }
    // else if(!currentUser['hasAcceptedPrivacyPolicy']){

    // }
  }

  @override
  Widget build(BuildContext context) {
    print("buildDDDDDD");

    bool isSuperUser =
        context.select<AppModel, bool>((value) => value.isSuperUser);

    bool initialConditionsMet =
        context.select<AppModel, bool>((value) => value.initialConditionsMet);

    bool isDialogueViewOpened = context
        .select<HomePageModel, bool>((value) => value.isDialogueViewOpened);

    selectedKey =
        context.select<HomePageModel, dynamic>((value) => value.selectedKey);

    // List selectedObjects = context.watch<HomePageModel>().selectedObjects;
    userObjectSelections = context
        .select<HomePageModel, List>((value) => value.userObjectSelections);

    Map<dynamic, dynamic> enabledSelections2 =
        context.select<HomePageModel, Map<dynamic, dynamic>>(
            (value) => value.enabledSelections2);

    List cards = context.select<HomePageModel, List>((value) => value.cards);
    bool isFilteringEnabled = context
        .select<HomePageModel, bool>((value) => value.isFilteringEnabled);

    bool updatedCards =
        context.select<HomePageModel, bool>((value) => value.updatedCards);

    bool cardsLoading =
        context.select<HomePageModel, bool>((value) => value.cardsLoading);

    // List<dynamic> games = context.watch<EventsModel>().games;

    context.select<AppModel, List<dynamic>>((value) => value.friends);

    context.select<AppModel, List<dynamic>>((value) => value.myEvents);

    context.select<AppModel, List<dynamic>>((value) => value.teams);

    Map<String, Widget Function(BuildContext)> createPages =
        context.select<AppModel, Map<String, Widget Function(BuildContext)>>(
            (value) => value.createPages);

    Map<dynamic, dynamic> selectedPages =
        context.select<AppModel, Map<dynamic, dynamic>>(
            (value) => value.selectedPages);
    // Map<dynamic,dynamic>selectedPages =
    //   context.watch<AppModel>().selectedPages;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    print("selectedKey in build: " + selectedKey.toString());
    print("selectedObjects length in build: " +
        selectedObjects.length.toString());

    if (updatedCards) {
      print("updatedCards");
      loadInitialData();
    }

    return initialConditionsMet == false
        ? SplashScreen()
        : Scaffold(
            extendBody: true,
            appBar: Headers(
              playerStepperButton: ButtonModel(
                prefixIconData: Icons.play_circle_fill_rounded,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const OnboardingView();
                    },
                  ));
                },
              ),
              filterButton: ButtonModel(
                prefixIconData: isFilteringEnabled
                    ? Icons.filter_alt_off
                    : Icons.filter_alt,
                onTap: () => showBottomSheet(
                    context, selectedKey.toString(), selectedObjects),
              ),
            ).getMainHeader(context),
            drawer: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5, //<-- SEE HERE
              child: Drawer(
                  child: const SideNavs()
                      .getMainSideNav(context, userObject, isSuperUser)),
            ),
            body: RefreshIndicator(
              onRefresh: onReload,
              child: Stack(
                children: <Widget>[
                  Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [],
                          )),

                      SizedBox(
                        height:
                            80, // Define the height you want for your card section
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: _selectEventTypeController,
                          itemCount: enabledSelections2.length,
                          itemBuilder: (_, index) {
                            dynamic key =
                                enabledSelections2.keys.elementAt(index);
                            print("enabledSelections2[key]['showExplore']: " +
                                enabledSelections2[key]['showExplore']
                                    .toString());
                            if (showExplore(enabledSelections2) &&
                                enabledSelections2[key]['showExplore']) {
                              return SelectIconButton(
                                eventObject: enabledSelections2[key],
                                svgImage: enabledSelections2[key]['image'],
                                index: index,
                                onTapEvent: () => isFilteringEnabled
                                    ? clearFiltering(isPop: false)
                                    : null,
                              );
                            } else if (showMyActivity(enabledSelections2) &&
                                enabledSelections2[key]['showMyActivity']) {
                              return SelectIconButton(
                                eventObject: enabledSelections2[key],
                                svgImage: enabledSelections2[key]['image'],
                                index: index,
                                showNew: key == Constants.REQUESTSRECEIVED
                                    ? enabledSelections2[key]['new']
                                    : false,
                                onTapEvent: () => isFilteringEnabled
                                    ? clearFiltering(isPop: false)
                                    : null,
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      //logic/button for sending team/event requests to
                      // multiple players
                      userObjectSelections.isNotEmpty
                          ? GestureDetector(
                              onTap: () async {
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
                                          selectedIndexes:
                                              selectedEventTeamIndexes,
                                          titleText: 'Choose Players',
                                          positiveText: "Next",
                                          listType: ListType.multiSelect,
                                          activeColor: Colors.green,
                                          dataList: choices);
                                    },
                                    animationType: DialogTransitionType.size,
                                    curve: Curves.linear,
                                  );
                                  selectedEventTeamIndexes =
                                      indexes ?? selectedEventTeamIndexes;
                                  print(
                                      'selectedIndex:${selectedEventTeamIndexes?.toString()}');
                                  eventTeamsSelected(selectedEventTeamIndexes);
                                }
                                if (selectedEventTeamIndexes!.isNotEmpty) {
                                  List<int>? requestIndexes =
                                      await showAnimatedDialog<dynamic>(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return ClassicListDialogWidget<dynamic>(
                                          selectedIndexes:
                                              selectedRequestTypeIndexes,
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

                                  selectedRequestTypeIndexes = requestIndexes ??
                                      selectedRequestTypeIndexes;
                                  print(
                                      'selectedIndex:${selectedRequestTypeIndexes?.toString()}');
                                  await requestTypesSelected(
                                      selectedRequestTypeIndexes);
                                  await sendPlayerRequests();
                                }
                              },
                              child: Container(
                                width: 200,
                                height: 50,
                                color: Colors.blue,
                                child: const Center(
                                  child: Text("Send Event/Team Request"),
                                ),
                              ),
                            )
                          : Container(),

                      !cardsLoading
                          ? (
                            Container(
                              height: screenHeight * .6,
                              child: Column(children: [
                                //list view
                                Expanded(
                                    child: ListView.builder(
                                        controller: _selectEventController,
                                        itemCount: cards.length,
                                        shrinkWrap: true,
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        itemBuilder: (_, index) => 
                                       Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 16),
                                            child:
                                                Column(children: [
                                                   Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                12, 0, 0, 0),
                                            child:
                                             Align(
                                                alignment: Alignment.centerLeft,
                                                child: 
                                                getDayText(index, selectedKey)

                                                
                                                  // Text(
                                                  //   "Some Header",
                                                  //   style: TextStyle(
                                                  //       fontSize: FontSizes.lg(
                                                  //           context),
                                                  //       fontWeight:
                                                  //           FontWeight.bold),
                                                  // )
                                                  )
                                                  ),
                                                  cards[index],
                                                ])))
                                        )
                              ]))
                              )
                          : const SizedBox(
                              height: 100,
                              width: 100,
                              child: Align(
                                alignment: Alignment.center,
                                child: LoadingScreen(
                                  currentDotColor: Colors.white,
                                  defaultDotColor: Colors.black,
                                  numDots: 10,
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
            // :  LocationsMap(),

            bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(
                    top: 26.0, bottom: 16.0, left: 16.0, right: 16.0),
                child: const Footers().getMainBottomNav(context)),
          );
  }
}
