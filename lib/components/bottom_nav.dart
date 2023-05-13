import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/views/chats/chat/view.dart';
import '../views/request/view.dart';
import '../views/friends/view.dart';
import '../views/camera.dart';
import '../components/history.dart';
import '../services/amplify_auth_service.dart';
import '../views/chats/view.dart';

class BottomNav extends StatefulWidget {
  final Function() testFunction;
  const BottomNav({Key? key, required this.testFunction}) : super(key: key);

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

  void _onItemTapped(int index) {
    
  }
 

  void testFunction() async {
    // TournamentCommand().bergerTable(14);
  //  final prediction =  PlacesAutocomplete.show(
  //           context: context,
  //           apiKey: "AIzaSyDTdSXb1X7vFTDvwBQhcVDY6DOMiLcjQuM",
  //           mode: Mode.fullscreen, // Mode.overlay
  //           language: "en",
  //           components: [Component(Component.country, "usa")]);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => CameraApp()),
    // );
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
                    print("onPressed!");
                     
                    // int? index = await showAnimatedDialog<int>(
                    //   context: context,
                    //   barrierDismissible: true,
                    //   builder: (BuildContext context) {
                    //     return ClassicListDialogWidget<dynamic>(
                    //         selectedIndex: selectIndex,
                    //         titleText: 'Title',
                    //         listType: ListType.singleSelect,
                    //         onPositiveClick: () {
                    //           print("onPositiveClick: "+ selectIndex.toString());
                    //         },
                    //         activeColor: Colors.green,
                    //         dataList: 
                    //         ['Create Game', 'Create', '3', '4']
                            
                    //         );
                    //   },
                    //   animationType: DialogTransitionType.size,
                    //   curve: Curves.linear,
                    // );
                    


                  }
                  ),
              IconBottomBar(
                  text: "Chat",
                  icon: Icons.chat,
                  selected: false,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return ChatsView();
                      },
                    ));
                  }),
              IconBottomBar(
                  text: "Friends",
                  icon: Icons.history,
                  selected: false,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return History(historyDetails: []);
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
