import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/components/Mixins/event_mixin.dart';
import '../../commands/base_command.dart';
import '../../commands/event_command.dart';
import '../../commands/user_command.dart';
import '../../components/Mixins/payment_mixin.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/profile.dart';
import '../../components/payment_screen.dart';
import '../../commands/location_command.dart';
import '../../components/card_form_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../components/headers.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class PickupView extends StatefulWidget with EventMixin, PaymentMixin, EventMixin {
  PickupView({Key? key, required this.userEventDetails , required this.game})
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
  late GoogleMapController mapController;
  dynamic priceObject;
  // dynamic userObject;
  bool participatingInGame = false;
  // List<String> participationRoles = [];
  // dynamic eventUserParticipant;

  // List<int>? selectedRequestTypeIndexes;
  // List requestUserTypes = [
  //   Constants.PLAYER.toString(),
  //   Constants.ORGANIZER.toString(),
  //   Constants.MANAGER.toString(),
  //   Constants.MAINCOACH.toString(),
  //   Constants.ASSISTANTCOACH.toString(),
  //   Constants.REF.toString(),
  // ];
  // List<String> selectedRequestTypeObjects = [];

  requestTypeSelected(List<int>? indexes) {
    widget.requestTypeSelected(indexes);
    // print("requestTypeSelected: " + indexes.toString());
    // selectedRequestTypeIndexes = indexes;
    // for (int i = 0; i < indexes!.length; i++) {
    //   selectedRequestTypeObjects.add(requestUserTypes[indexes[i]]);
    // }
  }

  Future<void> sendEventRequest() async {
    widget.sendEventRequest(widget.game, Constants.GAMEREQUEST.toString());
    // print("sendEventRequest");
    // print("selectedRequestTypeObjects.length: " +
    //     selectedRequestTypeObjects.length.toString());
    // print(
    //     "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    // print("send player event request");
    // for(int i = 0;i<selectedRequestTypeObjects.length;i++){
    //   await EventCommand().sendOrganizerEventRequest(widget.game, selectedRequestTypeObjects[i], Constants.GAMEREQUEST.toString());
    // }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  LatLng latLng(lat, lon) {
    return LatLng(lat, lon);
  }

  GestureDetector getJoinGameWidget(){
    return widget.getJoinGameWidget(context, widget.userEventDetails, widget.game['event'], widget.userObject);
  }

  GestureDetector getChatWidget() {
    return widget.getChatWidget(context);
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
      appBar: Headers().getBackHeader(context, "View Game"),
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
                !widget.userEventDetails['isMyEvent']
                    ? Container(
                        height: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: GestureDetector(
                              onTap: () async {
                                print("onTap: ");
                                List<int>? requestIndexes =
                                    await showAnimatedDialog<dynamic>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return ClassicListDialogWidget<dynamic>(
                                        selectedIndexes:
                                            widget.selectedRequestTypeIndexes,
                                        titleText: 'Choose User Type',
                                        positiveText: "Send Request",
                                        listType: ListType.multiSelect,
                                        activeColor: Colors.green,
                                        dataList: widget.requestUserTypes);
                                  },
                                  animationType: DialogTransitionType.size,
                                  curve: Curves.linear,
                                );

                                widget.selectedRequestTypeIndexes =
                                    requestIndexes ??
                                        widget.selectedRequestTypeIndexes;
                                print(
                                    'selectedIndex:${widget.selectedRequestTypeIndexes?.toString()}');
                                await requestTypeSelected(
                                    widget.selectedRequestTypeIndexes);
                                await sendEventRequest();
                              },
                              child: Text("Send Request")),
                        ),
                      )
                    : (Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Price: \$${(double.parse(priceObject['amount']) / 100).toStringAsFixed(2)}"),
                    widget.userEventDetails['isMyEvent']
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
                getJoinGameWidget(),
                 getChatWidget(),
              ],
            ),
    );
  }
}

class MyMapPage extends StatefulWidget {
  const MyMapPage({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  final double latitude;
  final double longitude;

  @override
  State<MyMapPage> createState() => MapPageState();
}

class MapPageState extends State<MyMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(
      0,
      0,
    ),
    zoom: 10.0,
  );

  CameraPosition getCameraPosition(double latitude, double longitude) {
    print("getCameraPosition: " +
        latitude.toString() +
        ", " +
        longitude.toString());
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(
        latitude,
        longitude,
      ),
      zoom: 10.0,
    );

    return cameraPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            getCameraPosition(widget.latitude, widget.longitude),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (argument) =>
            LocationCommand().openMap(widget.latitude, widget.longitude),
      ),
    );
  }
}
