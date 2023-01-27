import 'dart:ui';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import '../services/stripe_service.dart';


// // // // // // // // // // // // // // //
class CardFormScreen extends StatefulWidget {
  @override
  _CardFormScreen createState() => _CardFormScreen();

  
}


class _CardFormScreen
 extends State<CardFormScreen> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CardFormField(  
            controller: CardFormEditController(),
            // onCardChanged: (card) {
            //   print(card);
            // },
          ), 
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Pay'),
          )         
        ],
      ),
    );
}
}

