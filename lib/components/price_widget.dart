import 'package:flutter/material.dart';

import '../commands/payment_commands.dart';

class PriceWidget extends StatefulWidget {
  final dynamic userEventDetails;
  final bool teamPrice;
  final bool eventPrice;

  PriceWidget({required this.userEventDetails, required this.teamPrice, required this.eventPrice});

  @override
  _PriceWidgetState createState() => _PriceWidgetState();
}

class _PriceWidgetState extends State<PriceWidget> {

  Future<void> updatePrice(String newAmount) async{
    dynamic priceObject = null;
    if(widget.eventPrice){
      priceObject = widget.userEventDetails['price']['amount'];
    }
    else{
      priceObject = widget.userEventDetails['price']['teamAmount'];
    }
    dynamic priceInput = {
      "_id": priceObject['_id'],
      "amount": widget.eventPrice ? newAmount : priceObject['amount'],
      "teamAmount": widget.teamPrice ? newAmount : priceObject['teamAmount'],
    };
    dynamic updatePriceResp = await PaymentCommand().updatePrice(priceInput);
    dynamic updatedPrice = updatePriceResp['data'];
    setState(() {
      if(widget.eventPrice){
        widget.userEventDetails['price']['amount'] = updatedPrice['amount'];
      }
      else{
        widget.userEventDetails['price']['teamAmount'] = updatedPrice['teamAmount'];
      }
    });
  }

  Container getPriceWidget(dynamic userObjectDetails) {
    print("getPriceWidget()");
    print("userObjectDetails: " + userObjectDetails.toString());
    if (userObjectDetails['price'] != null) {
      String amount = (double.parse(userObjectDetails['price']['amount']) / 100)
          .toStringAsFixed(2);
      String amountPaid = (double.parse(userObjectDetails['amountPaid']) / 100)
          .toStringAsFixed(2);
      String amountRemaining =
          (double.parse(userObjectDetails['amountRemaining']) / 100)
              .toStringAsFixed(2);
      if (!userObjectDetails['roles'].contains("ORGANIZER")) {
        if (amountRemaining == "0.00") {
          return Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Text("Price: \$${(amount)}"),
                IconButton(
                  icon: const Icon(Icons.check_circle),
                  tooltip: 'Go to the next page',
                  onPressed: () {},
                ),
              ]));
        }
        //double.parse(amountRemaining)>0.00
        else {
          return Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Text(
                      "Price: \$${(amount)}",
                      style: TextStyle(fontSize: 16),
                    ),
                    userObjectDetails['isMember']
                        ? Text(
                            "Remaining Balance: \$$amountRemaining",
                            style: TextStyle(fontSize: 16),
                          )
                        : Container()
                  ])
            ],
          ));
        }
      } else {
        return Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    "Set Price: \$${(amount)}",
                    style: TextStyle(fontSize: 16),
                  ),
                ])
          ],
        ));
      }
    } else {
      return Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("FREE!")],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
        Column(
          children: [
            getPriceWidget(widget.userEventDetails),
              ElevatedButton(
                onPressed: () {
                  // Add button onPressed logic here
                  updatePrice("5");
                },
                child: Text('Update Player Payment'),
              )

          ]
      ),
    );
  }
}

class UserObjectDetails {
  final double price;
  final String currency;

  UserObjectDetails({required this.price, required this.currency});
}
