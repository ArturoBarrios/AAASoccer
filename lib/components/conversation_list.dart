import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/chat_page_model.dart';
import '../views/chats/chat/view.dart';
import '../commands/chat_command.dart';
import 'object_profile_main_image.dart';

class ConversationList extends StatefulWidget{
  ConversationList(
    {
      Key? key,
      required this.index, required this.chatObject
    }
  ) : super(key: key);
  @override
  _ConversationListState createState() => _ConversationListState();
  final int index;
  final dynamic chatObject;  
}

class _ConversationListState extends State<ConversationList> {
  String name = "";
  String messageText = "";
  String imageUrl = "";
  String time = "";
  bool isMessageRead = false;
  dynamic objectImageInput;

  Future<void> setChatMessages() async{
    print("setChatMessages");
    await ChatCommand().setChatMessages(widget.chatObject, widget.index);    
  }

  void goToChat() async{
    await setChatMessages();
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return ChatView(chatObject: widget.chatObject);
      },
    ));
    
  }

  loadInitialData(){
    print("loadInitialData ConversationList");
    name = widget.chatObject['name'];
    //get last message
    print("widget.chatObject['messages']['data']: "+ widget.chatObject['messages']['data'].toString());
    messageText = widget.chatObject['messages']['data'].length>0 ? 
      widget.chatObject['messages']['data'][widget.chatObject['messages']['data'].length-1]['textObject']['content']
      : "";
    print("messageText: "+ messageText);
    imageUrl = widget.chatObject['mainImageUrl'];
    time ="";    

    objectImageInput = {
      "imageUrl": imageUrl,
      "containerType": Constants.CHATIMAGECIRCLE,
      "chat": widget.chatObject
    };
  }

  @override 
  initState(){
    super.initState();
    print("ConversationList initState");
  }

  @override
  Widget build(BuildContext context) {
    List chats =
        context.select<ChatPageModel, List>((value) => value.chats);
    loadInitialData();


    return GestureDetector(      
      onTap: (){
        goToChat();
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  ObjectProfileMainImage(objectImageInput: objectImageInput),
                  // CircleAvatar(
                  //   backgroundImage: NetworkImage(""),
                  //   maxRadius: 30,
                  // ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(name, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(messageText,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: isMessageRead?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(time,style: TextStyle(fontSize: 12,fontWeight: isMessageRead?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}