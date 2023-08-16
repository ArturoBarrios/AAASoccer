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
  List<dynamic> friends = [];


  bool _isLoading = false;

  void goBack(){
    Navigator.pop(context);
  }

  Widget getFriendCard( dynamic selectedObject, Svg svgImage){
    print("getCard()");    
    print("selectedObject: " + selectedObject.toString());

    Widget card = FriendCard(friendObject: selectedObject, svgImage: svgImage);

    return card;

  }

 

  late ScrollController _selectEventController = ScrollController();

   @override
  void initState() {
    print("init state");
    super.initState();    
    //avoid multiple loads??    
    
    loadInitialData();
  }

  void loadInitialData() async {
  print("loadInitialData");

  // Retrieve all friends
  friends = await UserCommand().getFriendsModel();
  print("loadInitialData");  
  
    
  // You can perform any additional data processing here
  setState(() {
    _isLoading = false;
    
  });
}

  @override
  Widget build(BuildContext context) {
    
  
    return Scaffold(
      appBar: Headers().getMainHeader(context),
      body: 
      !_isLoading ? 
      Stack(children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [  
                     //list view
                    Expanded(
                      child: ListView.builder(
                          controller: _selectEventController,
                          itemCount: friends.length,
                          itemBuilder: (_, index) => Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child:                                
                                  getFriendCard(friends[index], svgImage),                              
                                 
                                                   
                              )),
                    ),       

                  ]
              ),
      ]) : 
      Center(child: CircularProgressIndicator()),
      
    );
  }
}