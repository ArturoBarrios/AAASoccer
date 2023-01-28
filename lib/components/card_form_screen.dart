import 'dart:ui';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import '../services/stripe_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if( state.status== PaymentStatus.initial){
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Card Form', 
                    style: Theme.of(context).textTheme.headline5
                  ),
                  const SizedBox(height: 20),
                  CardFormField(
                    controller: CardFormEditController(),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Pay')
                  )
                ]
              )
            );
          }
          if(state.status)
          else{

          }

        }
      )
    );
}
}

