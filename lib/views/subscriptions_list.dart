import 'package:soccermadeeasy/commands/base_command.dart';

import '../commands/subscriptions_command.dart';
import '../commands/user_command.dart';
import '../components/Dialogues/congrats_dialogue.dart';
import '../components/Loading/loading_screen.dart';
import '../components/card_form_screen.dart';
import '../components/headers.dart';

import 'package:flutter/material.dart';

import '../constants.dart';

class SubscriptionsList extends StatefulWidget {
  @override
  _SubscriptionsListState createState() => _SubscriptionsListState();
}

class _SubscriptionsListState extends State<SubscriptionsList> {
  bool _isLoading = true;

  final List<dynamic> subscriptions = [
    // {
    //   "icon": Icons.airplanemode_active,
    //   "title": "Regular",
    //   "description": "High-quality, ad-free music streaming",
    //   "bulletPoints": ["Unlimited Skips", "Offline Listening"],
    //   "price": {"amount": ".999"},
    // },
    // {
    //   "icon": Icons.rocket,
    //   "title": "Supercharged",
    //   "description": "Stream thousands of movies and series",
    //   "bulletPoints": ["HD Quality", "No Advertisements"],
    //   "price": {"amount": ".1499"},
    // },
    // {
    //   "icon": Icons.rocket_launch,
    //   "title": "Unlimited",
    //   "description": "Stream thousands of movies and series",
    //   "bulletPoints": ["HD Quality", "No Advertisements"],
    //   "price": {"amount": ".1999"},
    // },
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
              paymentDetails: paymentDetails,
              callbackFunction: goToCongratsScreen,)),
    );
    // await AdaptyPaymentService().makePurchase();
  }

  void popToHome(){
    BaseCommand().popToHome(context);        
  }

  

  Future<void> createSubscriptionTypeUserModel() async{
    print("createSubscriptionTypeUserModel()");
    dynamic user = UserCommand().getAppModelUser();
    dynamic subscriptionInput = {
      "user_id": user['_id'],
      "subscription_type_id": subscriptions[_currentPage]['_id'],

    };
    dynamic createSubscriptionTypeUserResp = await SubscriptionsCommand().createSubscriptionTypeUser(subscriptionInput);
    if(createSubscriptionTypeUserResp['success']){
      print("createSubscriptionTypeUserResp: " + createSubscriptionTypeUserResp.toString());

      goToCongratsScreen();
    }


  }

  Future<void> goToCongratsScreen() async{
    print("goToCongratsScreen()");
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CongratsDialogue(popToHome: popToHome,);
      },
    );    

  }


  Future<void> loadInitialData() async{
    print("loadInitialData()");
    Map<String,dynamic> getSubscriptionsResp = await SubscriptionsCommand().getSubscriptionTypes();
    print("getSubscriptionsResp: " + getSubscriptionsResp.toString());
    if(getSubscriptionsResp["success"]){
      print("getSubscriptionsResp['data']: " + getSubscriptionsResp['data'].toString());
      setState(() {
        subscriptions.clear();
        subscriptions.addAll(getSubscriptionsResp["data"]);
        _isLoading = false;
      });
    }


  }

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Headers().getBackHeader(context, "subscriptions"),
      body: _isLoading
          ? Container(
              height: double.infinity,
              width: double.infinity,
              child: Align(
                alignment: Alignment.center,
                child:
                    // BottomNav()//for times when user deleted in cognito but still signed into app
                    LoadingScreen(
                        currentDotColor: Colors.white,
                        defaultDotColor: Colors.black,
                        numDots: 10),
              ),
            ) : 
            Padding(
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
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.star, size: 50.0),                            
                            Container(height: screenHeight*.3),
                            Text(subscriptions[index]["name"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(subscriptions[index]["description"]),                            
                            Divider(color: Colors.grey),
                            Text("\$${subscriptions[index]["price"]['amount']}/month", style: TextStyle(fontWeight: FontWeight.bold)),
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
