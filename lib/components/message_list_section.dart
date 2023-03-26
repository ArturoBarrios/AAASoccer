import 'package:flutter/material.dart';
// import '../../components/profile.dart';
// import '../../components/payment_screen.dart';
// import '../../components/card_form_screen.dart';
// import '../../components/Cards/chat_card.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import '../../models/user_model.dart';
import 'package:provider/provider.dart';
import '../../../components/headers.dart';
import '../../../components/bottom_text_box.dart';
// import 'create.dart';

class MessageListSection extends StatefulWidget {
  const MessageListSection({Key? key, required this.chatObject}) 
    : super(key: key);
  final Map<String, dynamic> chatObject;  

  @override
  _MessageListSectionState createState() => _MessageListSectionState();
}

class _MessageListSectionState extends State<MessageListSection> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

  bool _isLoading = false;
  late ScrollController _selectEventController = ScrollController();
  dynamic messages = [];


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
    // messages = AppModel().currentUser
  }

  @override
  Widget build(BuildContext context) {    

    return Scaffold(
     
      body: 
        Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return Container(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
                child: Text(messages[index].messageContent),
              );
            },
          ),
        ]),
        
    );
  }
}
