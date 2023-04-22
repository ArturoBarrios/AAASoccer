import 'dart:ui';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/blocs/payment/payment_bloc.dart';
import 'package:soccermadeeasy/models/Payment.dart';
import 'package:soccermadeeasy/models/app_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../commands/event_command.dart';
import '../enums/PaymentType.dart';
import '../models/payment_model.dart';
import '../components/Cards/payment_card.dart';
import '../components/my_painter.dart';
import '../commands/payment_commands.dart';
import '../commands/user_command.dart';
import '../views/home.dart';
import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

// // // // // // // // // // // // // // //
class CardFormScreen extends StatefulWidget {
  const CardFormScreen({Key? key, required this.priceObject, required this.roles}) : super(key: key);

  final dynamic priceObject;
  final String roles;

  @override
  _CardFormScreen createState() => _CardFormScreen();
}

class _CardFormScreen extends State<CardFormScreen> {
  bool isLoading = true;
  bool showCardForm = true;
  List paymentMethods = [];
  late ScrollController _selectPaymentController = ScrollController();
  final FlipCardController flipCardController = FlipCardController();

  void createPaymentIntent() async {
    Map<String, dynamic> currentUser = UserCommand().getAppModelUser();
    print("currentUser: " + currentUser.toString());
    print("createPaymentIntent");
    print("priceObject in CardFormScreen: " + widget.priceObject.toString());

    Map<String, dynamic> createPaymentIntentResp =
        await PaymentCommand().createPaymentIntent(
            PaymentCreateIntent(
                billingDetails: BillingDetails(
                  email: currentUser['email'],
                  name: currentUser['username'],
                  phone: currentUser['phone'],
                ),
                items: [
                  {'id': 0},
                  {'id': 1}
                ]),
            widget.priceObject);

    print("createPaymentIntentResp: " + createPaymentIntentResp.toString());
    if (createPaymentIntentResp['success'] ||
        widget.priceObject['amount'] == '0') {
      print(
          "if(createPaymentIntentResp['success'] || widget.priceObject['amount'] == '0')");
      print("now addEvent");
      //move on to next screen
      Map<String, dynamic> userInput = {
        '_id': currentUser['_id'],
      };
      print("currentUser:" + currentUser.toString());
      print("userInput: " + userInput.toString());
      print("widget.priceObject: " + widget.priceObject.toString());

      // await UserCommand().addEvent(userInput, widget.priceObject);
      EventCommand().addUserToEvent(widget.priceObject, userInput, widget.roles);
      UserCommand().updatePaymentStatus(PaymentType.success);
      print("move on to next screen");
      // Navigator.pop(context);
    }
  }

  Widget paymentWidgetToShow(PaymentType status) {
    print("PaymentType status to show: " + status.name);
    CardFormEditController controller = CardFormEditController(
        initialDetails: PaymentModel().cardFieldInputDetails);
    if (status.name == PaymentStatus.initial.name) {
      return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Card Form', style: Theme.of(context).textTheme.headline5),
                const SizedBox(height: 20),
                CardFormField(
                  controller: controller,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      (controller.details.complete)
                          ? createPaymentIntent()

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
                          : ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('The form is not complete.'),
                              ),
                            );
                    },
                    child: const Text('Pay'))
              ]));
    }
    if (status.name == PaymentStatus.success.name) {
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
              child: const Text('Go Home')),
        ],
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Future<void> getCustomerDetails() async {
    await PaymentCommand().getCustomerDetails();
  }

  Future<void> getCustomerPaymentMethods() async {
    Map<String, dynamic> getCustomerPaymentMethodsResp =
        await PaymentCommand().getCustomerPaymentMethods();
    print("getCustomerPaymentMethodsResp: " +
        getCustomerPaymentMethodsResp.toString());
    if (getCustomerPaymentMethodsResp['success']) {
      int numberOfPaymentMethods =
          getCustomerPaymentMethodsResp['paymentMethods']['data'].length;
      print("numberOfPaymentMethods: " + numberOfPaymentMethods.toString());

      setState(() {
        var timer =
            Timer(Duration(milliseconds: 500), () => print('timer done'));

        timer.cancel();
        isLoading = false;
        paymentMethods =
            getCustomerPaymentMethodsResp['paymentMethods']['data'];
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    print("card form screen initState()");
    print("widget.priceObject: " + widget.priceObject.toString());
    //get customers associated with email
    //foreach customer, get payment methods

    //todo check if customer exists, if so show credit card options.
    dynamic customerResponse = getCustomerPaymentMethods();

    print("customerResponse: " + customerResponse.toString());
    // if(customerResponse['success']){
    //allow adding new card button
    // }
  }

  void toggleShowCardForm() {
    setState(() {
      showCardForm = !showCardForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    PaymentType status =
        context.select<PaymentModel, PaymentType>((value) => value.status);

    CardFieldInputDetails _cardFieldInputDetails =
        context.select<PaymentModel, CardFieldInputDetails>(
            (value) => value.cardFieldInputDetails);

    Widget child;
    return Scaffold(
        appBar: AppBar(),
        body: !isLoading
            ? Center(
                child: Column(children: [
                Text("Payment Methods"),
                //list view
                // Expanded(
                // child:
                FlipCard(
                  fill: Fill.fillBack,
                  direction: FlipDirection.HORIZONTAL,
                  side: CardSide.FRONT,
                  front: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[800],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.credit_card,
                                color: Colors.white,
                                size: 36,
                              ),
                              Text(
                                'VISA',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            '**** **** **** 4242',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CARDHOLDER NAME',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'EXPIRES',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Arturo Barrios',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '12/24',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  back: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[800],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 32),
                          Text(
                            'SECURITY CODE',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '123',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'FLIP CARD TO SEE THE FRONT',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
// )

                  // ListView.builder(
                  //   controller: _selectPaymentController,
                  //   itemCount: 1,
                  //   itemBuilder: (_, index) =>
                  //           FlipCard(
                  //             fill: Fill.fillFront,
                  //             direction: FlipDirection.HORIZONTAL,
                  //             controller: flipCardController,
                  //             onFlip: () {
                  //               print('Flip');
                  //             },
                  //             flipOnTouch: false,
                  //             onFlipDone: (isFront) {
                  //               print('isFront: $isFront');
                  //             },
                  //             front: Padding(
                  //               padding: const EdgeInsets.symmetric(horizontal: 10),
                  //               child: buildCreditCard(
                  //               color: Colors.red,
                  //               cardNumber: "4242 4242 4242 4242",
                  //               cardHolder: "Arturo Barrios",
                  //               cardExpiration: "12/24",
                  //             ),
                  //             ),
                  //             back: Padding(
                  //               padding: const EdgeInsets.symmetric(horizontal: 10),
                  //               child:
                  //                 Card(
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: <Widget>[
                  //       const ListTile(
                  //         leading: Icon(Icons.album),
                  //         title: Text('The Enchanted Nightingale'),
                  //         subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.end,
                  //         children: <Widget>[
                  //           TextButton(
                  //             child: const Text('BUY TICKETS'),
                  //             onPressed: () {/* ... */},
                  //           ),
                  //           const SizedBox(width: 8),
                  //           TextButton(
                  //             child: const Text('LISTEN'),
                  //             onPressed: () {/* ... */},
                  //           ),
                  //           const SizedBox(width: 8),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  //             )

                  //           ),

                  // ),
                ),
                GestureDetector(
                  onTap: () {
                    print("Add New Card pressed");
                    toggleShowCardForm();
                  },
                  child: Text("Add New Card"),
                ),
                if (showCardForm) paymentWidgetToShow(status)
              ]))
            : Center(child: CircularProgressIndicator())

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
