import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import 'package:soccermadeeasy/models/componentModels/payment_model.dart';
import 'package:soccermadeeasy/styles/colors.dart';

class CreditCardChooseAddWidget extends StatefulWidget {  
  const CreditCardChooseAddWidget(
    {Key? key, required this.paymentMethods, required this.selectCard})
    : super(key: key);

  final List paymentMethods;
  final Function? selectCard;

  @override
  State<CreditCardChooseAddWidget> createState() => _CreditCardChooseAddWidgetState();
}

class _CreditCardChooseAddWidgetState extends State<CreditCardChooseAddWidget> {
  bool isExpanded = true;
  int? selectedCardIndex;
  CardFormEditController cardFormEditController = CardFormEditController(
        initialDetails: PaymentModel().cardFieldInputDetails);


  final List<Map<String, String>> cards = [
    {'name': 'Visa', 'last4': '1234', 'exp': '08/2024'},
    {'name': 'MasterCard', 'last4': '5678', 'exp': '09/2025'},
    // Add more dummy card data if needed
  ];

  void _deleteCard(int index) {
    // Add delete logic here
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
            for (var i = 0; i < cards.length; i++) Stack(
              children: [
                GestureDetector(
                  onTap: () => {
                    print("card tapped"),
                    setState(() => selectedCardIndex = i),
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.only(right: 48), // Padding for delete icon
                    color: Colors.transparent, // Transparent color to ensure the GestureDetector is tappable
                    child: Row(
                      children: [
                        Icon(Icons.credit_card),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cards[i]['name']!),
                            Text('**** ${cards[i]['last4']}  Exp ${cards[i]['exp']}'),
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // Calculate the width and height based on screen size
          double width = MediaQuery.of(context).size.width * 0.9; // 90% of screen width
          double height = MediaQuery.of(context).size.height * 0.6; // 60% of screen height

          return Dialog(
            insetPadding: EdgeInsets.all(10), // Add padding around the dialog if needed
            child: Container(
              width: width,
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Allows the column to size itself to its children
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Add Card', style: Theme.of(context).textTheme.headline5),
                    const SizedBox(height: 20),
                    CardFormField(
                      controller: cardFormEditController,
                    ),
                    const SizedBox(height: 10),
                    // Additional buttons or content here
                    ElevatedButton(
                    onPressed: () async {
                      // await createPaymentIntent();
                    },
                    child: const Text('Add Card'))
                  ],
                ),
              ),
            ),
          );
        },
      );
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
