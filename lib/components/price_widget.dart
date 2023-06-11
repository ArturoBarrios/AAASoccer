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
  final priceController = TextEditingController();


  @override
  void initState() {
    super.initState();
    print("PriceWidget initState()");
    loadPriceDetails();
    

  }

  void loadPriceDetails(){
    print("loadPriceDetails()");
    if(widget.eventPrice){
      print("if(widget.eventPrice)");
      priceController.text = (double.parse(widget.userEventDetails['price']['amount'])).toStringAsFixed(2);
    }
    else{
      print("else");
      priceController.text = (double.parse(widget.userEventDetails['price']['teamAmount'])).toStringAsFixed(2);
    }
  }

  Future<void> updatePrice() async{
    print("updatePrice()");
    String newAmount = priceController.text.toString();
    print("newAmount: " + newAmount.toString());
    dynamic priceObject = null;
    if(widget.eventPrice){
      priceObject = widget.userEventDetails['price'];
    }
    else{
      priceObject = widget.userEventDetails['price'];
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
        widget.userEventDetails['price']['amount'] = (double.parse(updatedPrice['amount'])/2).toString();
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
      String amount = "";
      String amountPaid = "";
      String amountRemaining = "";
      if(widget.eventPrice){
        amount = (double.parse(userObjectDetails['price']['amount']) / 100)
            .toStringAsFixed(2);
        amountPaid = (double.parse(userObjectDetails['amountPaid']) / 100)
            .toStringAsFixed(2);
        amountRemaining =
            (double.parse(userObjectDetails['amountRemaining']) / 100)
                .toStringAsFixed(2);

      }
      else{
        amount = (double.parse(userObjectDetails['price']['teamAmount']) / 100)
            .toStringAsFixed(2);
        amountPaid = (double.parse(userObjectDetails['teamAmountPaid']) / 100)
            .toStringAsFixed(2);
        amountRemaining =
            (double.parse(userObjectDetails['teamAmountRemaining']) / 100)
                .toStringAsFixed(2);
      }
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
      
      
        
          Text("Set Price: "),
          Container(
            width: 100, // specify the width of the Container
            child: TextField(
              controller: priceController,
              decoration: new InputDecoration.collapsed(hintText: '0.00'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add button onPressed logic here
              updatePrice();
            },
            child: Text('Update Player Payment'),
          ),
        
    ],
  ),
);


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
