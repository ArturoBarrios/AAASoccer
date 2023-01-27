import 'dart:ui';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import '../services/stripe_service.dart';


// // // // // // // // // // // // // // //
class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreen createState() => _PaymentScreen();

  
}


class _PaymentScreen extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CardField(  
            onCardChanged: (card) {
              print(card);
            },
          ),
          TextButton(
            onPressed: () async {
              print("payment button pressed");
             StripeServices().testPayment();
            },
            child: Text('pay button!'),
          )
        ],
      ),
    );
}
}

