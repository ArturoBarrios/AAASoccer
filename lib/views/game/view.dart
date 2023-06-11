import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/components/Mixins/event_mixin.dart';
import '../../commands/base_command.dart';
import '../../commands/event_command.dart';
import '../../commands/user_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/Mixins/payment_mixin.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/chats_list_widget.dart';
import '../../components/location_search_bar.dart';
import '../../components/my_map_page.dart';
import '../../components/players_list_widget.dart';
import '../../components/profile.dart';
import '../../components/payment_screen.dart';
import '../../commands/location_command.dart';
import '../../components/card_form_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../components/headers.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

import '../../components/update_view_form.dart';
import '../../constants.dart';

class PickupView extends StatefulWidget with EventMixin, PaymentMixin {
  PickupView({Key? key, required this.game})
      : super(key: key);

  final dynamic game;
  

  @override
  _PickupViewState createState() => _PickupViewState();
}

class _PickupViewState extends State<PickupView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

  bool _isLoading = true;
  late LatLng _center = LatLng(45.521563, -122.677433);
  dynamic priceObject;
  dynamic userEventDetails;
  dynamic playerListWidgetDetails;
  LocationSearchBar locationSearchBar = new LocationSearchBar();

  LatLng latLng(lat, lon) {
    return LatLng(lat, lon);
  }

  void goBack() {
    Navigator.pop(context);
  }

  void loadEventPayment() {
    priceObject = widget.game['event']['price'];
  }

  void loadInitialData() async {
    print("loadInitialData() in TeamView");
    //wait for 3 seconds
    await Future.delayed(const Duration(seconds: 2));
    dynamic getEventDetailsResp = EventCommand().getUserEventDetails([widget.game['event']]);
    // widget.setupRequestWidgetData(getEventDetailsResp);
    widget.setupPlayerList();
    playerListWidgetDetails =  await widget.getPlayerListWidgetDetails(getEventDetailsResp);
    // locationSearchBar = new LocationSearchBar(initialLocation: {"latitude": getEventDetailsResp['mainEvent']['latitude'], })
    setState(() {
      userEventDetails = getEventDetailsResp;
      _isLoading = false;
    });
      print("userEventDetails: " + userEventDetails.toString());
      print("loadInitialData() finished!");
      print("loadEventPayment() in loadInitialData()");
      loadEventPayment();
      print("loadEventPayment() finished in loadInitialData()");

  }

  void updateChatsList(dynamic createdChat){
    print("updateChatsList");
    print("createdChat: " + createdChat.toString());
    setState(() {
      userEventDetails['mainEvent']['chats']['data'].add(createdChat);      
    });
  }

  @override
  void initState() {
    super.initState();

    print("initState");
    print("game: " + widget.game.toString());
    // loadEventPayment();
    // widget.loadEventInfo(widget.game['event']);
    // widget.setupPlayerList();
    // _center = latLng(widget.game['event']['location']['data'][0]['latitude'], widget.game['event']['location']['data'][0]['longitude']);
    loadInitialData();
    // _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    print("build()");
    print("game: " + widget.game.toString());
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: Headers().getBackHeader(context, widget.game['event']['name']),
      body: _isLoading
          ?  Container(
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
    )
          : SingleChildScrollView(
            child: Center(
              child: Expanded(
                child: Column(

                

              

            
            
              children: [
                UpdateViewForm(userObjectDetails: userEventDetails),
                

                // Container(
                //   margin: const EdgeInsets.all(10.0),
                //   color: Colors.amber[600],
                //   width: MediaQuery.of(context).size.width -
                //       (MediaQuery.of(context).size.width * .1), //10% padding
                //   height: 200.0,
                //   child:
                //   //map
                //    MyMapPage(
                //       latitude: widget.game['event']['location']['data'][0]
                //           ['latitude'],
                //       longitude: widget.game['event']['location']['data'][0]
                //           ['longitude']),
                // ),
                // userEventDetails['isMine'] ? 
                //   locationSearchBar = LocationSearchBar(initialValue: userEventDetails['mainEvent']['location']['data'][0]['name'])
                //    :
                //   Text(userEventDetails['mainEvent']['location']['data'][0]['name']) ,
                !userEventDetails['isMine']
                    ? widget.sendOrganizerPlayerEventRequest(context, userEventDetails)
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.getPriceWidget(userEventDetails),
                    
                    userEventDetails['isMine']
                        ? ElevatedButton(
                            onPressed: () {
                              // Add button onPressed logic here
                            },
                            child: Text('Update Payment'),
                          )
                        : Container(),
                  ],
                ),
                // if (userEventDetails['isMine'])
                //   widget.createEventRequestWidget,
                // if (userEventDetails['isMine'])
                //   widget.createEventPaymentWidget,
                //join game gesture detector for now
                widget.getJoinGameWidget(context, userEventDetails,
                    widget.game['event'], widget.userObject),
                widget.getChatWidget(context, true, false, userEventDetails, updateChatsList  ),
                ChatsListWidget(
                  chats: userEventDetails['mainEvent']['chats']['data']
                ),
          widget.sendPlayersRequestWidget(context, userEventDetails),
                SizedBox(
            child: Container(
    height: 450,
    child: PlayerList(playersDetails: playerListWidgetDetails),
  ),
  
          ),



              ],
            )))),
    );
  }
}
