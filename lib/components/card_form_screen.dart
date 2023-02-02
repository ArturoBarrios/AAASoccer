import 'dart:ui';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/blocs/payment/payment_bloc.dart';
import 'package:soccermadeeasy/models/app_model.dart';
import '../services/stripe_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../enums/PaymentType.dart';
import '../models/payment_model.dart';
import '../commands/payment_commands.dart';


// // // // // // // // // // // // // // //
class CardFormScreen extends StatefulWidget {
  @override
  _CardFormScreen createState() => _CardFormScreen();
  
}

class _CardFormScreen extends State<CardFormScreen> {
void createPaymentIntent()async {
  print("createPaymentIntent");
  Map<String, dynamic> createPaymentIntentResp = await PaymentCommand().createPaymentIntent(
                           PaymentCreateIntent(
                              billingDetails: BillingDetails(
                                email: 'soccerapp357@gmail.com',
                                name: AppModel().currentUser['name'],
                                phone: AppModel().currentUser['phone'],
                              ),
                              items: [
                                {'id': 0},
                                {'id': 1}
                              ],
                            ),                        
                  );

  print("createPaymentIntentResp: " + createPaymentIntentResp.toString());
  if(createPaymentIntentResp['success']){
    //add customer
  }


}
Widget paymentWidgetToShow(PaymentType status){
  print("PaymentType status to show: "+status.name);
  CardFormEditController controller = CardFormEditController(
    initialDetails: PaymentModel().cardFieldInputDetails
  );
  if( status.name == PaymentStatus.initial.name){
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Card Formm', 
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
                        ? 
                        createPaymentIntent()
                        
                   

                        // context.read<PaymentBloc>().add(
                        //     const PaymentCreateIntent(
                        //       billingDetails: BillingDetails(
                        //         email: 'testingflutter@dev.com'
                        //       ),
                        //       items: [
                        //         {'id': 0},
                        //         {'id': 1}
                        //       ],
                        //     ),
                        //   )
                            : 
                            ScaffoldMessenger.of(context).showSnackBar(
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
          if( status == PaymentStatus.success){
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
                    // context.read<PaymentBloc>().add(PaymentStart());

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




 
  @override
  Widget build(BuildContext context) {
     
     PaymentType status = context
        .select<PaymentModel, PaymentType>((value) => value.status);
     
     CardFieldInputDetails _cardFieldInputDetails = context
        .select<PaymentModel, CardFieldInputDetails>((value) => value.cardFieldInputDetails);

    Widget child;
     return Scaffold(
      appBar: AppBar(),
      body:       
        paymentWidgetToShow(PaymentModel().status)
        // PaymentModel().status == PaymentStatus.initial?

      

      // if( state.status== PaymentStatus.initial){
      //       child = return Padding(
      //         padding: const EdgeInsets.all(20),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.stretch,
      //           children: [
      //             Text(
      //               'Card Form', 
      //               style: Theme.of(context).textTheme.headline5
      //             ),
      //             const SizedBox(height: 20),
      //             CardFormField(
      //               controller: controller,
      //             ),
      //             const SizedBox(height: 10),
      //             ElevatedButton(
      //               onPressed: () {
      //                 (controller.details.complete)
      //                   ? context.read<PaymentBloc>().add(
      //                       const PaymentCreateIntent(
      //                         billingDetails: BillingDetails(
      //                           email: 'testingflutter@dev.com'
      //                         ),
      //                         items: [
      //                           {'id': 0},
      //                           {'id': 1}
      //                         ],
      //                       ),
      //                     )
      //                       : ScaffoldMessenger.of(context).showSnackBar(
      //                         const SnackBar(
      //                           content: Text('The form is not complete.'),
      //                         ),
      //                       );                        
      //               },
      //               child: const Text('Pay')
      //             )
      //           ]
      //         )
      //       );
      //     }
      //     if(state.status == PaymentStatus.success){
      //       child = return Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           const Text('The payment is successful.'),
      //           const SizedBox(
      //             height: 10,
      //             width: double.infinity,
      //           ),
      //           ElevatedButton(
      //             onPressed: () {
      //               context.read<PaymentBloc>().add(PaymentStart());
      //             },
      //             child: const Text('Back to Home')
      //           ),
      //         ],
      //       );
            
      //     }
      //     else{
      //       child = return const Center(child: CircularProgressIndicator());

      //     }
      //      child;

        
      
    );

}

}