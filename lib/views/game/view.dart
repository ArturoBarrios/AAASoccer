import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../components/profile.dart';
import '../../components/payment_screen.dart';
import '../../commands/location_command.dart';
import '../../components/card_form_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../components/headers.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';


class PickupView extends StatefulWidget {
  const PickupView(
    {Key? key, required this.isMyEvent, required this.game })
    : super(key: key);

    final bool isMyEvent;
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




  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  LatLng latLng(lat, lon){
    return LatLng(lat, lon);
  }

  void purchaseEvent() async{
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardFormScreen(priceObject: widget.game['event'])),
    );    
    // await AdaptyPaymentService().makePurchase();
  }

  void goBack(){
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    print("initState");
    print("game: "+widget.game.toString());
    // _center = latLng(widget.game['event']['location']['data'][0]['latitude'], widget.game['event']['location']['data'][0]['longitude']);
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    print("build()");
    print("game: "+widget.game.toString());    
    return 
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: Headers().getBackHeader(context),
        body: 
        _isLoading ? 
        Text("Loading...")
        :
        Center(
          child: Container(
            margin: const EdgeInsets.all(10.0),
            color: Colors.amber[600],
            width: MediaQuery.of(context).size.width-
                    (MediaQuery.of(context).size.width*.1),//10% padding
            height: 200.0,
            child: MyMapPage(latitude: widget.game['event']['location']['data'][0]['latitude'], longitude: widget.game['event']['location']['data'][0]['longitude'])
          ),
        )
        // MyMapPage()
        )
    );      
  }

  
}

class MyMapPage extends StatefulWidget {
  const MyMapPage(
    {Key? key, required this.latitude, required this.longitude })
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

  CameraPosition getCameraPosition(double latitude, double longitude){
    print("getCameraPosition: "+latitude.toString()+", "+longitude.toString());
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
        initialCameraPosition: getCameraPosition(widget.latitude, widget.longitude),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap:(argument) => LocationCommand().openMap(widget.latitude, widget.longitude),
      ),
    );
  }
}
