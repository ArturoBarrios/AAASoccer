import 'package:flutter/material.dart';

import '../commands/payment_commands.dart';
import '../styles/colors.dart';

class PriceWidget extends StatefulWidget {
  final dynamic price;
  final dynamic teamPrice;
  final dynamic eventPrice;
  final String amountPaid;
  final String amountRemaining;
  final bool isMine;
  final bool isMember;

  PriceWidget({required this.price, required this.teamPrice, required this.eventPrice, required this.amountPaid, required this.amountRemaining, required this.isMine, required this.isMember });

  @override
  _PriceWidgetState createState() => _PriceWidgetState();
}

class _PriceWidgetState extends State<PriceWidget> {
  final priceController = TextEditingController();
  bool isLoading = false;


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
      priceController.text = (double.parse(widget.price['amount'])/100).toStringAsFixed(2);
    }
    else{
      print("else");
      priceController.text = (double.parse(widget.price['teamAmount'])/100).toStringAsFixed(2);
    }
  }

  Future<void> updatePrice() async{
    print("updatePrice()");
    double newAmount = double.parse(priceController.text.toString());
    print("newAmount: " + newAmount.toString());
    dynamic priceObject = null;
    if(widget.eventPrice){
      priceObject = widget.price;
    }
    else{
      priceObject = widget.price;
    }
    dynamic priceInput = {
      "_id": priceObject['_id'],
      "amount": widget.eventPrice ? newAmount*100 : priceObject['amount'],
      "teamAmount": widget.teamPrice ? newAmount*100 : priceObject['teamAmount'],
    };
    dynamic updatePriceResp = await PaymentCommand().updatePrice(priceInput);
    dynamic updatedPrice = updatePriceResp['data'];
    setState(() {
      if(widget.eventPrice){
        widget.price['amount'] = (double.parse(updatedPrice['amount'])).toStringAsFixed(2);
      }
      else{
        widget.price['teamAmount'] = updatedPrice['teamAmount'];
      }
    });
  }

  Container getPriceWidget() {
    print("getPriceWidget()");    
    if (widget.price != null) {
      String amount = "";
      String amountPaid = "";
      String amountRemaining = "";
      if(widget.eventPrice){
        amount = (double.parse(widget.price['amount']) / 100)
            .toStringAsFixed(2);
        amountPaid = (double.parse(widget.amountPaid) / 100)
            .toStringAsFixed(2);
        amountRemaining =
            (double.parse(widget.amountRemaining) / 100)
                .toStringAsFixed(2);

      }
      else{
        amount = (double.parse(widget.price['teamAmount']) / 100)
            .toStringAsFixed(2);
        amountPaid = (double.parse(widget.amountPaid) / 100)
            .toStringAsFixed(2);
        amountRemaining =
            (double.parse(widget.amountRemaining) / 100)
                .toStringAsFixed(2);
      }
      if (!widget.isMine) {
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
                    widget.isMember
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
            style: ElevatedButton.styleFrom(
              primary: AppColors.tsnGreen, // background              
            ),
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
            getPriceWidget(),
              

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
