import 'dart:ui';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/blocs/payment/payment_bloc.dart';
import 'package:soccermadeeasy/models/Payment.dart';
import 'package:soccermadeeasy/models/app_model.dart';
import '../services/stripe_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../enums/PaymentType.dart';
import '../models/payment_model.dart';
import '../commands/payment_commands.dart';
import '../commands/user_command.dart';
import '../views/home.dart';


// // // // // // // // // // // // // // //
class CardFormScreen extends StatefulWidget {
  const CardFormScreen(
    {Key? key, required this.priceObject})
    : super(key: key);

    final dynamic priceObject;      
  
    @override
    _CardFormScreen createState() => _CardFormScreen();  
}

class _CardFormScreen extends State<CardFormScreen> {
  

void createPaymentIntent() async {
  Map<String, dynamic> currentUser = UserCommand().getAppModelUser();
  print("currentUser: "+currentUser.toString());
  print("createPaymentIntent");
  print("priceObject in CardFormScreen: "+widget.priceObject.toString());    
  
  Map<String, dynamic> createPaymentIntentResp = await PaymentCommand().createPaymentIntent(
                           PaymentCreateIntent(
                              billingDetails: BillingDetails(
                                email: 'soccerapp357@gmail.com',
                                name: currentUser['name'],
                                phone: currentUser['phone'],
                              ),
                              items: [
                                {'id': 0},
                                {'id': 1}
                              ]
                            ),          
                            widget.priceObject                                     
                  );

  print("createPaymentIntentResp: " + createPaymentIntentResp.toString());
  if(createPaymentIntentResp['success'] || widget.priceObject['amount'] == '0'){
    print("if(createPaymentIntentResp['success'] || widget.priceObject['amount'] == '0')");
    print("now addEvent");
    //move on to next screen
     Map<String, dynamic> userInput = {
        '_id': currentUser['_id'],
      };
    print("currentUser:" + currentUser.toString());
    print("userInput: "+userInput.toString());
    print("widget.priceObject: "+widget.priceObject.toString());

    await UserCommand().addEvent(userInput, widget.priceObject);
    UserCommand().updatePaymentStatus(PaymentType.success);
    print("move on to next screen");
    // Navigator.pop(context);

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
          if( status.name == PaymentStatus.success.name){
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Home()),
                    // );
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('Go Home')
                ),
              ],
            );
            
          }
          else{
            return const Center(child: CircularProgressIndicator());

          }

}



Future<void> addNewCard() async {
  
}

Future<void> getCustomerDetails() async {
  await PaymentCommand().getCustomerDetails();
}

Future<void> getCustomerPaymentMethods() async {
  
  await PaymentCommand().getCustomerPaymentMethods();
}

@override
  void initState() {
    super.initState();
    print("card form screen initState()");
    print("widget.priceObject: "+widget.priceObject.toString());
    //get customers associated with email
    //foreach customer, get payment methods

    //todo check if customer exists, if so show credit card options. 
    dynamic customerResponse = getCustomerPaymentMethods();
    // print("customerResponse: "+customerResponse.toString());
    // if(customerResponse['success']){
    //   //allow adding new card button
    // }
    
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
        Center(
          child: Column(children: [
            GestureDetector(
                        onTap: () {
                          print("Add New Card pressed");
                          addNewCard();
                        },
                        child: Text("Add New Card pressed"),
                      ),
            paymentWidgetToShow(status)

            ])) 










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