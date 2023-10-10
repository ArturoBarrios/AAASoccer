import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/views/event/create.dart';
import 'package:soccermadeeasy/views/request/view.dart';
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
    Map<dynamic,dynamic>selectedPages = 
      context.select<AppModel, Map<dynamic, dynamic>>((value) => value.selectedPages);

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

  return Container(
  width: 300,
  height: 50,
  margin: const EdgeInsets.all(4.0),
  decoration: BoxDecoration(
    color: AppColors.tsnBlack,
    borderRadius: BorderRadius.circular(32), // Increased the roundness
  ),
  child: Row(
  children: selectedPages.entries.map<Widget>((MapEntry<dynamic, dynamic> entry) {
    // Now you have both the key and the value for each entry in selectedPages
    dynamic key = entry.key;
    Map<dynamic, dynamic> item = entry.value;
    print("item: " + item.toString());
    return Expanded(
      child: GestureDetector(
        onTap: () => {
          print("onTap"),
          item['selectAction'](context),
        }, // Assuming onTap is a function
        child: Container(
          margin: const EdgeInsets.all(2.0),
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: item['enabled'] ? AppColors.tsnLightGreen : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(32), // Increased the roundness
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                item['icon'],
                size: 18,
                color: item['enabled'] ? AppColors.tsnLightGreen : AppColors.tsnGreyerWhite
              ),
              SizedBox(height: 2),
              Text(
                item['name'],
                style: TextStyle(
                  fontSize: 12,
                  color: item['enabled'] ? AppColors.tsnLightGreen : AppColors.tsnGreyerWhite
                )
              ),
            ],
          ),
        ),
      ),
    );
  }).toList(),


  ),
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
