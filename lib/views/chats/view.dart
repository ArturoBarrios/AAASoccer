import 'package:flutter/material.dart';
import '../../components/profile.dart';
import '../../components/payment_screen.dart';
import '../../components/card_form_screen.dart';
import '../../components/Cards/chat_card.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../models/user_model.dart';
import 'package:provider/provider.dart';
import 'create.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  _ChatsViewState createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

  bool _isLoading = false;
  late ScrollController _selectEventController = ScrollController();

  void goBack() {
    Navigator.pop(context);
  }

  void _firstLoad() async {
    print("first load");
  }

  @override
  void initState() {
    print("chat/view.dart init state");
    super.initState();
    _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    List chats = context.select<UserModel, List>((value) => value.chats);

    return Scaffold(
        appBar: AppBar(
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
        ),
        body: Stack(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container( height: 200,
              child: Expanded(
                child: 
                  Container(
                    height: 100,
                    child:
                    ListView.builder(
                      controller: _selectEventController,
                      itemCount: chats.length,
                      itemBuilder: (_, index) => ChatCard(chatObject: chats[index])
                    ),

                  )
              ),
              
              ),
              //list view

              Center(
                  child: Column(children: [
               
                GestureDetector(
            onTap: () {
               showAnimatedDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return ChatCreate();
                      },
                      animationType: DialogTransitionType.slideFromBottom,
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(seconds: 1),
                    );
            },
            child: Text("Create Chat")),
                GestureDetector(
                    onTap: () {
                      goBack();
                    },
                    child: Text("Back to Home")),
              ])),
            ],
          ),
        ]));
  }
}
