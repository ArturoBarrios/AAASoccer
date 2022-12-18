import 'package:flutter/material.dart';
import '../../components/profile.dart';

class PickupView extends StatefulWidget {
  const PickupView(
    {Key? key, required this.isMyEvent })
    : super(key: key);

    final bool isMyEvent;


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
              ));
            },
          ),
        ],
      ),
      body: Center(
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
              goBack();
            },
            child: Text("Back to Home")),
      ])),
    );
  }
}
