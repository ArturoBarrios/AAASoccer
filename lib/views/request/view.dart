import 'package:flutter/material.dart';
import 'package:soccermadeeasy/commands/user_command.dart';
import 'package:soccermadeeasy/constants.dart';
import '../../commands/team_command.dart';
import '../../components/headers.dart';
import '../../components/Cards/team_request_card.dart';
import '../../components/Cards/friend_request_card.dart';
import '../../components/Cards/event_request_card.dart';
import '../../commands/requests_command.dart';
import '../../components/images/svg_image.dart';
import '../../models/enums/view_status.dart';
import '../../models/pageModels/requests_page_model.dart';
import 'package:provider/provider.dart';
import '../../components/Loading/loading_screen.dart';
import '../../styles/asset_constants.dart';

class RequestsView extends StatefulWidget {
  const RequestsView({Key? key}) : super(key: key);

  @override
  State<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  ViewStatus _viewStatus = ViewStatus.loading;
  String selectedRequestType = "RECEIVED";
  final Color color = Colors.grey.shade200;
  final Color selectedColor = Colors.orange.shade500;

  @override
  void initState() {
    print("init state");
    super.initState();
    loadInitialData();
  }

  void loadInitialData() {
    requestTypeTapped(selectedRequestType);
  }

  void goBack() {
    Navigator.pop(context);
  }

  Future<Widget> getRequestCard(
      String selectedKey, dynamic requestObject) async {
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
        didSendRequest: didSendRequest,
      );
      return card;
    } else if (requestObject['type'].toString() ==
            Constants.GAMEREQUEST.toString() ||
        requestObject['type'].toString() ==
            Constants.TOURNAMENTREQUEST.toString() ||
        requestObject['type'].toString() ==
            Constants.LEAGUEREQUEST.toString() ||
        requestObject['type'].toString() ==
            Constants.TRAININGREQUEST.toString() ||
        requestObject['type'].toString() ==
            Constants.TRYOUTREQUEST.toString()) {
      Widget card = EventRequestCard(
          eventRequestObject: requestObject,
          type: requestObject['type'],
          didSendRequest: didSendRequest);
      return card;
    } else {
      print("elseeeeee");
      print("team: " + requestObject['team'].toString());
      dynamic findTeamByIdResponse = await TeamCommand()
          .findTeamById({"_id": requestObject['team']['_id']});
      dynamic team = findTeamByIdResponse['data'];
      print("team: " + team.toString());
      dynamic teamDetails = await TeamCommand().getUserTeamDetails(team, false);
      print("teamDetails: " + teamDetails.toString());
      Widget card = TeamRequestCard(
        teamRequestObject: requestObject,
        didSendRequest: didSendRequest,
        userTeamDetails: teamDetails,
      );
      return card;
    }
  }

  Future<void> requestTypeTapped(String requestType) async {
    _changeStatus(ViewStatus.loading);

    selectedRequestType = requestType;

    await RequestsCommand().updatedSelectedRequests(requestType);

    _changeStatus(ViewStatus.completed);
  }

  void _changeStatus(ViewStatus status) {
    setState(() {
      _viewStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * .4;
    final double cardHeight = MediaQuery.of(context).size.height * .1;
    final double cardImageWidth = cardWidth * .5;
    final double cardImageHeight = cardHeight * .5;
    const double bevel = 10.0;
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
        appBar: const Headers().getBackHeader(context, "Requests"),
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
                itemCount: requestTypes.length,
                itemBuilder: (_, index) {
                  final defaultColor =
                      requestTypes[index] == selectedRequestType
                          ? selectedColor
                          : color;

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
                          padding: const EdgeInsets.all(12.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0 * 1),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  defaultColor,
                                  defaultColor,
                                  defaultColor,
                                  defaultColor,
                                ],
                                stops: const [
                                  0.0,
                                  .3,
                                  .6,
                                  1.0,
                                ]),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10.0,
                                offset: -const Offset(10.0 / 2, 10.0 / 2),
                                color: Colors.white,
                              ),
                              const BoxShadow(
                                blurRadius: bevel,
                                offset: Offset(10.0 / 2, 10.0 / 2),
                                color: Colors.black,
                              )
                            ],
                          ),
                          child: Container(
                            width: cardWidth,
                            height: cardHeight,
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                SvgImage(
                                  svgPath: 'lib/assets/icons/soccer_ball.svg',
                                  height: cardImageHeight,
                                  width: cardImageWidth,
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
                                const Text(
                                  "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          )),
                    )),
                  );
                },
              )),
            ])),

            //list view
            Expanded(
                child: _viewStatus == ViewStatus.loading
                    ? const SizedBox(
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
                    : selectedObjects.isNotEmpty
                        ? ListView.builder(
                            itemCount: selectedObjects.length,
                            itemBuilder: (_, index) {
                              return FutureBuilder(
                                future: getRequestCard(
                                    selectedKey, selectedObjects[index]),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  } else {
                                    return Card(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 10),
                                      child: snapshot.data,
                                    );
                                  }
                                },
                              );
                            },
                          )
                        : const Text("No Requests Yet")),
          ]),
        ]));
  }
}
