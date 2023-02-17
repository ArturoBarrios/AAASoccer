import 'package:flutter/material.dart';
import '../../components/profile.dart';
import '../../components/payment_screen.dart';
import '../../components/card_form_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../components/headers.dart';
import 'dart:async';


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
    _isLoading = true;
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
        appBar: Headers().getMainHeader(context),
        body: 
        !_isLoading ? 
        Text("Loading...")
        :
        MyMapPage()
        )
    );
          
      
      // Center(
      //     child: Column(children: [     
      //       GoogleMap(
      //     onMapCreated: _onMapCreated,
      //     initialCameraPosition: CameraPosition(
      //       target: _center,
      //       zoom: 11.0,
      //     ),
      //   ),      
      //   TextField(
      //     readOnly: !widget.isMyEvent,
      //     controller: nameController,
      //     decoration: new InputDecoration.collapsed(hintText: 'Name'),
      //   ),
      //   TextField(
      //     readOnly: !widget.isMyEvent,
      //     controller: nameController,
      //     decoration: new InputDecoration.collapsed(hintText: 'Home'),
      //   ),                
      //   GestureDetector(
      //       onTap: () {
      //         widget.game['event']['price'] == 0 ? 
      //         //free game
      //         print("hi")
      //         :                        
      //         Navigator.push(context, MaterialPageRoute<void>(
      //           builder: (BuildContext context) {
      //             return CardFormScreen(
      //               priceObject:                   
      //                 widget.game['event']['price'] 
      //              );
      //           }));
            
              
      //       },
      //       child: Text("Join Event")),
      //   GestureDetector(
      //       onTap: () {
      //         goBack();
      //       },
      //       child: Text("Back to Home")),
      // ])),      
    
  }

  
}

class MyMapPage extends StatefulWidget {
  @override
  State<MyMapPage> createState() => MapPageState();
}
 
class MapPageState extends State<MyMapPage> {
  Completer<GoogleMapController> _controller = Completer();
 
  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(
      32.776665,
      -96.796989,
    ),
    zoom: 10.0,
  );
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
