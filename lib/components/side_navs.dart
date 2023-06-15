import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/history.dart';
import 'package:soccermadeeasy/components/playground_widget.dart';
import 'package:soccermadeeasy/views/request/view.dart';
import '../commands/base_command.dart';
import '../components/profile.dart';
import '../views/chats/view.dart';
import '../views/friends/view.dart';
import '../views/home.dart';
import '../views/images/view_images.dart';
import '../models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SideNavs extends StatefulWidget {
  const SideNavs({Key? key}) : super(key: key);

  @override
  State<SideNavs> createState() => _SideNavs();

  ListView getMainSideNav(BuildContext context, dynamic userObject) {
    String profileImageUrl =
        context.select<UserModel, String>((value) => value.profileImageUrl);
    ListView appBar = ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Profile();
              },
            ));
          },
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                  maxRadius: 50,
                ),
                SizedBox(height: 10),
                Text(userObject['username']),
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
        if(dotenv.env["ENVIRONMENT"]=="DEVELOPMENT")
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
        ListTile(
          leading: Icon(
            Icons.image_sharp,
          ),
          title: const Text('My Images'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return ImagesView(images: []);
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
