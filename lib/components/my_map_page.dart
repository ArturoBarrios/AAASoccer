import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../commands/location_command.dart';

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