import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/history.dart';
import 'package:soccermadeeasy/components/playground_widget.dart';
import 'package:soccermadeeasy/views/request/view.dart';
import '../commands/base_command.dart';
import '../commands/user_command.dart';
import '../styles/colors.dart';
import '../styles/font_sizes.dart';
import '../views/profile/profile.dart';
import '../views/chats/view.dart';
import '../views/home.dart';
import '../views/images/view_images.dart';
import '../models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../views/settings/settings_view.dart';
import '../views/subscriptions_list.dart';
import 'Buttons/basic_elevated_button.dart';

class SideNavs extends StatefulWidget {
  const SideNavs({Key? key}) : super(key: key);

  

  @override
  State<SideNavs> createState() => _SideNavs();

  void loadUserProfileData() {
    UserCommand().getAppModelUser();
  }

  ListView getMainSideNav(BuildContext context, dynamic userObject, bool isSuperUser) {
    print("userObject: " + userObject.toString());
    bool isGuest = BaseCommand().isGuest();
    String profileImageUrl =
        context.select<UserModel, String>((value) => value.profileImageUrl);
    ListView appBar = ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        GestureDetector(
          onTap: () async {
            dynamic userDetails =
                await UserCommand().getUserDetails(userObject, true);
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                dynamic profileDetails = {
                  "isMine": true,
                  "user": userObject,
                  "userDetails": userDetails
                };
                return Profile(    
                  user: userObject,              
                );
              },
            ));
          },
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.tsnBlack,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl.toString() != ''
                      ? profileImageUrl.toString()
                      : "https://gravatar.com/avatar/f33c768ea4c84ac3662a4e2646362f14?s=400&d=robohash&r=x"),
                  maxRadius: 50,
                ),
                SizedBox(height: 10),
                userObject != null && userObject['username'] != null
                    ? Text(
                        userObject['username'],
                        style: TextStyle(
                          color: AppColors.tsnWhite, // Replace with your desired color
                        ),
                      )
                    : Text("Guest",
                        style: TextStyle(
                          color: AppColors.tsnWhite, // Replace with your desired color
                        )),
              ],
            ),
          ),
        ),
        // ListTile(
        //   leading: Icon(
        //     Icons.home,
        //   ),
        //   title: const Text('Home'),
        //   onTap: () {
        //     Navigator.push(context, MaterialPageRoute<void>(
        //       builder: (BuildContext context) {
        //         return Home();
        //       },
        //     ));
        //   },
        // ),
        // ListTile(
        //   leading: Icon(
        //     Icons.people_sharp,
        //   ),
        //   title: const Text('Friends'),
        //   onTap: () {
        //     Navigator.push(context, MaterialPageRoute<void>(
        //       builder: (BuildContext context) {
        //         return FriendsView();
        //       },
        //     ));
        //   },
        // ),
        //playground
        // if (dotenv.env["ENVIRONMENT"] == "DEVELOPMENT")
        if(dotenv.env["ENVIRONMENT"] == "DEVELOPMENT")
          ListTile(
            leading: Icon(
              Icons.message_outlined,
            ),
            title: const Text('Chat'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return ChatsView();
                },
              ));
            },
          ),
        if(dotenv.env["ENVIRONMENT"] == "DEVELOPMENT")
        ListTile(
          leading: Icon(
            Icons.edit_notifications_sharp,
          ),
          title: const Text('Requests'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return RequestsView();
              },
            ));
          },
        ),
        if(dotenv.env["ENVIRONMENT"] == "DEVELOPMENT")
        ListTile(
          leading: Icon(
            Icons.image_sharp,
          ),
          title: const Text('My Images'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return ImagesView();
              },
            ));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
          ),
          title: const Text('Settings'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return SettingsView();
              },
            ));
          },
        ),
        if(dotenv.env["ENVIRONMENT"] == "DEVELOPMENT")
        ListTile(
          leading: Icon(
            Icons.settings,
          ),
          title: const Text('Subscriptions'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return SubscriptionsList();
              },
            ));
          },
        ),
        // ListTile(
        //   leading: Icon(
        //     Icons.history,
        //   ),
        //   title: const Text('History'),
        //   onTap: () {
        //     Navigator.push(context, MaterialPageRoute<void>(
        //       builder: (BuildContext context) {
        //         return History(historyDetails: []);
        //       },
        //     ));
        //   },
        // ),
        if(dotenv.env["ENVIRONMENT"] == "DEVELOPMENT")
        ListTile(
          leading: Icon(
            Icons.history,
          ),
          title: const Text('Playground'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return PlaygroundWidget();
              },
            ));
          },
        ),
    //     !isGuest && isSuperUser
    //         ? 
    //         Container(
    //             margin: EdgeInsets.fromLTRB(5,5,5,5),
    //             child: 
    //         BasicElevatedButton(
    // backgroundColor: AppColors.tsnRed,
    // text: "Sign Out",
    // fontSize: FontSizes.s(context),
    // onPressed: () async {
    //   BaseCommand().signOut(context);
    // },
  // )
  // )
            // Container(
            //     margin: EdgeInsets.all(25),
            //     color: AppColors.tsnRed,
            //     child: ElevatedButton(
                  
            //       onPressed: () {
            //         BaseCommand().signOut();
            //       },
            //       // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: AppColors.tsnRed,
                      
            //           textStyle: const TextStyle(color: AppColors.tsnRed)),
            //       child: const Text('Sign Out'),
            //     ),
            //   )
  //           : 
  //           Container(
  //               margin: EdgeInsets.all(25),
  //               child: 
  //           BasicElevatedButton(
  //   backgroundColor: AppColors.tsnGreen,
  //   text: "Sign Up",
  //   fontSize: FontSizes.s(context),
  //   onPressed: () async {
  //     BaseCommand().signOut(context);
  //   },
  // ))
            // Container(
            //   color: AppColors.tsnGreen,
            //     margin: EdgeInsets.all(25),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         BaseCommand().signOut();
            //       },
            //       // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: AppColors.tsnGreen,
                      
            //           textStyle: const TextStyle(color: AppColors.tsnRed)),
            //       child: const Text('Go to Sign Up'),
            //     ),
            //   )
      ],
    );

    return appBar;
  }
}

class _SideNavs extends State<SideNavs> {
  void onTapMenu() {}
  final title = "Jefferson";
  final upperTitle = "Welcome back,";

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            // Navigator.push(context, MaterialPageRoute<void>(
            //   builder: (BuildContext context) {
            //     return Profile();
            //   },
            // ));
          },
        ),
      ],
    );
  }
}
