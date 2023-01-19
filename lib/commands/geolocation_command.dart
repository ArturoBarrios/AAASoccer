import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import '../services/geolocation_services.dart';
import 'package:vector_math/vector_math.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class GeoLocationCommand extends BaseCommand {
  Future <Position> determinePosition() async {
    Position position = await GeoLocationServices().determinePosition();
    return position;
  }

  Future <void> setUserAddress(double latitude, double longitude) async {
    print("setUserAddress");
    print("latitude: $latitude");
    print("longitude: $longitude");
    print("placemarkFromCoordinates");
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    print("placemarks: " + placemarks.toString());


  }

  Future<double> getDistanceFromUser(double latitude, double longitude) async {
    print("getDistanceFromUser");
    double distance = 0.0;
    print("currentUser: "+appModel.currentUser.toString());
    print("vars: "+ latitude.toString()+" "+ longitude.toString()+" "+appModel.currentPosition.latitude.toString()+" "+appModel.currentPosition.longitude.toString());
    //todo: make sure user has a position
    distance = await GeoLocationServices().calculateDistanceInKMFromLocation(latitude, longitude, appModel.currentPosition.latitude, appModel.currentPosition.longitude);

    return distance;
  }
  


  /////////////////test functions
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
