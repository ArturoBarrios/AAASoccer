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
          isExpanded ? Column(
            children: cards.asMap().entries.map((entry) {
              int idx = entry.key;
              Map<String, String> card = entry.value;
              return GestureDetector(
                onTap: () => setState(() => selectedCardIndex = idx),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.credit_card),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(card['name']!),
                        Text('**** ${card['last4']}  Exp ${card['exp']}'),
                      ],
                    ),
                    Icon(Icons.delete),
                  ],
                ),
              );
            }).toList(),
          ) : Container(),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor, // Button color
                onPrimary: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 50), // Button size
              ),
              onPressed: () {
                // Add button action here
              },
              child: Text('Add New Card'),
            ),
          ),
        ],
      ),
    );
  }
}
