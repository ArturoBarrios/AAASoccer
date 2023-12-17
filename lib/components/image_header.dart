import 'dart:ui';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import '../commands/payment_commands.dart';
import '../services/stripe_service.dart';


// // // // // // // // // // // // // // //
class ImageHeader extends StatefulWidget {
  ImageHeader({Key? key, required this.dataLoaded, required objectImageInput}) : super(key: key);
  final bool dataLoaded;
  dynamic  objectImageInput;

  @override
  _ImageHeader createState() => _ImageHeader();

  
}



class _ImageHeader extends State<ImageHeader> {  

  void loadInitialData() {
   
  }

  @override
  void initState() {    
    super.initState();    
  }

  @override
  Widget build(BuildContext context) {
    return 
    Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              ),
            ),
          );
     
      
}
}

