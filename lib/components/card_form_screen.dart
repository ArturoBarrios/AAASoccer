import 'dart:ui';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/blocs/payment/payment_bloc.dart';
import 'package:soccermadeeasy/models/Payment.dart';
import 'package:soccermadeeasy/models/app_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../commands/event_command.dart';
import '../commands/team_command.dart';
import '../constants.dart';
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
  const CardFormScreen(
      {Key? key, required this.paymentDetails, required this.callbackFunction})
      : super(key: key);

  final dynamic paymentDetails;
  final Function callbackFunction;

  @override
  _CardFormScreen createState() => _CardFormScreen();
}

class _CardFormScreen extends State<CardFormScreen> {
  bool isLoading = true;
  bool showCardForm = true;
  List paymentMethods = [];
  dynamic selectedPaymentMethod;
  late ScrollController _selectPaymentController = ScrollController();
  final FlipCardController flipCardController = FlipCardController();

  List waysToPay = [
    "Pay With Existing Card",
    "Pay With New Card",
    "PayPal",
    "Apple Card"
  ];
  String? _selectedPayment = "Pay With Existing Card";

  void createPaymentIntent() async {
    Map<String, dynamic> currentUser = UserCommand().getAppModelUser();
    print("currentUser: " + currentUser.toString());
    print("createPaymentIntent");
    print("priceObject in CardFormScreen: " +
        widget.paymentDetails['price'].toString());
    dynamic createPaymentIntentInput = {
      'price': widget.paymentDetails['price'],
      'event': widget.paymentDetails,
      'paymentCreateIntent': PaymentCreateIntent(
          billingDetails: BillingDetails(
            email: currentUser['email'],
            name: currentUser['username'],
            phone: currentUser['phone'],
          ),
          items: [
            {'id': 0},
            {'id': 1}
          ]),
    };
    if(_selectedPayment == "Pay with Existing Card"){
      createPaymentIntentInput['paymentMethod']['id'] = paymentMethods[0]['id'];
    }
    Map<String, dynamic> createPaymentIntentResp =
        await PaymentCommand().createPaymentIntent(createPaymentIntentInput);

    print("createPaymentIntentResp: " + createPaymentIntentResp.toString());
    if (createPaymentIntentResp['success'] ||
        widget.paymentDetails['price']['amount'] == '0') {
      print(
          "if(createPaymentIntentResp['success'] || widget.priceObject['amount'] == '0')");
      print("now addEvent");
      if (widget.paymentDetails['objectType'] == Constants.EVENT) {
        dynamic addEventResp = await EventCommand().addUserToEvent(
            widget.paymentDetails['objectToPurchase'],
            currentUser,
            widget.paymentDetails['roles']);
        print("addEventResp: " + addEventResp.toString());
      } else if (widget.paymentDetails['objectType'] == Constants.TEAM) {
        dynamic addEventResp = await TeamCommand().addUserToTeam(
            widget.paymentDetails['objectToPurchase'],
            currentUser,
            widget.paymentDetails['roles']);
        print("addEventResp: " + addEventResp.toString());
      }
      //move on to next screen

      print("move on to next screen");

      //go back
      // Navigator.pop(context);
      widget.callbackFunction();
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
      int numberOfPaymentMethods = getCustomerPaymentMethodsResp['data'].length;
      print("numberOfPaymentMethods: " + numberOfPaymentMethods.toString());
      if (numberOfPaymentMethods > 0) {
        _selectedPayment = getCustomerPaymentMethodsResp['data'][0]['id'];
        _selectedPayment = "Pay With Existing Card";
      } else {
        _selectedPayment = "Pay With New Card";
      }
      setState(() {
        var timer =
            Timer(Duration(milliseconds: 500), () => print('timer done'));

        timer.cancel();
        isLoading = false;
        paymentMethods = getCustomerPaymentMethodsResp['data'];
        print("paymentMethods: " + paymentMethods.toString());
      });
    } else {
      _selectedPayment = "Pay With New Card";
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadInitialData() async {
    //get customers associated with email
    //foreach customer, get payment methods
    //todo check if customer exists, if so show credit card options.
    await getCustomerPaymentMethods();
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    print("card form screen initState()");

    loadInitialData();
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
                Padding(
                  padding: EdgeInsets.only(
                      top: 16.0,
                      left: 16.0,
                      right: 16.0), // Define your own padding
                  child: Container(
                    height: 50, // Adjust this to make your cards slim
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: waysToPay.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: waysToPay[index],
                                groupValue: _selectedPayment,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPayment = value;
                                  });
                                },
                              ),
                              Text(
                                waysToPay[index],
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                _selectedPayment == waysToPay[0]
                    ? Column(
                        children: [
                          Container(
                            height:200,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: paymentMethods.length,
                                itemBuilder: (_, index) => Padding(
                                    padding: EdgeInsets.only(
                                        top: 16.0,
                                        left: 16.0,
                                        right:
                                            16.0), // Define your own padding
                                    child: FlipCard(
                                      fill: Fill.fillBack,
                                      direction: FlipDirection.HORIZONTAL,
                                      side: CardSide.FRONT,
                                      front: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[800],
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.credit_card,
                                                    color: Colors.white,
                                                    size: 36,
                                                  ),
                                                  Text(
                                                    paymentMethods[index]['card']['brand'],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 16),
                                              Text(
                                                '**** **** **** '+paymentMethods[index]['card']['last4'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 28,
                                                ),
                                              ),
                                              SizedBox(height: 16),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'CARDHOLDER NAME',
                                                    style: TextStyle(
                                                      color: Colors.white54,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    'EXPIRES',
                                                    style: TextStyle(
                                                      color: Colors.white54,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    paymentMethods[index]['billing_details']['name'],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '12/24',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
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
                                                paymentMethods[index]['card']['last4'],
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
                                    ))),                            
                          ),
                          
                          Padding(
                            padding: EdgeInsets.only(
                                top: 16.0,
                                left: 16.0,
                                right: 16.0), // Define your own padding
                            child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  createPaymentIntent();
                                },
                                child: const Text('Pay'),
                              ),
                            ),
                          )
                        ],
                      )
                    :
                    // GestureDetector(
                    //   onTap: () {
                    //     print("Add New Card pressed");
                    //     toggleShowCardForm();
                    //   },
                    //   child: Text("Add New Card"),
                    // ),
                    // if (showCardForm)
                    paymentWidgetToShow(status)
              ]))
            : Center(child: CircularProgressIndicator()));
  }
}
