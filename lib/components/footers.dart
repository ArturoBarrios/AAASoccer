import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/views/request/view.dart';
import '../components/profile.dart';
import '../views/game/create.dart';
import '../views/tournament/create.dart';
import '../views/league/create.dart';
import '../views/training/create.dart';
import '../views/tryout/create.dart';
import '../views/team/create/create.dart';
import '../views/friends/view.dart';
import '../commands/chat_command.dart';
import '../components/history.dart';
import '../views/chats/view.dart';

class Footers extends StatefulWidget {
  const Footers({Key? key}) : super(key: key);

  @override
  State<Footers> createState() => _Footers();


BottomAppBar getMainBottomNav(BuildContext context){
  int selectIndex = 0;
  List pages = [
    "Pickup Game",
    "Team",
    "Tournament",
    "League",
    "Training", 
    "Tryout"

  ];

  void goToPage(int selectedIndex){
    //  Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => CameraApp()),
    // );
    print("goToPage: "+ selectedIndex.toString());
    switch (selectedIndex) {
      case 0:
        Navigator.push(context, MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return GameCreate();            
          },
        ));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return TeamCreate();            
          },
        ));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return TournamentCreate();
          },
        ));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return LeagueCreate();
          },
        ));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return TrainingCreate();
          },
        ));
        break;
      case 5:
        Navigator.push(context, MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return TryoutCreate();
          },
        ));
        break;      
      default:
    }
  }

  void updateMessagesLengthTest(){
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
                               
                    int? index = await showAnimatedDialog<int>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return ClassicListDialogWidget<dynamic>(
                            selectedIndex: selectIndex,
                            titleText: 'Title',
                            listType: ListType.single,
                            onPositiveClick: () {                              
                              print("onPositiveClick: "+ selectIndex.toString());
                              goToPage(selectIndex);
                            },                            
                            
                            activeColor: Colors.green,
                            dataList: 
                              pages                            
                            );
                      },
                      animationType: DialogTransitionType.size,
                      curve: Curves.linear,
                    );
                    
                print('selectIndex:$index');
                goToPage(index!);                
                  }
                  ),
              IconBottomBar(
                  text: "Cart",
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

BottomNavigationBar getChatBottomNav(BuildContext context){
  void updateMessagesLengthTest(){
    print("updateMessagesLengthTest");
    ChatCommand().updateMessagesLengthTest();

  }
  
  BottomNavigationBar bottomAppBar = BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: 
              GestureDetector(
                child: Icon(Icons.group_work),
                onTap: () {
                  print("onTap");
                  updateMessagesLengthTest();
                },
                
              ),
            label: "Channels", 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Profile"
          ),
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
  void onTapMenu(){

  }
  final title="Jefferson";
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


