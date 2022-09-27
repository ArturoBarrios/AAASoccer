import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../commands/wager_command.dart';

class WagerCreate extends StatefulWidget {
  @override
  _WagerCreateState createState() => _WagerCreateState();
}

class _WagerCreateState extends State<WagerCreate> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final privateController = TextEditingController();
  final imagesController = TextEditingController();
  

  bool _isLoading = false;

  Future<Map<String, dynamic>> createWager() async {
    print("createGame");
    Map<String, dynamic> createEventResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {
     
      
        Map<String, dynamic> createWagerInput = {
          'name': nameController.text.trim(),
          'amount': amountController.text.trim(),
          'private':true,

          
          
        };
        Map<String, dynamic> createdWager =
            await WagerCommand().createWager(createWagerInput);

        if (createdWager['success']) {
          createEventResponse['success'] = true;
        }
      
      return createEventResponse;
    } on ApiException catch (e) {
      return createEventResponse;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Name'),
        ),
        TextField(
          controller: amountController,
          decoration: new InputDecoration.collapsed(hintText: 'Amount'),
        ),
        TextField(
          controller: privateController,
          decoration: new InputDecoration.collapsed(hintText: 'Private'),
        ),
        
        GestureDetector(
            onTap: () {
              createWager();
            },
            child: Text("tap me")),
      ])),
    );
  }
}
