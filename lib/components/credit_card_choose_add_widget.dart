import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:soccermadeeasy/commands/payment_commands.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import 'package:soccermadeeasy/models/componentModels/payment_model.dart';
import 'package:soccermadeeasy/styles/colors.dart';

class CreditCardChooseAddWidget extends StatefulWidget {  
  const CreditCardChooseAddWidget(
    {Key? key, required this.paymentMethods, required this.selectCard, required this.showCardForm})
    : super(key: key);

  final List paymentMethods;
  final Function? selectCard;
  final Function? showCardForm;

  @override
  State<CreditCardChooseAddWidget> createState() => _CreditCardChooseAddWidgetState();
}

class _CreditCardChooseAddWidgetState extends State<CreditCardChooseAddWidget> {
  bool isExpanded = true;
  int? selectedCardIndex;
  CardFormEditController cardFormEditController = CardFormEditController(
        initialDetails: PaymentModel().cardFieldInputDetails);


  // final List<Map<String, String>> cards = [
  //   {'name': 'Visa', 'last4': '1234', 'exp': '08/2024'},
  //   {'name': 'MasterCard', 'last4': '5678', 'exp': '09/2025'},
  //   // Add more dummy card data if needed
  // ];

  void _deleteCard(int index) {
    // Add delete logic here
  }

  Future<void> createPayment() async{
    print("createPayment");    
    dynamic createPaymentMethodInput = {
      "card_number": cardFormEditController.details.number,
      "exp_month": cardFormEditController.details.expiryMonth,
      "exp_year": cardFormEditController.details.expiryYear,
      "cvc": cardFormEditController.details.validCVC,
    };
    print("createPaymentMethodInput: " + createPaymentMethodInput.toString());
    
    dynamic createPaymentMethodResp = PaymentCommand().createPaymentMethod(createPaymentMethodInput);
    if(createPaymentMethodResp['success']){
      print("card added");
    }
    

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
                widget.showCardForm!(false);
              });
            },
            child:
             Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.credit_card),
                      SizedBox(width: 8),
                      Text('Choose a Card'),
                    ],
                  ),
                  Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          Divider(),
          if (isExpanded) ...[
            for (var i = 0; i < widget.paymentMethods.length; i++) Stack(
  children: [
    GestureDetector(
      onTap: () => {
        print("card tapped"),
        widget.selectCard!(widget.paymentMethods[i]),
        setState(() => selectedCardIndex = i),
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.only(right: 48), // Padding for delete icon
        decoration: BoxDecoration(
          border: selectedCardIndex == i ? Border.all(color: AppColors.tsnGreen, width: 2) : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(4), // Optional, for rounded corners
        ),
        child: Row(
          children: [
            Icon(Icons.credit_card),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.paymentMethods[i]['brand']!),
                Text('**** ${widget.paymentMethods[i]['last4']}  Exp ${widget.paymentMethods[i]['expYear']}'),
              ],
            ),
          ],
        ),
      ),
    ),
    Positioned(
      top: 0,
      bottom: 0,
      right: 0,
      child: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => {
          print("deletePressed")
        },
      ),
    ),
  ],
),


            Padding(
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  child: BasicElevatedButton(
    backgroundColor: AppColors.tsnGreen,
    onPressed: () {
      print("add card pressed");
      widget.showCardForm!(true);
      isExpanded = false;
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
          // Calculate the width and height based on screen size
          // double width = MediaQuery.of(context).size.width * 0.9; // 90% of screen width
          // double height = MediaQuery.of(context).size.height * 0.6; // 60% of screen height

          // return Dialog(
          //   insetPadding: EdgeInsets.all(10), // Add padding around the dialog if needed
          //   child: Container(
          //     width: width,
          //     height: height,
          //     child: Padding(
          //       padding: const EdgeInsets.all(20),
          //       child: Column(
          //         mainAxisSize: MainAxisSize.min, // Allows the column to size itself to its children
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.stretch,
          //         children: [
          //           Text('Add Card', style: Theme.of(context).textTheme.headline5),
          //           const SizedBox(height: 20),
          //           CardFormField(
          //             controller: cardFormEditController,
          //           ),
          //           const SizedBox(height: 10),
          //           // Additional buttons or content here
          //           ElevatedButton(
          //           onPressed: () async {
          //             await createPayment();
          //             // await createPaymentIntent();
          //           },
          //           child: const Text('Add Card'))
          //         ],
          //       ),
          //     ),
          //   ),
          // );
        // },
      // );
    },
    textColor: AppColors.tsnWhite,
    text: 'Add New Card',
  ),
),


          ],
        ],
      ),
    );
  }
}
