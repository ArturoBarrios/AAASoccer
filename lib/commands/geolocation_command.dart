import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import '../services/geolocation_services.dart';
import 'package:vector_math/vector_math.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class GeoLocationCommand extends BaseCommand {
  void getLocation() async {
    await GeoLocationServices().getPosition();
  }

  Future<Map<String, dynamic>> getPlacemark(
      double latitude, double longitude) async {
    print("getPlacemark");
    print("latitude: ${latitude}; longitude: ${longitude}");
    Map<String, dynamic> getPlacemarkResponse = {
      "success": false,
      "message": "Something went wrong with getting placemark",
      "data": Map<String, dynamic>()
    };
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      print("placemarks: ${placemarks}");
      // List<Placemark place = placemarks[0];

      getPlacemarkResponse["success"] = true;
      getPlacemarkResponse["message"] = "Got placemark";
      getPlacemarkResponse["data"]["placemarks"] = placemarks;

      // return placemarks[0];
    } catch (e) {
      print(e.toString());
    }

    return getPlacemarkResponse;
  }

  //test functions
  Map<String, dynamic> getRandomPosition(double x0, double y0, int radius) {
    Map<String, dynamic> latLon = {"latitude": 0.0, "longitude": 0.0};
    Random random = new Random();

    // Convert radius from meters to degrees
    double radiusInDegrees = radius / 111000.0;

    double u = random.nextDouble();
    double v = random.nextDouble();
    double w = radiusInDegrees * sqrt(u);
    double t = 2 * pi * v;
    double x = w * cos(t);
    double y = w * sin(t);

    // Adjust the x-coordinate for the shrinking of the east-west distances
    double new_x = x / cos(radians(y0));

    double foundLongitude = new_x + x0;
    double foundLatitude = y + y0;

    latLon["latitude"] = foundLatitude;
    latLon["longitude"] = foundLongitude;

    print("Longitude: $foundLongitude Latitude: $foundLatitude");

    return latLon;
  }
}
