import 'package:flutter/material.dart';
// import '../../components/profile.dart';
// import '../../components/payment_screen.dart';
// import '../../components/card_form_screen.dart';
// import '../../components/Cards/chat_card.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import '../../models/user_model.dart';
import 'package:provider/provider.dart';
import '../../../components/headers.dart';
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

    return Scaffold(
      appBar: Headers().getChatDetailHeader(context),
      body: Container(),
    );
  }
}
