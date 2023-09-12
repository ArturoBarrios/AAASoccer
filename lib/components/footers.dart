import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/views/event/create.dart';
import 'package:soccermadeeasy/views/request/view.dart';
import '../styles/asset_constants.dart';
import '../views/game/create.dart';
import '../views/images/view_images.dart';
import '../views/organization/create.dart';
import '../views/tournament/create.dart';
import '../views/league/create.dart';
import '../views/training/create.dart';
import '../views/tryout/create.dart';
import '../views/team/create/create.dart';
import '../commands/chat_command.dart';
import '../views/chats/view.dart';
import 'Dialogues/animated_dialogu.dart';
import 'images/svg_image.dart';

class Footers extends StatefulWidget {
  const Footers({Key? key}) : super(key: key);

  @override
  State<Footers> createState() => _Footers();

  BottomAppBar getMainBottomNav(BuildContext context) {
    int selectIndex = 0;
    Map<String, Widget Function(BuildContext)> pages = {
      "Pickup Game": (context) => const GameCreate(),
      "Team": (context) => const EventCreate(),
      "Tournament": (context) => const TeamCreate(),
      "League": (context) => const TournamentCreate(),
      "Training": (context) => const LeagueCreate(),
      "Tryout": (context) => const TrainingCreate(),
      "Location": (context) => const TryoutCreate(),      
    };

   void goToPage( int indexResult, List<dynamic> primaryList,) {
  print("goToPage: $indexResult");
  print("primaryList: $primaryList");
  if (pages.containsKey(primaryList[indexResult])) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: pages[primaryList[indexResult]]!,
      ),
    );
  } else {
    print("Page key not found");
  }
}
    void updateMessagesLengthTest() {
      print("updateMessagesLengthTest");
      ChatCommand().updateMessagesLengthTest();
    }

    BottomAppBar bottomAppBar = BottomAppBar(
      color: Colors.white,
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar(
                  text: "Home",
                  icon: Icons.home_outlined,
                  selected: true,
                  onPressed: () {}),
              IconBottomBar(
                  text: "images",
                  icon: Icons.image,
                  selected: false,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return const ImagesView();
                      },
                    ));
                  }),
              IconBottomBar2(
                  text: "Add",
                  icon: Icons.add_outlined,
                  selected: false,
                  onPressed: () async {
                    print("Add New Chat Pressed");
                  List<dynamic> primaryList = pages.keys.toList();
                  List<dynamic> secondaryList = [];
                  Map<int, dynamic> result = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AnimatedDialog(
                        details: {"title": "IDK"},
                        items: primaryList,
                        singleSelect: false,
                        secondaryItems: secondaryList,
                        goToFunctions: [],
                      );
                    },
                  );
                  if (result.isNotEmpty) {
                    print("result: " + result.toString());
                    goToPage(result.keys.first, primaryList);
                                                  
                  }
                    // int? index = await showAnimatedDialog<int>(
                    //   context: context,
                    //   barrierDismissible: true,
                    //   builder: (BuildContext context) {
                    //     return ClassicListDialogWidget<dynamic>(
                    //         selectedIndex: selectIndex,
                    //         titleText: 'Title',
                    //         listType: ListType.single,
                    //         onPositiveClick: () {
                    //           print("onPositiveClick: $selectIndex");
                    //           goToPage(selectIndex);
                    //         },
                    //         activeColor: Colors.green,
                    //         dataList: pages.keys.toList());
                    //   },
                    //   animationType: DialogTransitionType.size,
                    //   curve: Curves.linear,
                    // );

                    // print('selectIndex:$index');
                    // goToPage(index!);
                  }),
              IconBottomBar(
                  text: "Cart",
                  icon: Icons.chat,
                  selected: false,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return const ChatsView();
                      },
                    ));
                  }),
              IconBottomBar(
                  text: "Requests",
                  icon: Icons.notifications_active_rounded,
                  selected: false,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return RequestsView();
                      },
                    ));
                  })
            ],
          ),
        ),
      ),
    );

    return bottomAppBar;
  }

  BottomNavigationBar getChatBottomNav(BuildContext context) {
    void updateMessagesLengthTest() {
      print("updateMessagesLengthTest");
      ChatCommand().updateMessagesLengthTest();
    }

    BottomNavigationBar bottomAppBar = BottomNavigationBar(
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey.shade600,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      type: BottomNavigationBarType.fixed,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: "Chats",
        ),
        BottomNavigationBarItem(
          icon: GestureDetector(
            child: const Icon(Icons.group_work),
            onTap: () {
              print("onTap");
              updateMessagesLengthTest();
            },
          ),
          label: "Channels",
        ),
        const BottomNavigationBarItem(
            icon: SvgImage(svgPath: AssetConstants.settings), label: "Profile"),
        const BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: "Notifications"),
      ],
    );

    return bottomAppBar;
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final orangeColor = const Color(0xffFF8527);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? orangeColor : Colors.black54,
          ),
        ),
      ],
    );
  }
}

class IconBottomBar2 extends StatelessWidget {
  const IconBottomBar2(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final orangeColor = const Color(0xffFF8527);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: orangeColor,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _Footers extends State<Footers> {
  void onTapMenu() {}
  final title = "Jefferson";
  final upperTitle = "Welcome back,";

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const Padding(
          padding: EdgeInsets.only(left: 20.0),
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
