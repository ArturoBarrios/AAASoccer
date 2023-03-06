import 'package:flutter/material.dart';
import '../components/profile.dart';
import '../views/chats/view.dart';
import '../views/chats/chat/create.dart';

class SideNavs extends StatefulWidget {
  const SideNavs({Key? key}) : super(key: key);

  @override
  State<SideNavs> createState() => _SideNavs();

  ListView getProfileHead(BuildContext context) {
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
                child:
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                child: Text('Drawer Header'),
              )),
              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.message_outlined,
                ),
                title: const Text('Chat'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.edit_notifications_sharp,
                ),
                title: const Text('Requests'),
                onTap: () {
                  Navigator.pop(context);
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






