import 'package:flutter/material.dart';
import 'package:soccermadeeasy/views/request/view.dart';
import '../components/profile.dart';
import '../views/chats/view.dart';
import '../views/friends/view.dart';
import '../views/home.dart';
import '../views/chats/view.dart';

class SideNavs extends StatefulWidget {
  const SideNavs({Key? key}) : super(key: key);

  @override
  State<SideNavs> createState() => _SideNavs();

  ListView getMainSideNav(BuildContext context) {
    ListView appBar = ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
        //        IconButton(
        //   icon: const Icon(Icons.account_circle),
        //   tooltip: 'Go to the next page',
        //   onPressed: () {
        //     Navigator.push(context, MaterialPageRoute<void>(
        //       builder: (BuildContext context) {
        //         return Profile();
        //       },
        //     ));
        //   },
        // ),        
               GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return Profile();
                    },
                  ));
                },
                child:
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                child: CircleAvatar(
                    backgroundImage: NetworkImage("https://gravatar.com/avatar/e6cf5837b1cd1d93ef847af222b7c42e?s=400&d=robohash&r=x"),
                    maxRadius: 5,
                  ),
              )),
              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: const Text('Home'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return Home();
                    },
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.people_sharp,
                ),
                title: const Text('Friends'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return FriendsView();
                    },
                  ));
                },
              ),
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
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Profile();
              },
            ));
          },
        ),
      ],
    );
  }
}






