import '../components/card_form_screen.dart';
import '../components/headers.dart';

import 'package:flutter/material.dart';

import '../constants.dart';

class SubscriptionsList extends StatefulWidget {
  @override
  _SubscriptionsListState createState() => _SubscriptionsListState();
}

class _SubscriptionsListState extends State<SubscriptionsList> {
  final List<Map<String, dynamic>> subscriptions = [
    {
      "icon": Icons.airplanemode_active,
      "title": "Regular",
      "description": "High-quality, ad-free music streaming",
      "bulletPoints": ["Unlimited Skips", "Offline Listening"],
      "price": 9.99,
    },
    {
      "icon": Icons.rocket,
      "title": "Supercharged",
      "description": "Stream thousands of movies and series",
      "bulletPoints": ["HD Quality", "No Advertisements"],
      "price": 14.99,
    },
    {
      "icon": Icons.rocket_launch,
      "title": "Unlimited",
      "description": "Stream thousands of movies and series",
      "bulletPoints": ["HD Quality", "No Advertisements"],
      "price": 19.99,
    },
    //... add more subscriptions
  ];

  int _currentPage = 0;

  void purchaseSubscription(BuildContext context,
      ) async {
    print("purchaseEvent");
    dynamic paymentDetails = {
      "price": subscriptions[_currentPage]["price"],
      "objectToPurchase": subscriptions[_currentPage],
      "objectType": Constants.SUBSCRIPTION,
    };
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardFormScreen(
              subscriptionDetails: paymentDetails)),
    );
    // await AdaptyPaymentService().makePurchase();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: Headers().getBackHeader(context, "subscriptions"),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                itemCount: subscriptions.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: screenWidth * 0.95, // approximately 95% of screen width
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Icon(subscriptions[index]["icon"], size: 50.0),
                            Text(subscriptions[index]["title"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(subscriptions[index]["description"]),
                            ...subscriptions[index]["bulletPoints"].map((item) => ListTile(
                                  leading: Icon(Icons.check),
                                  title: Text(item),
                                )),
                            Divider(color: Colors.grey),
                            Text("\$${subscriptions[index]["price"]}/month", style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                subscriptions.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: _currentPage == index ? 12.0 : 8.0,
                  height: _currentPage == index ? 12.0 : 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                purchaseSubscription(context);
              },
              child: Text('Subscribe'),
            ),
          ],
        ),
      ),
    );
  }
}
