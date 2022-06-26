import 'dart:math';

import '../../commands/location_command.dart';

// import '../../models/Location.dart';

class LocationSeeder  {

  void run(Map<String, dynamic> data) async {
    print("LocationSeeder::run();n=${data['num_of_locs']}");
    for (int i = 0; i < data['num_of_locs']; i++) {
      print("i: "+i.toString());
      Map<String, dynamic> locationData = await generateRandomLocation();
      LocationCommand().createLocation(locationData);
    }
  }

  Future<Map<String, dynamic>> generateRandomLocation() async {
    Map<String, dynamic> location = {
      "name": "Location " + Random().nextInt(100).toString(),
      "secondaryName": "Second Location Name " + Random().nextInt(100).toString(),
      "address": "Location " + Random().nextInt(100).toString(),
      "surface": "Location " + Random().nextInt(100).toString(),
      "images": "Location " + Random().nextInt(100).toString(),
      "fieldSize": "Location " + Random().nextInt(100).toString(),
      "private": Random().nextInt(100) % 2 == 0,
    };
    return location;
  }

 

  

 

}