import 'dart:ffi';
import 'dart:math';

import '../../commands/location_command.dart';
import '../../commands/geolocation_command.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../models/Location.dart' as LocationModel;

// import '../../models/Location.dart';

class LocationSeeder {
  void createRandomUserLocations(Map<String, dynamic> data) async {
    print("LocationSeeder::run();n=${data['num_of_locs']}");
    for (int i = 0; i < data['num_of_locs']; i++) {
      print("i: " + i.toString());
      Map<String, dynamic> locationData =
          await generateRandomLocation(data['num_of_locs']);
      await LocationCommand().createLocation(locationData);
    }
  }

  Future<Map<String, dynamic>> generateRandomLocation(int numOfLocs) async {
    print("generateRandomLocation");
    int radius = 16000; //10 miles in meters
    List<Map<String, dynamic>> locations = [
      {"latitude": 32.7157380, "longitude": -117.1610838}, //San Diego
      {"latitude": 39.1031182, "longitude": -84.5120196}, //Cincinnati
      {"latitude": 39.9611755, "longitude": -82.9987942}, //Columbus
      {"latitude": 39.5069974, "longitude": -84.7452310}, //Oxford
      {"latitude": 39.2903848, "longitude": -76.6121893}, //Baltimore
      {"latitude": 39.9525839, "longitude": -75.1652215}, //Philadelphia
      {"latitude": 30.2671530, "longitude": -97.7430608}, //Austin
      {"latitude": 40.7127753, "longitude": -74.0059728}, //New York
      {"latitude": 45.5152320, "longitude": -122.6783853}, //Portland
      {"latitude": 47.6062095, "longitude": -122.3320708}, //Seattle
    ];
    //create random locations near cities
    for (var location in locations) {
      double numOfLocationsToAdd = numOfLocs / locations.length;
      int i = 0;
      while (i < numOfLocationsToAdd) {
        print("in for loop");
        Map<String, dynamic> randLatLon = GeoLocationCommand()
            .getRandomPosition(
                location['latitude'], location['longitude'], radius);
        print(
            "Latitude: ${randLatLon['latitude']} Longitude: ${randLatLon['longitude']}");
        Placemark randPlace = await GeoLocationCommand()
            .getPlacemark(randLatLon['latitude'], randLatLon['longitude']);
        print("randPlace: ");
        print(randPlace);
        i += 1;
        //create location
        LocationModel.Location location = LocationModel.Location(latitude:randLatLon['latitude'], longitude: randLatLon['longitude']);
      }
    }

    Map<String, dynamic> location = {
      "name": "Location " + Random().nextInt(100).toString(),
      "secondaryName":
          "Second Location Name " + Random().nextInt(100).toString(),
      "address": "Location " + Random().nextInt(100).toString(),
      "surface": "Location " + Random().nextInt(100).toString(),
      "images": "Location " + Random().nextInt(100).toString(),
      "fieldSize": "Location " + Random().nextInt(100).toString(),
      "private": Random().nextInt(100) % 2 == 0,
    };
    return location;
  }
}
