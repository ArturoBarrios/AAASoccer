import 'dart:ui';
import 'package:soccermadeeasy/components/events_list_widget.dart';
import 'package:soccermadeeasy/components/history.dart';
import 'package:soccermadeeasy/components/teams_list_widget.dart';

import '../commands/base_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import '../models/user_model.dart';
import 'package:flutter/material.dart';
import '../commands/images_command.dart';
import 'package:provider/provider.dart';

import 'Dialogues/animated_dialogu.dart';
import 'Loading/loading_screen.dart';
import 'images_list_widget.dart';
import 'object_profile_main_image.dart';


// Change color here
const primaryColor = Color(0xff4338CA);
// // // // // // // // // // // // // // //
class Profile extends StatefulWidget {
  Profile({Key? key, required this.profileDetails})
      : super(key: key);

  final dynamic profileDetails;

  @override
  _ProfileState createState() => _ProfileState();  

  
}

class _ProfileState extends State<Profile> {    
  dynamic objectImageInput;
  dynamic currentUser;
  Map<String,dynamic> eventListDetails = {};
  Map<String,dynamic> teamListDetails = {};
  bool _isLoading = true;
  
    
    
    
  Future<void> loadInitialData() async {
    print("loadInitialData Profile");
    //get current user
    String imageUrl = "";
    
    if(widget.profileDetails['isMine']){
      imageUrl = UserCommand().getProfileImage();
      currentUser = UserCommand().getAppModelUser();
    }
    else{
      Map<String,dynamic> findMyUserByIdResp = await UserCommand().findUserById(widget.profileDetails['user']);    
      print("findMyUserByIdResp: " + findMyUserByIdResp.toString());
      if(findMyUserByIdResp['success']){
        currentUser = findMyUserByIdResp['data'];
        String key = currentUser['mainImageKey'];
        print("key: " + key);
        Map<String, dynamic> getUserProfileImageResp = await ImagesCommand().getImage(currentUser);
        if(getUserProfileImageResp['success']){
          imageUrl = getUserProfileImageResp['data'];
        }
        
      }
    }

    print("loadInitialData Profile imageUrl: " + imageUrl);
    

    objectImageInput = {
      "imageUrl": imageUrl,
      "containerType": Constants.PROFILEIMAGECIRCLE
    };
        
    print("currentUser eventUserParticipants: " + currentUser['eventUserParticipants'].toString());
    eventListDetails['eventUserParticipants'] = currentUser['eventUserParticipants']['data'];
    teamListDetails['teamUserParticipants'] = currentUser['teamUserParticipants']['data'];
    print("eventListDetails: " + eventListDetails.toString());
    print("teamListDetails: " + teamListDetails.toString());
    setState(() {
      _isLoading = false;
    });
    

    
  }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadInitialData();
  }


  @override
  Widget build(BuildContext context) {
    String profileImageUrl = context.
      select<UserModel, String>((value) => value.profileImageUrl);      
return 
 

  Scaffold(
      body:
      _isLoading ? Container(
      height: double.infinity,
      width: double.infinity,
      child: Align(
        alignment: Alignment.center,
        child:
            // BottomNav()//for times when user deleted in cognito but still signed into app
            LoadingScreen(
                currentDotColor: Colors.white,
                defaultDotColor: Colors.black,
                numDots: 10),
      ),
    ) :
      
       ListView(
        physics: ScrollPhysics(),
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              new Align(alignment: Alignment.centerLeft,
               child: 
            IconButton(icon: const Icon(Icons.arrow_back),
            tooltip: 'Go back',
            onPressed: () {
              Navigator.pop(context);             
            },
          )),                        
          ObjectProfileMainImage(objectImageInput: objectImageInput),
          SizedBox(height: 25.0),
          Text(
            'Roboh Dash',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          Text(
            'Durham, NH',
            style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '34',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Friends',
                      style: TextStyle(
                          fontFamily: 'Montserrat', color: Colors.grey),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '310',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Stars',
                      style: TextStyle(
                          fontFamily: 'Montserrat', color: Colors.grey),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '10',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Level",
                      style: TextStyle(
                          fontFamily: 'Montserrat', color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ),              
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("History")
                // IconButton(icon: Icon(Icons.table_chart),onPressed: (){},),
                // IconButton(
                //   icon: Icon(Icons.menu),
                //   onPressed: () {},
                // )
              ],
            ),
          ),

          // History(historyDetails: []),
          TeamsListWidget(userObjectDetails: teamListDetails),
          EventsListWidget(objectEventsDetails: eventListDetails),
          ImagesListWidget(details: {"for": Constants.USER}),

          InfoDetailListTile(
              name:"Excellent Perfomance", value:"Top 1%", tooltip: "Today", date: "02/23/2019"),
          InfoDetailListTile(
              name:"Amazing value!", value:"😂", tooltip:"Today", date: "02/22/2019"),
                InfoDetailListTile(
              name:"Runner-up of Voting Cup",value: "#3", tooltip: "Yesterday", date: "02/22/2019"),
              InfoDetailListTile(
              name:"Victory is super close", value:"🔥", tooltip: "Yesterday",date: "02/22/2019"),
              Container(  
                margin: EdgeInsets.all(25),  
                child: ElevatedButton(
            onPressed: () {
              BaseCommand().signOut();
            },
            // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
            style: ElevatedButton.styleFrom(
                elevation: 12.0,
                textStyle: const TextStyle(color: Colors.white)),
            child: const Text('Sign Out'),
          ),
              ),  
                   
              ],
            )
          ],
        ),
    );
  }
}

class InfoDetailListTile extends StatelessWidget {
  final String name;
   final String value;
    final String tooltip;
     final String date;

  const InfoDetailListTile({required this.name, required this.value, required this.tooltip, required this.date,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 15.0),
              ),
              SizedBox(height: 7.0),
              Row(
                children: <Widget>[
                  Text(
                    tooltip,
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  ),
                  SizedBox(width: 4.0),
                  Icon(
                    Icons.timer,
                    size: 4.0,
                    color: Colors.black,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  )
                ],
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                value,
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontFamily: 'Montserrat',
                    fontSize: 20.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}
 