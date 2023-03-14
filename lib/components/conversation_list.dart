import 'package:flutter/material.dart';
import '../views/chats/chat/view.dart';
import '../commands/chat_command.dart';

class ConversationList extends StatefulWidget{
  ConversationList(
    {
      Key? key,
      required this.index, required this.chatObject,required this.name,required this.messageText,required this.imageUrl,required this.time,required this.isMessageRead
    }
    ) : super(key: key);
  @override
  _ConversationListState createState() => _ConversationListState();
  final int index;
  final dynamic chatObject;
  final String name;
  final String messageText;
  final String imageUrl;
  final String time;
  final bool isMessageRead;
}

class _ConversationListState extends State<ConversationList> {
  
  Future<void> setChatMessages() async{
    print("setChatMessages");
    await ChatCommand().setChatMessages(widget.chatObject, widget.index);    
  }

  void goToChat() async{
    await setChatMessages();
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return ChatView(index: widget.index,chatObject: widget.chatObject);
      },
    ));
    // Navigator.push(context, MaterialPageRoute(builder: (context){
    //    return ChatView(index: widget.index,chatObject: widget.chatObject);
    // }));
  }

  @override
  Widget build(BuildContext context) {
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
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(widget.messageText,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}