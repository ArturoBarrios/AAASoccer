import 'package:flutter/material.dart';
import '../../components/profile.dart';
import '../../components/payment_screen.dart';
import '../../components/card_form_screen.dart';

class PickupView extends StatefulWidget {
  const PickupView(
    {Key? key, required this.isMyEvent, required this.game })
    : super(key: key);

    final bool isMyEvent;
    final dynamic game;


  @override
  _PickupViewState createState() => _PickupViewState();
}

class _PickupViewState extends State<PickupView> {
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
      MaterialPageRoute(builder: (context) => CardFormScreen(priceObject: widget.game['event'])),
    );    
    // await AdaptyPaymentService().makePurchase();
  }

  void goBack(){
    Navigator.pop(context);
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
          readOnly: !widget.isMyEvent,
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Name'),
        ),
        TextField(
          readOnly: !widget.isMyEvent,
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Home'),
        ),                
        GestureDetector(
            onTap: () {
              widget.game['event']['price'] == 0 ? 
              //free game
              print("hi")
              :                        
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return CardFormScreen(
                    priceObject:                   
                      widget.game['event']['price'] 
                   );
                }));
            
              
            },
            child: Text("Join Event")),
        GestureDetector(
            onTap: () {
              goBack();
            },
            child: Text("Back to Home")),
      ])),      
    );
  }
}
