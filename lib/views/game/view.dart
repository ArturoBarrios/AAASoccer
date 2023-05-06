import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/components/Mixins/event_mixin.dart';
import '../../commands/base_command.dart';
import '../../commands/event_command.dart';
import '../../commands/user_command.dart';
import '../../components/Mixins/payment_mixin.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/my_map_page.dart';
import '../../components/profile.dart';
import '../../components/payment_screen.dart';
import '../../commands/location_command.dart';
import '../../components/card_form_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../components/headers.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class PickupView extends StatefulWidget with EventMixin, PaymentMixin {
  PickupView({Key? key, required this.userEventDetails, required this.game})
      : super(key: key);

  final dynamic userEventDetails;
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

  LatLng latLng(lat, lon) {
    return LatLng(lat, lon);
  }

  void goBack() {
    Navigator.pop(context);
  }

  void loadEventPayment() {
    priceObject = widget.game['event']['price'];
  }

  @override
  void initState() {
    super.initState();

    print("initState");
    print("game: " + widget.game.toString());
    loadEventPayment();
    widget.loadEventInfo(widget.game['event']);
    widget.setupPlayerList();
    // _center = latLng(widget.game['event']['location']['data'][0]['latitude'], widget.game['event']['location']['data'][0]['longitude']);
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    print("build()");
    print("game: " + widget.game.toString());
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: Headers().getBackHeader(context, widget.game['event']['name']),
      body: _isLoading
          ? Text("Loading...")
          : ListView(
              padding: EdgeInsets.all(16),
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.amber[600],
                  width: MediaQuery.of(context).size.width -
                      (MediaQuery.of(context).size.width * .1), //10% padding
                  height: 200.0,
                  child: MyMapPage(
                      latitude: widget.game['event']['location']['data'][0]
                          ['latitude'],
                      longitude: widget.game['event']['location']['data'][0]
                          ['longitude']),
                ),
                !widget.userEventDetails['isMine']
                    ? widget.sendOrganizerPlayerEventRequest(context)
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.getPriceWidget(widget.userEventDetails),
                    // Text(
                    //     "Price: \$${(double.parse(priceObject['amount']) / 100).toStringAsFixed(2)}"),
                    widget.userEventDetails['isMine']
                        ? ElevatedButton(
                            onPressed: () {
                              // Add button onPressed logic here
                            },
                            child: Text('Update Payment'),
                          )
                        : Container(),
                  ],
                ),
                //join game gesture detector for now
                widget.getJoinGameWidget(context, widget.userEventDetails,
                    widget.game['event'], widget.userObject),
                widget.getChatWidget(context, true, false, widget.userEventDetails),
              ],
            ),
    );
  }
}
