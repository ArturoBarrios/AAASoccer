import 'package:flutter/material.dart';
import '../../components/profile.dart';
import '../../services/adapty_payment_service.dart';
import '../../components/payment_screen.dart';
import '../../components/card_form_screen.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class ChatView extends StatefulWidget {
  const ChatView(
    {Key? key })
    : super(key: key);    


  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

  bool _isLoading = false;



  void purchaseEvent() async{
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardFormScreen()),
    );    
    // await AdaptyPaymentService().makePurchase();
  }

  void goBack(){
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
              )
              );
            },
          ),
        ],
      ),
      body: 
      Center(
          child: Column(children: [            
        TextField(
          readOnly: true,
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Name'),
        ),
        TextField(
          readOnly: true,
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Home'),
        ),                
        IconButton(
            icon: const Icon(Icons.mark_chat_unread_rounded),
            tooltip: 'Chat',
            onPressed: () {
              showAnimatedDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return Profile();
                },
                animationType: DialogTransitionType.slideFromBottom,
                curve: Curves.fastOutSlowIn,
                duration: Duration(seconds: 1),
              );
            },
          ),
        GestureDetector(
            onTap: () {
              goBack();
            },
            child: Text("Back to Home")),
      ])),      
    );
  }
}
