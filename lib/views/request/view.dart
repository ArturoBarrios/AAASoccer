import 'package:flutter/material.dart';
import 'package:soccermadeeasy/commands/user_command.dart';
import 'package:soccermadeeasy/components/Cards/pickup_card2.dart';
import 'package:soccermadeeasy/models/app_model.dart';
import '../../components/profile.dart';
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

class RequestsView extends StatefulWidget {
  @override
  _RequestsViewState createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  Svg svgImage = SVGWidgets().getSoccerBallSVGImage();
  


  bool _isLoading = false;
  late ScrollController _selectEventController = ScrollController();

  void goBack(){
    Navigator.pop(context);
  }

    Widget getRequestCard(String selectedKey, dynamic requestObject, Svg svgImage){
      print("getRequestCard()");
      print("selectedKey: " + selectedKey);
      print("requestObject: " + requestObject.toString());      
      // Widget card = TeamRequestCard(teamRequestObject: requestObject, svgImage: svgImage);     
      // Widget card = FriendRequestCard(friendRequestObject: requestObject, svgImage: svgImage);     
      Widget card = EventRequestCard(eventRequestObject: requestObject, svgImage: svgImage);     

    return card;
  }

  void getRequestPageData() async{
    print("getRequestPageData()");        
    // Map<String, dynamic> getEventRequestsResp = await RequestsCommand().getEventRequests();
    Map<String, dynamic> getRequestsResp = await UserCommand().getCurrentUserByEmail();
    print("getEventRequestsResp: " + getRequestsResp.toString());
    
    if (getRequestsResp['success']) {
      List friendRequests = getRequestsResp['data']['friendRequests']['data'];
      List eventRequests = getRequestsResp['data']['eventRequestsToAccept']['data'];
      List teamRequests = getRequestsResp['data']['teamRequestsToAccept']['data'];
      print("EventRequests to set: ");
      print(eventRequests);
      print("TeamRequests to set: ");
      print(teamRequests);
      print(RequestsPageModel().initialConditionsMet);
      //right now the last is visible
      //todo fix this shit
      RequestsCommand().updateTeamRequestsModel(teamRequests);
      RequestsCommand().updateFriendRequestsModel(friendRequests);
      RequestsCommand().updateEventRequestsModel(eventRequests);
      print("initialConditionsMet: ");
      print(RequestsCommand().initialConditionsMet);     
      print("initialConditionsMet after: ");
      print(RequestsPageModel().initialConditionsMet);
      print("done");
    }    

    setState(() {
      
    });
    
    

  }

  

  


  @override
  void initState() {
    print("init state");
    super.initState();    
    //avoid multiple loads??    
    
    getRequestPageData();    
  }
    

  @override
  Widget build(BuildContext context) {

    bool initialConditionsMet =
        context.select<RequestsPageModel, bool>((value) => value.initialConditionsMet);
    
    List selectedObjects = context
    .select<RequestsPageModel, List>((value) => value.selectedObjects);

    String selectedKey = context
        .select<RequestsPageModel, String>((value) => value.selectedKey);

    print("selectedObjects to build:: " + selectedObjects.toString());

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
      body: initialConditionsMet == false ? 
      Container(
            height: double.infinity,
            width: double.infinity,
            child:Align(
              alignment: Alignment.center,
              child: 
              // BottomNav()//for times when user deleted in cognito but still signed into app
              LoadingScreen(currentDotColor: Colors.white, defaultDotColor: Colors.black, numDots: 10)
            )
          ) 
          :
       Stack(children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [  
                     //list view
                    Expanded(
                      child: ListView.builder(
                          controller: _selectEventController,
                          itemCount: selectedObjects.length,
                          itemBuilder: (_, index) => Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child:
                                // Text("test") 
                                  getRequestCard(selectedKey, selectedObjects[index], svgImage),                              
                                  // PickupCard2(
                                  //     eventObject: selectedObjects[index],
                                  //     svgImage: svgImage),
                                                   
                              )),
                    ),       

                  ]
              ),
      ])

    );
  }
}
