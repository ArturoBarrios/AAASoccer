import 'dart:ffi';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../../components/profile.dart';
import '../../components/payment_screen.dart';
import '../../commands/location_command.dart';
import '../../commands/event_command.dart';
import '../../components/card_form_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../components/headers.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class GameUpdate extends StatefulWidget {
  const GameUpdate({Key? key, required this.game}) : super(key: key);

  final dynamic game;

  @override
  _GameUpdateState createState() => _GameUpdateState();
}

class _GameUpdateState extends State<GameUpdate> {
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  LatLng latLng(lat, lon) {
    return LatLng(lat, lon);
  }

  void purchaseEvent() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CardFormScreen(priceObject: widget.game['event'])),
    );
    // await AdaptyPaymentService().makePurchase();
  }

  void partiallyUpdateEvent(dynamic gameObject) async{
    Map<String, dynamic> gameEventInput = {
    'game': {
      '_id': gameObject['_id'],
      'dataToUpdate': {
        'name': 'Something Random'
      }
    },
    'event': {
      '_id': gameObject['event']['_id'],
      'dataToUpdate': jsonEncode({
        'homegoals': 5
      })
    },
  };
    await EventCommand().partiallyUpdateGame(gameObject);
  }

  void goBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    print("initState");
    print("game: " + widget.game.toString());
    // _center = latLng(widget.game['event']['location']['data'][0]['latitude'], widget.game['event']['location']['data'][0]['longitude']);
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    print("game build()");
    print("game: " + widget.game.toString());
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green[700],
        ),
        home: Scaffold(
            appBar: Headers().getBackHeader(context),
            body: _isLoading
                ? Text("Loading...")
                : Center(
                  
                    child:  Column(
                      children: [                                                                    
                      TextField(
                        controller: nameController,
                        decoration: new InputDecoration.collapsed(hintText: 'Away'),          
                      ),
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        color: Colors.amber[600],
                        width: MediaQuery.of(context).size.width -
                            (MediaQuery.of(context).size.width *
                                .1), //10% padding
                        height: 200.0,
                        child: MyMapPage(
                            latitude: widget.game['event']['location']['data']
                                [0]['latitude'],
                            longitude: widget.game['event']['location']['data']
                                [0]['longitude'])),
                      GestureDetector(
                        onTap: () {
                          print("onTap Update Game button");
                          partiallyUpdateEvent(widget.game);
                        },
                        child: Text("Update Game"),
                      ),
                      GestureDetector(
                    onTap: () {
                      print("onTap Join Game");
                      purchaseEvent();
                    },
                    child: Text("Join Game"),
                  )
                  
                    ]),
                  
                  )
            // MyMapPage()
            ));
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
        body: Stack(children: <Widget>[
      Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        //list view
        Expanded(
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition:
                getCameraPosition(widget.latitude, widget.longitude),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (argument) =>
                LocationCommand().openMap(widget.latitude, widget.longitude),
          ),
        ),
      ]),
    ]));
  }
}
