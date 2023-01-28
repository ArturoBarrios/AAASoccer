import 'dart:ui';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/blocs/payment/payment_bloc.dart';
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
          CardFormEditController controller = CardFormEditController(
            initialDetails: state.cardFieldInputDetails,
          );
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
                    controller: controller,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      (controller.details.complete)
                        ? context.read<PaymentBloc>().add(
                            const PaymentCreateIntent(
                              billingDetails: BillingDetails(
                                email: 'testingflutter@dev.com'
                              ),
                              items: [
                                {'id': 0},
                                {'id': 1}
                              ],
                            ),
                          )
                            : ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('The form is not complete.'),
                              ),
                            );                        
                    },
                    child: const Text('Pay')
                  )
                ]
              )
            );
          }
          if(state.status == PaymentStatus.success){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('The payment is successful.'),
                const SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<PaymentBloc>().add(PaymentStart());
                  },
                  child: const Text('Back to Home')
                ),
              ],
            );
            
          }
          else{
            return const Center(child: CircularProgressIndicator());

          }

        }
      )
    );
}
}

