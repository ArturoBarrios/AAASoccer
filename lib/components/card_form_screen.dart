import 'dart:io';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/blocs/payment/payment_bloc.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import 'package:soccermadeeasy/components/credit_card_choose_add_widget.dart';
import 'package:soccermadeeasy/components/text_icon_selection_widget.dart';
import 'package:soccermadeeasy/extensions/snackbar_dialogue.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../commands/event_command.dart';
import '../commands/subscriptions_command.dart';
import '../commands/team_command.dart';
import '../constants.dart';
import '../models/enums/payment_status_type.dart';
import '../models/componentModels/payment_model.dart';
import '../commands/payment_commands.dart';
import '../commands/user_command.dart';
import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

import '../styles/colors.dart';
import '../styles/font_sizes.dart';
import 'Buttons/apple_google_pay_button.dart';
import 'headers.dart';
import 'models/button_model.dart';

class CardFormScreen extends StatefulWidget {
  const CardFormScreen(
      {Key? key, required this.paymentDetails, required this.callbackFunction})
      : super(key: key);

  final dynamic paymentDetails;
  final Function callbackFunction;

  @override
  State<CardFormScreen> createState() => _CardFormScreenState();
}

class _CardFormScreenState extends State<CardFormScreen> {
  bool isLoading = true;
  bool isPaymentProcessing = false;
  bool showCardForm = false;
  List paymentMethods = [];
  dynamic selectedPaymentMethod = null;
  CardFormEditController cardFormEditController = CardFormEditController(
      initialDetails: PaymentModel().cardFieldInputDetails);
  late ScrollController _selectPaymentController = ScrollController();
  final FlipCardController flipCardController = FlipCardController();
  List waysToPay = [
    "Credit Card",
    // "Pay With Existing Card",
    // "PayPal",
    // "Apple Card",
    // Platform.isAndroid ? "Google Pay" : "Apple Pay",
  ];

  String? _selectedPayment = "Credit Card";

  void selectPaymentMethod(dynamic paymentMethod) {
    print("selectPaymentMethod");
    setState(() {
      selectedPaymentMethod = paymentMethod;
      showCardForm = false;
    });
  }

  Future<void> createPaymentIntent() async {
    setState(() {
      isPaymentProcessing = true;
      isLoading = true;
    });
    DateTime now = DateTime.now();
    String timestamp = now.millisecondsSinceEpoch.toString();
    Map<String, dynamic> currentUser = UserCommand().getAppModelUser();

    final paymentInput = {
      'paymentType': widget.paymentDetails['objectType'] == Constants.TEAM
          ? 'team'
          : 'player',
      'amount': widget.paymentDetails['price']['amount'],
      'userId': currentUser['_id'],
      'paidAt': timestamp,
    };
    print("currentUser: " + currentUser.toString());
    print("createPaymentIntent");
    print("priceObject in CardFormScreen: " +
        widget.paymentDetails['price'].toString());
    print("_selectedPayment: " + _selectedPayment.toString());

    dynamic createPaymentIntentInput = {
      'price': widget.paymentDetails['price'],
      'event': widget.paymentDetails,
      'paymentCreateIntent': PaymentCreateIntent(
          billingDetails: BillingDetails(
            email: currentUser['email'],
            name: currentUser['name'],
            phone: currentUser['phone'],
          ),
          items: [
            {'id': 0},
            {'id': 1}
          ]),
    };
    if (selectedPaymentMethod != null) {
      createPaymentIntentInput['paymentMethodId'] = selectedPaymentMethod['id'];
    }
    Map<String, dynamic> createPaymentIntentResp =
        await PaymentCommand().createPaymentIntent(createPaymentIntentInput);

    print("createPaymentIntentResp: " + createPaymentIntentResp.toString());
    if (createPaymentIntentResp['success'] ||
        widget.paymentDetails['price']['amount'] == '0') {
      print("createpaymentrespintentt: " +
          createPaymentIntentResp['data']['intent'].toString());
      paymentInput['charge'] =
          createPaymentIntentResp['data']['intent']['latest_charge'];

      print("now addEvent");
      if (widget.paymentDetails['objectType'] == Constants.EVENT) {
        dynamic addEventResp = await EventCommand().addUserToEvent(
            //objectToPurchase is mainEvent
            widget.paymentDetails['objectToPurchase'],
            currentUser,
            widget.paymentDetails['roles']);
        if (addEventResp['success']) {
          dynamic eventToAdd = addEventResp['data'];
          //add user to event in page models
          paymentInput['eventId'] = eventToAdd['_id'];
          print("paymentInput: " + paymentInput.toString());
          Map<String, dynamic> createUserObjectPaymentResp =
              await PaymentCommand().createUserObjectPayment(paymentInput);
          //payment went through
          if (createUserObjectPaymentResp['success']) {
            EventCommand().updateViewModelsWithEvent(eventToAdd, true, true);
            EventCommand().addUserToEventPageModel(eventToAdd, currentUser);
          }
        }

        print("addEventResp: " + addEventResp.toString());
      } else if (widget.paymentDetails['objectType'] ==
          Constants.SUBSCRIPTION) {
        dynamic subscriptionInput = {
          "user_id": currentUser['_id'],
          "subscription_type_id": widget.paymentDetails['objectToPurchase']
              ['_id'],
        };
        print("subscriptionInputt: " + subscriptionInput.toString());
        dynamic createSubscriptionTypeUserResp =
            await SubscriptionsCommand().createSubscription(subscriptionInput);
        print("createSubscriptionTypeUserResp: " +
            createSubscriptionTypeUserResp.toString());
      } else if (widget.paymentDetails['objectType'] == Constants.TEAM) {
        dynamic addEventResp = await TeamCommand().addUserToTeam(
          widget.paymentDetails['objectToPurchase'],
          currentUser,
          widget.paymentDetails['roles'],
        );
        paymentInput['teamId'] =
            widget.paymentDetails['objectToPurchase']['_id'];
        await PaymentCommand().createUserObjectPayment(paymentInput);

        print("addEventResp: " + addEventResp.toString());
      }
      //move on to next screen
      setState(() {
        isPaymentProcessing = false;
        isLoading = false;
      });

      print("move on to next screen");

      //go back
      // Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    } else {
      print("payment failedddd fuckkk");
    }
  }

  Widget paymentWidgetToShow(PaymentStatusType status) {
    print("PaymentType statusssss to show: " + status.name);
    // CardFormEditController controller = CardFormEditController(
    //     initialDetails: PaymentModel().cardFieldInputDetails);
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
                    controller: cardFormEditController,
                    style: CardFormStyle(
                        textColor: AppColors.tsnRed,
                        placeholderColor: AppColors.tsnRed,
                        backgroundColor: Colors.white)),
                const SizedBox(height: 10),
                // ElevatedButton(
                //     onPressed: () async {
                //       await createPaymentIntent();
                //     },
                //     child: const Text('Pay'))
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
        dynamic currentUser = UserCommand().getAppModelUser();
        dynamic currentUserStripeCustomers = currentUser['stripeCustomers'];
        print("currentUserStripeCustomers: " +
            currentUserStripeCustomers.toString());

        print(
            "testingggg: " + getCustomerPaymentMethodsResp['data'].toString());
        // _selectedPayment = getCustomerPaymentMethodsResp['data'][0]['id'];
        // _selectedPayment = "Pay With Existing Card";
      } else {
        // _selectedPayment = "Pay With New Card";
      }
      setState(() {
        var timer =
            Timer(Duration(milliseconds: 500), () => print('timer done'));

        timer.cancel();
        isLoading = false;

        paymentMethods = getCustomerPaymentMethodsResp['data'];
        paymentMethods =
            paymentMethods.map<Map<String, dynamic>>((paymentMethod) {
          print("paymentMethod: " + paymentMethod.toString());

          var card = paymentMethod['card'];
          return {
            'id': paymentMethod['id'],
            'brand': card['brand'],
            'last4': card['last4'],
            'expMonth': card['exp_month'],
            'expYear': card['exp_year'],
            'country': card['country']
          };
        }).toList();
        print("paymentMethods: " + paymentMethods.toString());
      });
    } else {
      // _selectedPayment = "Pay With New Card";
      dynamic currentUser = UserCommand().getAppModelUser();
      dynamic createCustomerResp =
          await PaymentCommand().createCustomer(currentUser['email']);
      if (createCustomerResp['success']) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> loadInitialData() async {
    //get customers associated with email
    //foreach customer, get payment methods
    //todo check if customer exists, if so show credit card options.
    await getCustomerPaymentMethods();
  }

  void update() => setState(() {});

  @override
  void dispose() {
    cardFormEditController.removeListener(update);
    cardFormEditController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    cardFormEditController.addListener(update);
    print("card form screen initState()");

    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    PaymentStatusType status = context
        .select<PaymentModel, PaymentStatusType>((value) => value.status);
    Widget child;
    return Scaffold(
  appBar: Headers(
    playerStepperButton: ButtonModel(
      prefixIconData: Icons.play_circle_fill_rounded,
      onTap: () {},
    ),
  ).getMainHeader(context),
  body: !isLoading
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Text("Select Payment Method",
                  style: TextStyle(
                      fontSize: FontSizes.xl(context),
                      color: AppColors.tsnBlack)),
            ),
            CreditCardChooseAddWidget(
              paymentMethods: paymentMethods,
              selectCard: selectPaymentMethod,
              showCardForm: (bool showCardFormValue) {
                setState(() {
                  showCardForm = showCardFormValue;
                });
              },
            ),
            if (showCardForm) paymentWidgetToShow(status),
            Spacer(), // This will push the following widgets to the bottom
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 2.0),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dummy Text 1",
                      style: TextStyle(
                        fontSize: FontSizes.m(context),
                        color: AppColors.tsnBlack,
                      ),
                    ),
                    Text(
                      "Dummy Text 2",
                      style: TextStyle(
                        fontSize: FontSizes.m(context),
                        color: AppColors.tsnBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      : Center(child: CircularProgressIndicator()),
  bottomNavigationBar: Padding(
    padding:
        EdgeInsets.only(bottom: 26.0, top: 16.0, left: 16.0, right: 16.0),
    child: Container(
      width: double.infinity,
      child: BasicElevatedButton(
        onPressed: () async {
          createPaymentIntent();
        },
        backgroundColor: !isPaymentProcessing &&
                (cardFormEditController.details.complete ||
                    selectedPaymentMethod != null)
            ? AppColors.tsnGreen
            : AppColors.tsnGrey,
        text: 'Pay',
      ),
    ),
  ),
);

  }
}
