import 'package:flutter/material.dart';
import '../../components/profile.dart';
import 'package:soccermadeeasy/commands/user_command.dart';
import 'package:soccermadeeasy/commands/player_command.dart';
import '../../components/Cards/friend_card.dart';
import 'package:provider/provider.dart';
import '../../models/app_model.dart';
import '../../models/friends_page_model.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import '../../components/headers.dart';

class FriendsView extends StatefulWidget {
  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView> {
  Svg svgImage = SVGWidgets().getSoccerBallSVGImage();
  


  bool _isLoading = false;

  void goBack(){
    Navigator.pop(context);
  }

  Widget getFriendCard(String selectedKey, dynamic selectedObject, Svg svgImage){
    print("getCard()");
    print("selectedKey: " + selectedKey);
    print("selectedObject: " + selectedObject.toString());

    Widget card = FriendCard(friendObject: selectedObject, svgImage: svgImage);

    return card;

  }

  //todo probably need to update where you're getting this data from
  void getRequestPageData() async {
    print("getRequestPageData");
    Map<String, dynamic> getCurrentUserResp = await UserCommand().getCurrentUserByEmail();
    print("getCurrentUserRespResp: " + getCurrentUserResp.toString());
    if (getCurrentUserResp['success']) {
      List friends = getCurrentUserResp['data']['friends']['data'];
      UserCommand().updateFriendsPageModel(friends);
    }
    Map<String, dynamic> getPlayersNearLocationResp = await PlayerCommand().getPlayersNearLocation();
    if(getPlayersNearLocationResp['success']){
    
                
    }

  }

  late ScrollController _selectEventController = ScrollController();

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
        context.select<FriendsPageModel, bool>((value) => value.initialConditionsMet);
    
    List selectedObjects = context
    .select<FriendsPageModel, List>((value) => value.selectedObjects);
    
    List selectedObjects2 = context
    .select<AppModel, List>((value) => value.friends);

    String selectedKey = context
        .select<FriendsPageModel, String>((value) => value.selectedKey);

    return Scaffold(
      appBar: Headers().getMainHeader(context),
      body: 
      Stack(children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [  
                     //list view
                    Expanded(
                      child: ListView.builder(
                          controller: _selectEventController,
                          itemCount: selectedObjects2.length,
                          itemBuilder: (_, index) => Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child:
                                // Text("test") 
                                  getFriendCard(selectedKey, selectedObjects2[index], svgImage),                              
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
