import 'package:soccermadeeasy/components/events_list_widget.dart';
import 'package:soccermadeeasy/components/teams_list_widget.dart';
import 'package:soccermadeeasy/extensions/share_image_text.dart';
import '../commands/base_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import '../models/user_model.dart';
import 'package:flutter/material.dart';
import '../commands/images_command.dart';
import 'package:provider/provider.dart';

import 'Loading/loading_screen.dart';
import 'images_list_widget.dart';
import 'object_profile_main_image.dart';

// Change color here
const primaryColor = Color(0xff4338CA);

// // // // // // // // // // // // // // //
class Profile extends StatefulWidget {
  const Profile({Key? key, required this.profileDetails}) : super(key: key);

  final dynamic profileDetails;

  @override

  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile> {
  dynamic objectImageInput;
  dynamic currentUser;
  Map<String, dynamic> eventListDetails = {};
  Map<String, dynamic> teamListDetails = {};
  bool _isLoading = true;

  Future<void> loadInitialData() async {
    print("loadInitialData Profile");
    //get current user
    String imageUrl = "";

    if (widget.profileDetails['isMine']) {
      imageUrl = UserCommand().getProfileImage();
      currentUser = UserCommand().getAppModelUser();

      if (imageUrl == '') {
        String? key = currentUser['mainImageKey'];
        if (key != null) {
          Map<String, dynamic> getUserProfileImageResp =
              await ImagesCommand().getImage(key);
          print("getUserProfileImageResp: $getUserProfileImageResp");
          if (getUserProfileImageResp['success']) {
            imageUrl = getUserProfileImageResp['data']['signedUrl'];
            BaseCommand().userModel.profileImageUrl = imageUrl;
          }
        }
      }
    } else {
      Map<String, dynamic> findMyUserByIdResp =
          await UserCommand().findUserById(widget.profileDetails['user']);
      print("findMyUserByIdResp: $findMyUserByIdResp");
      if (findMyUserByIdResp['success']) {
        currentUser = findMyUserByIdResp['data'];
        String? key = currentUser['mainImageKey'];
        print("key: $key");
        if (key != null) {
          Map<String, dynamic> getUserProfileImageResp =
              await ImagesCommand().getImage(key);
          print("getUserProfileImageResp: $getUserProfileImageResp");
          if (getUserProfileImageResp['success']) {
            imageUrl = getUserProfileImageResp['data']['signedUrl'];
          }
        }
      }
    }

    print("loadInitialData Profile imageUrl: $imageUrl");

    objectImageInput = {
      "imageUrl": imageUrl,
      "containerType": Constants.PROFILEIMAGECIRCLE
    };    
        
    eventListDetails['eventUserParticipants'] = UserCommand().getAppModelMyEvents();


    teamListDetails['teamUserParticipants'] =
        currentUser['teamUserParticipants']['data'];
    print("eventListDetails: $eventListDetails");
    print("teamListDetails: $teamListDetails");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> onTapShare() async {
    await 'Hey theres, my name is ${widget.profileDetails['user']['username']}'
        .share(imageKey: widget.profileDetails['user']['mainImageKey']);
  }

  @override
  Widget build(BuildContext context) {
    String profileImageUrl =
        context.select<UserModel, String>((value) => value.profileImageUrl);
    return Scaffold(
      body: _isLoading
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
                        numDots: 10),
              ),
            )
          : ListView(
              physics: const ScrollPhysics(),
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
  children: [
    IconButton(
      icon: const Icon(Icons.arrow_back),
      tooltip: 'Go back',
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    Spacer(), // This will take up all available space between the elements
    IconButton(
      icon: Icon(
        Icons.share,
        color: Colors.blue,
      ),
      onPressed: onTapShare,
    ),
    IconButton(
      icon: Icon(
        Icons.settings,
        color: Colors.blue,
      ),
      onPressed: onTapShare, // You might want to use a different function here
    )
  ],
)
,
                    ObjectProfileMainImage(objectImageInput: objectImageInput),
                    const SizedBox(height: 25.0),
                    const Text(
                      'Roboh Dash',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Durham, NH',
                      style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                    ),                    
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  <Widget>[
                              Text(
                                widget.profileDetails['userDetails']['followers'].toString(),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                'Followers',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.profileDetails['userDetails']['following'].toString(),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                'Following',
                                style: TextStyle(
                                    fontFamily: 'Montserrat', color: Colors.grey),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
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
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
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
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const <Widget>[
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

                    const InfoDetailListTile(
                        name: "Excellent Perfomance",
                        value: "Top 1%",
                        tooltip: "Today",
                        date: "02/23/2019"),
                    const InfoDetailListTile(
                        name: "Amazing value!",
                        value: "😂",
                        tooltip: "Today",
                        date: "02/22/2019"),
                    const InfoDetailListTile(
                        name: "Runner-up of Voting Cup",
                        value: "#3",
                        tooltip: "Yesterday",
                        date: "02/22/2019"),
                    const InfoDetailListTile(
                        name: "Victory is super close",
                        value: "🔥",
                        tooltip: "Yesterday",
                        date: "02/22/2019"),
                    Container(
                      margin: const EdgeInsets.all(25),
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

  const InfoDetailListTile(
      {required this.name,
      required this.value,
      required this.tooltip,
      required this.date,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, top: 10.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 15.0),
              ),
              const SizedBox(height: 7.0),
              Row(
                children: <Widget>[
                  Text(
                    tooltip,
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  ),
                  const SizedBox(width: 4.0),
                  const Icon(
                    Icons.timer,
                    size: 4.0,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 4.0),
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
