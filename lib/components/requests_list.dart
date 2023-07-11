import 'package:flutter/material.dart';
import 'package:soccermadeeasy/commands/user_command.dart';
import 'package:soccermadeeasy/components/Cards/pickup_card2.dart';
import 'package:soccermadeeasy/constants.dart';
import 'package:soccermadeeasy/models/app_model.dart';
import '../../commands/team_command.dart';
import '../../components/profile.dart';
import '../../components/headers.dart';
import '../../components/Cards/team_request_card.dart';
import '../../components/Cards/friend_request_card.dart';
import '../../components/Cards/event_request_card.dart';
import '../../models/requests_model.dart';
import '../../commands/requests_command.dart';
import '../../graphql/queries/requests.dart';
import '../../models/requests_page_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import '../../components/Loading/loading_screen.dart';
import '../../enums/EventRequestType.dart';

class RequestsList extends StatefulWidget {
  final dynamic objectDetails;

  RequestsList({required this.objectDetails});

  @override
  _RequestsListState createState() => _RequestsListState();
}

class _RequestsListState extends State<RequestsList> {
  Svg svgImage = SVGWidgets().getSoccerBallSVGImage();

  bool _isLoading = true;
  List requests = [];


  late ScrollController _selectEventController = ScrollController();

  void goBack() {
    Navigator.pop(context);
  }

  Future<Widget> getRequestCard(
      String selectedKey, dynamic requestObject, Svg svgImage) async {
    print("getRequestCard()");
    print("selectedKey: " + selectedKey);
    print("requestObject: " + requestObject.toString());
    print("requestObject['type'].toString(): " +
        requestObject['type'].toString());    
    dynamic user = UserCommand().getAppModelUser();
    bool didSendRequest = user['_id'] == requestObject['sender']['_id'];    
    if (requestObject['type'].toString() ==
        Constants.FRIENDREQUEST.toString()) {
      Widget card = FriendRequestCard(
          friendRequestObject: requestObject, 
          svgImage: svgImage,
          didSendRequest: didSendRequest,

          );
      return card;
    } else if (requestObject['type'].toString() == Constants.GAMEREQUEST.toString() || 
        requestObject['type'].toString() == Constants.TOURNAMENTREQUEST.toString() ||
        requestObject['type'].toString() == Constants.LEAGUEREQUEST.toString() ||
        requestObject['type'].toString() == Constants.TRAININGREQUEST.toString() ||
        requestObject['type'].toString() == Constants.TRYOUTREQUEST.toString()        
        ) {
      Widget card = EventRequestCard(
          eventRequestObject: requestObject, 
          svgImage: svgImage,
          type: requestObject['type'],
          didSendRequest: didSendRequest     
      );
      return card;
    } else {
      print("elseeeeee");
      print("team: "+ requestObject['team'].toString());
      dynamic findTeamByIdResponse = await TeamCommand().findTeamById({"_id": requestObject['team']['_id']});      
      dynamic team = findTeamByIdResponse['data'];
      print("team: " + team.toString());
      dynamic teamDetails = await TeamCommand().getUserTeamDetails(team);
      print("teamDetails: " + teamDetails.toString());
      Widget card =
          TeamRequestCard(teamRequestObject: requestObject, 
          svgImage: svgImage,
          didSendRequest: didSendRequest,
          userTeamDetails: teamDetails,
          );      
      return card;
    }
  }

  Future<void> requestTypeTapped(String requestType) async {
    setState(() {
      _isLoading = true;
    });
    selectedRequestType = requestType;

    await RequestsCommand().updatedSelectedRequests(requestType);
    setState(() {
      _isLoading = false;
    });
  }

  late ScrollController _selectRequestTypeController = ScrollController();
  String selectedRequestType = "RECEIVED";
  final Color color = Colors.grey.shade200;
  final Color selectedColor = Colors.orange.shade500;

  void loadInitialData(){
    // requestTypeTapped(selectedRequestType);
    requests = widget.objectDetails['requests'];
  }

  @override
  void initState() {
    print("init state");
    super.initState();
    loadInitialData();
    
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * .4;
    final double cardHeight = MediaQuery.of(context).size.height * .1;
    final double cardImageWidth = cardWidth * .5;
    final double cardImageHeight = cardHeight * .5;
    final double bevel = 10.0;
    bool initialConditionsMet = context
        .select<RequestsPageModel, bool>((value) => value.initialConditionsMet);

    List selectedObjects = context
        .select<RequestsPageModel, List>((value) => value.selectedObjects);

    String selectedKey =
        context.select<RequestsPageModel, String>((value) => value.selectedKey);

    List requestTypes = [
      "SENT",
      "RECEIVED",
    ];

    print("selectedObjects to build:: " + selectedObjects.toString());

    return Scaffold(
        appBar: Headers().getBackHeader(context, "Requests"),
        body: Stack(children: <Widget>[
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Expanded(
                child: Column(children: <Widget>[
              // Padding(
              //     padding: EdgeInsets.all(10.0),
              //     child: SearchField(testText: testText)),
              Expanded(
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _selectRequestTypeController,
                itemCount: requestTypes.length,
                itemBuilder: (_, index) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Listener(
                        child: GestureDetector(
                      onTap: () {
                        print("onTap EventType");
                        requestTypeTapped(requestTypes[index]);
                      },
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: EdgeInsets.all(12.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0 * 1),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  requestTypes[index] == selectedRequestType
                                      ? selectedColor
                                      : color,
                                  requestTypes[index] == selectedRequestType
                                      ? selectedColor
                                      : color,
                                  requestTypes[index] == selectedRequestType
                                      ? selectedColor
                                      : color,
                                  requestTypes[index] == selectedRequestType
                                      ? selectedColor
                                      : color,
                                ],
                                stops: const [
                                  0.0,
                                  .3,
                                  .6,
                                  1.0,
                                ]),
                            boxShadow: false
                                ? null
                                : [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      offset: -Offset(10.0 / 2, 10.0 / 2),
                                      color: Colors.white,
                                    ),
                                    BoxShadow(
                                      blurRadius: bevel,
                                      offset: Offset(10.0 / 2, 10.0 / 2),
                                      color: Colors.black,
                                    )
                                  ],
                          ),
                          child: Container(
                            child: Container(
                              width: cardWidth,
                              height: cardHeight,
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Image(
                                    width: cardImageWidth,
                                    height: cardImageHeight,
                                    image: svgImage,
                                    color: Colors.white,
                                  ),
                                  const Spacer(),
                                  Text(requestTypes[index],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      )),
                                  Text(
                                    "",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    )),
                  );
                },
              )),
            ])),

            //list view
            Expanded(
              child: _isLoading == true
                  ? Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Align(
                          alignment: Alignment.center,
                          child:
                              // BottomNav()//for times when user deleted in cognito but still signed into app
                              LoadingScreen(
                                  currentDotColor: Colors.white,
                                  defaultDotColor: Colors.black,
                                  numDots: 10)))
                  : 
                  requests.length>0 ? 
                  ListView.builder(
  controller: _selectEventController,
  itemCount: requests.length,
  itemBuilder: (_, index) {
    return FutureBuilder(
      future: getRequestCard(
          selectedKey, requests[index], svgImage),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: snapshot.data,
          );
        }
      },
    );
  },
)
 :
                          Text("No Requests Yet")
                          
            ),
          ]),
        ]));
  }
}
