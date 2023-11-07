import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/views/event/create.dart';
import 'package:soccermadeeasy/views/request/view.dart';
import '../commands/base_command.dart';
import '../models/pageModels/app_model.dart';
import '../styles/asset_constants.dart';
import '../styles/colors.dart';
import '../views/game/create.dart';
import '../views/images/view_images.dart';
import '../views/location/create.dart';
import '../views/location/map.dart';
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

  Widget getMainBottomNav(BuildContext context) {
    Map<String, Widget Function(BuildContext)> createPages =
        context.select<AppModel, Map<String, Widget Function(BuildContext)>>(
            (value) => value.createPages);

    Map<dynamic, dynamic> selectedPages =
        context.select<AppModel, Map<dynamic, dynamic>>(
            (value) => value.selectedPages);

    int selectIndex = 0;
    Map<String, Widget Function(BuildContext)> pages = {
      "Pickup Game": (context) => const GameCreate(),
      "Team": (context) => const TeamCreate(),
      "Tournament": (context) => const TournamentCreate(),
      "League": (context) => const LeagueCreate(),
      "Training": (context) => const TrainingCreate(),
      "Tryout": (context) => const TryoutCreate(),
      "Location": (context) => const LocationCreate(),
    };

    void goToPage(
      int indexResult,
      List<dynamic> primaryList,
    ) {
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

   return Stack(
  clipBehavior: Clip.none, // Allow overflowing of the FAB
  alignment: Alignment.topCenter,
  children: [
    Padding(
      padding: const EdgeInsets.only(top: 28.0), // Add padding for the top part of the FAB
      child: Container(
        width: double.infinity, // Taking full width
        height: 50,
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: AppColors.tsnBlack,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: selectedPages.entries
              .map<Widget>((MapEntry<dynamic, dynamic> entry) {
            dynamic key = entry.key;
            Map<dynamic, dynamic> item = entry.value;
            return GestureDetector(
              onTap: () {
                BaseCommand().onTapBottomNav(context, key, item);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 2.0),
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: item['enabled']
                        ? AppColors.tsnLightGreen
                        : Colors.transparent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      item['icon'],
                      size: 18,
                      color: item['enabled']
                          ? AppColors.tsnLightGreen
                          : AppColors.tsnGreyerWhite,
                    ),
                    SizedBox(height: 2),
                    Text(
                      item['name'],
                      style: TextStyle(
                        fontSize: 12,
                        color: item['enabled']
                            ? AppColors.tsnLightGreen
                            : AppColors.tsnGreyerWhite,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ),
    Positioned(
      left: 0,
      right: 0,
      bottom: 50 / 2, // Position the FAB so that it is half above the top of the nav bar
      child: FloatingActionButton(
        onPressed: () async {
          // Your floating button logic here
                print("Add New Chat Pressed");
                List<dynamic> primaryList = createPages.keys.toList();
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
                  // goToPage(result.keys.first, primaryList);
                  BaseCommand()
                      .goToCreatePage(context, result.keys.first, primaryList);
                }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue, // Assuming you want a blue FAB
      ),
    ),
  ],
);

  }

  BottomNavigationBar getChatBottomNav(BuildContext context) {
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
