import 'package:flutter/material.dart';
import '../components/profile.dart';
import '../views/chats/view.dart';
import '../views/home.dart';
import '../views/chats/create.dart';

class Headers extends StatefulWidget {
  const Headers({Key? key}) : super(key: key);

  @override
  State<Headers> createState() => _Headers();

void goHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }
  AppBar getMainHeader(BuildContext context) {
    AppBar appBar = AppBar(
    elevation: 2,
      centerTitle: false,
      title: new Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text("Find Soccer Near You")),
      backgroundColor: Colors.orange.shade500,
      actions: <Widget>[
        
      ],
    );
    return appBar;
  }

  SafeArea getChatHeader(BuildContext context) {
    return 
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back,color: Colors.black,),
                    ),
                    Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),                    
                    GestureDetector(
                        onTap: () {
                          print("Add New Chat Pressed");
                          // Navigator.push(context, MaterialPageRoute<void>(
                          //   builder: (BuildContext context) {
                          //     return ChatCreate();
                          //   },
                          // ));
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 2, bottom: 2),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.pink[50],
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                color: Colors.pink,
                                size: 20,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "Add New",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            );
          
  }

  AppBar getCreateChatDetailHeader(BuildContext context) {
    AppBar appBar = AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.black,),
                ),
                SizedBox(width: 2,),
                // CircleAvatar(
                //   backgroundImage: NetworkImage("<https://randomuser.me/api/portraits/men/5.jpg>"),
                //   maxRadius: 20,
                // ),
                SizedBox(width: 12,),
                // Expanded(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       Text("Kriss Benwat",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                //       SizedBox(height: 6,),
                //       Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                //     ],
                //   ),
                // ),
                // Icon(Icons.settings,color: Colors.black54,),
              ],
            ),
          ),
        ),
      );
    return appBar;
  }

  AppBar getChatDetailHeader(BuildContext context, dynamic chatObject) {
    AppBar appBar = AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.black,),
                ),
                IconButton(
                  onPressed: (){
                    goHome(context);
                  },
                  icon: Icon(Icons.home,color: Colors.black,),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundImage: NetworkImage("<https://randomuser.me/api/portraits/men/5.jpg>"),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[                      
                      Text(chatObject['name'],style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      SizedBox(height: 6,),
                      // Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                    ],
                  ),
                ),
                Icon(Icons.settings,color: Colors.black54,),
              ],
            ),
          ),
        ),
      );

    return appBar;
  }

  AppBar getBackHeader(BuildContext context, String title) {
  AppBar appBar = AppBar(
    elevation: 2,
    centerTitle: false,
    title: Text(title),
    backgroundColor: Colors.orange.shade500,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: <Widget>[],
  );

  return appBar;
}

}

class _Headers extends State<Headers> {
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
