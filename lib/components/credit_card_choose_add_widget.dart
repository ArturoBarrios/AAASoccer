import 'package:flutter/material.dart';

class CreditCardChooseAddWidget extends StatefulWidget {
  @override
  _CreditCardChooseAddWidgetState createState() => _CreditCardChooseAddWidgetState();
}

class _CreditCardChooseAddWidgetState extends State<CreditCardChooseAddWidget> {
  bool isExpanded = false;
  int? selectedCardIndex;

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
            child: Container(
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  print("add new card pressed");
                },
                child: Text('Add New Card'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
