import 'package:flutter/material.dart';
import '../../../components/Loading/loading_screen.dart';
// import '../../components/profile.dart';
// import '../../components/payment_screen.dart';
// import '../../components/card_form_screen.dart';
import '../../../commands/user_command.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../../models/app_model.dart';
import 'package:provider/provider.dart';
import '../../../components/headers.dart';
import '../../../components/conversation_list.dart';
import '../../../components/bottom_text_box.dart';
// import 'create.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key, required this.chatObject}) 
    : super(key: key);
  final Map<String, dynamic> chatObject;  

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

  dynamic user = {};
  
  List<Map<String, dynamic>> chatUsers = [
    {"messageContent": "Hello, Will", "messageType": "receiver"},
    {"messageContent": "How have you been?", "messageType": "sender"},    
  ];

  bool _isLoading = true;
  late ScrollController _selectEventController = ScrollController();

  dynamic messages = [];

  void goBack() {
    Navigator.pop(context);
  }

  void _firstLoad() async {
    print("first load for chat data");
    setState(() {
      user = UserCommand().getAppModelUser();
      // print("user: $user");
      //update chat if needed(here???)
      messages = widget.chatObject['messages']['data'];//chatUsers
      _isLoading = false;      
    });
   
  }

  @override
  void initState() {
    print("chats/chat/view.dart init state");
    print("widget.chatObject: ${widget.chatObject}");
    super.initState();
    _firstLoad();
    
  }

  @override
  Widget build(BuildContext context) {    

    return Scaffold(
      appBar: Headers().getChatDetailHeader(context),
      body:
      _isLoading ? 
      Container(
            height: double.infinity,
            width: double.infinity,
            child:Align(
              alignment: Alignment.center,
              child: 
              // BottomNav()//for times when user deleted in cognito but still signed into app
              LoadingScreen(currentDotColor: Colors.white, defaultDotColor: Colors.black, numDots: 10)
            )
          ) 
          :

      Stack(
        children: <Widget>[
          ListView.builder(
  itemCount: messages.length,
  shrinkWrap: true,
  padding: EdgeInsets.only(top: 10,bottom: 10),
  physics: NeverScrollableScrollPhysics(),
  itemBuilder: (context, index){
    return 
    Container(
      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
          
          child:          
           Align(
        // alignment: (chatUsers[index]['messageType'] == "receiver"?Alignment.topLeft:Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // color: (chatUsers[index]['messageType']  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
          ),
          padding: EdgeInsets.all(16),
          child: Text(messages[index]['textObject']['content'], style: TextStyle(fontSize: 15),),
          // child: Text(chatUsers[index]['messageContent'], style: TextStyle(fontSize: 15),),
        ),
      )
      );
      

  }
          )   ,
      BottomTextBox(chatObject: widget.chatObject,),
    ]
    ),
      
      
    );
  }
}
