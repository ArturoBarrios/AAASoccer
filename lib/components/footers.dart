import 'package:flutter/material.dart';
import '../components/profile.dart';
import '../views/chats/view.dart';
import '../views/request/view.dart';
import '../views/friends/view.dart';
import '../components/history.dart';
import '../services/amplify_auth_service.dart';

class Footers extends StatefulWidget {
  const Footers({Key? key}) : super(key: key);

  @override
  State<Footers> createState() => _Footers();


BottomAppBar getMainBottomNav(BuildContext context){
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
                  icon: Icons.history,
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


