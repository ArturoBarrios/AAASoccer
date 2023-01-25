import 'package:flutter/material.dart';
import 'package:soccermadeeasy/commands/home_page_command.dart';
import 'package:soccermadeeasy/models/home_page_model.dart';
import '../views/game/create.dart';
import '../views/location/create.dart';
import '../views/tryout/create.dart';
import '../views/training/create.dart';
import '../views/team/create.dart';
import '../views/wager/create.dart';
import '../views/league/create.dart';
import '../views/tournament/create.dart';
import '../views/request/view.dart';
import '../views/friends/view.dart';
import '../commands/user_command.dart';
import '../commands/base_command.dart';
import '../commands/player_command.dart';
import '../commands/tournament_command.dart';
import '../commands/game_command.dart';
import '../testing/seeding/database_seeder.service.dart';
import '../commands/geolocation_command.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
import '../components/history.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/queries/users.dart';
import '../models/home_page_model.dart';
import '../services/amplify_auth_service.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../models/home_page_model.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNav();
}

class _BottomNav extends State<BottomNav> {
  final orangeColor = const Color(0xffFF8527);
  
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  //testing methods(I know, what an amazing place to test models) :)

  void testFunction() async {
    // TournamentCommand().bergerTable(14);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LeagueCreate()),
    );
    // AmplifyAuthService().signOut();
    // Map<String, dynamic> getGamesNearLocationResp = await GameCommand().getGamesNearLocation();
    //  await DatabaseSeeder().run();
    // print("test text updated");
    // HomePageCommand().testUpdateText();

    // print(HomePageModel().testText);
    // Map<String,dynamic> userInput = {
    //   "name": "Arturo",
    //   "phone": "1234567890",
    //   "email": "email",
    //   "username": "username",
    //   "birthdate": "birthdate",

    // };
    // PlayerCommand().createPlayer(userInput, {}, false);
  }

  List<int>? selectedIndexes;

  @override
  Widget build(BuildContext context) {
    int selectIndex = 0;
    String testText = "test";
    return BottomAppBar(
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
                  text: "friends",
                  icon: Icons.person,
                  selected: false,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return FriendsView();
                      },
                    ));
                  }),
              IconBottomBar2(
                  text: "Add",
                  icon: Icons.add_outlined,
                  selected: false,                  
                  onPressed: () async {
                     testFunction();
                //     int? index = await showAnimatedDialog<int>(
                //       context: context,
                //       barrierDismissible: true,
                //       builder: (BuildContext context) {
                //         return ClassicListDialogWidget<dynamic>(
                //             selectedIndex: selectIndex,
                //             titleText: 'Title',
                //             listType: ListType.singleSelect,
                //             onPositiveClick: () {
                //               print("onPositiveClick: "+ selectIndex.toString());
                //             },
                //             activeColor: Colors.green,
                //             dataList: 
                //             // ['1', '2', '3', '4']
                //             List.generate(
                //         20,
                //         (index) {
                //           return index;
                //         },
                //       ),
                            
                //             );
                //       },
                //       animationType: DialogTransitionType.size,
                //       curve: Curves.linear,
                //     );
                    

                // print('selectIndex:$index');
                // setState(() {
                //   this.singleSelectedIndexText = '${selectIndex ?? ''}';
                // });
                  }
                  ),
              IconBottomBar(
                  text: "Cart",
                  icon: Icons.local_grocery_store_outlined,
                  selected: false,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return RequestsView();
                      },
                    ));
                  }),
              IconBottomBar(
                  text: "Friends",
                  icon: Icons.person_add_outlined,
                  selected: false,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return History();
                      },
                    ));
                  })
            ],
          ),
        ),
      ),
    );
  }
  //   double height = MediaQuery.of(context).size.height * .06;
  //   double width = MediaQuery.of(context).size.width * .06;
  //   final ButtonStyle buttonStyle = ButtonStyle(
  //     backgroundColor: MaterialStateProperty.all(Colors.green),
  //     fixedSize: MaterialStateProperty.all( Size(40, height)),
  //     shape: MaterialStateProperty.all(CircleBorder()),
  //   );
  //   return SizedBox(
  //       height: MediaQuery.of(context).size.height * .1,
  //       width: MediaQuery.of(context).size.width,
  //       child: Stack(children: <Widget>[
  //         Container(
  //           height: MediaQuery.of(context).size.height * .1,
  //           width: MediaQuery.of(context).size.width,
  //           alignment: Alignment.bottomLeft,
  //           child: BottomNavigationBar(
  //             items: const <BottomNavigationBarItem>[
  //               BottomNavigationBarItem(
  //                 icon: Icon(Icons.home),
  //                 label: 'Home',
  //               ),
  //               // BottomNavigationBarItem(
  //               //   icon: Icon(Icons.business),
  //               //   label: 'Event History',
  //               // ),
  //               BottomNavigationBarItem(
  //                 icon: Icon(Icons.school),
  //                 label: 'Wagers',
  //               ),
  //             ],
  //             currentIndex: _selectedIndex,
  //             selectedItemColor: Colors.amber[800],
  //             onTap: _onItemTapped,
  //           ),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(
  //               bottom: MediaQuery.of(context).size.height * .04),
  //           child: Align(
  //             alignment: Alignment.center,
  //             child: ElevatedButton(
  //               style: buttonStyle,
  //               onPressed: () {
  //                 testFunction();
  //                 //uncomment
  //                 // Navigator.push(
  //                 //   context,
  //                 //   MaterialPageRoute(
  //                 //       builder: (context) =>  WagerCreate()),
  //                 // );
  //               },
  //               child: Text('+'),
  //             ),
  //           ),
  //         )
  //       ]));
  // }
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
