import 'dart:ffi';
import 'dart:math';

import '../../commands/location_command.dart';
import '../../commands/geolocation_command.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../models/Location.dart' as LocationModel;
import '../../models/SurfaceType.dart';
import '../../models/FieldPlayerOccupancySize.dart';

// import '../../models/Location.dart';

class LocationSeeder {
  int radius = 16000; //10 miles in meters
  List<Map<String, dynamic>> locations = [    
    // {"latitude": 32.7157380, "longitude": -117.1610838}, //San Diego
    // {"latitude": 39.1031182, "longitude": -84.5120196}, //Cincinnati
    // {"latitude": 39.9611755, "longitude": -82.9987942}, //Columbus
    // {"latitude": 39.5069974, "longitude": -84.7452310}, //Oxford
    // {"latitude": 39.2903848, "longitude": -76.6121893}, //Baltimore
    {"latitude": 39.9525839, "longitude": -75.1652215}, //Philadelphia
  ];
  List<LocationModel.Location> randomLocations = [];

  Future<Map<String, dynamic>> createRandomUserLocations(
      Map<String, dynamic> data) async {
    Map<String, dynamic> createRandomUserLocationsResponse = {
      "success": false,
      "message": "Something went wrong with creating random user locations",
      "data": Map<String, dynamic>(),
    };
    print("LocationSeeder::run();n=${data['numberOfUserLocations']}");
    for (var location in locations) {
      for (int i = 0; i < data['numberOfUserLocations']/locations.length; i++) {
        print("i: " + i.toString());
        Map<String, dynamic> locationData =
            await generateRandomLocation(location);
          print("location data: ${locationData}");
        // Map<String, dynamic> createLocationInput = locationData["data"]["randomLocation"];
        Map<String, dynamic>createLocationInput = getRandomLocationData();
        createLocationInput["latitude"] = locationData["data"]["randomLocation"]["latitude"];
        createLocationInput["longitude"] = locationData["data"]["randomLocation"]["longitude"];
        print("createLocationInput: ${createLocationInput}");
        Map<String, dynamic> createLocationResp =
            await LocationCommand().createLocation(createLocationInput);
        if (createLocationResp['success']) {
          print("createLocationResp: ");
          print(createLocationResp);
          randomLocations.add(createLocationResp["data"]["randomLocation"]);
        }
      }
    }
    createRandomUserLocationsResponse["success"] = true;
    createRandomUserLocationsResponse["data"]["randomLocations"] =
        randomLocations;

    return createRandomUserLocationsResponse;
  }

  Map<String, dynamic> getRandomLocationData(){
    Map<String, dynamic>randomLocationData = {};
    var rng = Random();
    int randomLocationNumber = rng.nextInt(1000000000);
    List<SurfaceType> surfaceTypes = [
      SurfaceType.TURFPOOR,
      SurfaceType.TURFOKAY,
      SurfaceType.TURFGOOD,
      SurfaceType.TURFEXCELLENT,
      SurfaceType.GRASSPOOR,
      SurfaceType.GRASSOKAY,
      SurfaceType.GRASSGOOD,
      SurfaceType.HARDFLOOR,
      SurfaceType.SAND,
      SurfaceType.NAILS,
      SurfaceType.QUICKSAND,
    ];

    List<FieldPlayerOccupancySize> fieldPlayerOccupancySizes = [
      FieldPlayerOccupancySize.SMALL,
      FieldPlayerOccupancySize.MEDIUM,
      FieldPlayerOccupancySize.FULLSIZE,
    ];


    
    randomLocationData["name"] = "Random Location"+randomLocationNumber.toString();
    randomLocationData["secondaryName"] = "Secondary Name"+randomLocationNumber.toString();
    randomLocationData["address"] = "Address"+randomLocationNumber.toString();
    randomLocationData["private"] = rng.nextInt(2) == 1 ? true : false;
    randomLocationData["surface"] = surfaceTypes[rng.nextInt(surfaceTypes.length)];
    randomLocationData["fieldSize"] = fieldPlayerOccupancySizes[rng.nextInt(fieldPlayerOccupancySizes.length)];

    return randomLocationData;

  }

  Future<Map<String, dynamic>> generateRandomLocation(
      Map<String, dynamic> locationData) async {
    print("generateRandomLocation");
    Map<String, dynamic> generateRandomLocation = {
      "success": false,
      "message": "Hooray",
      "data": Map<String, dynamic>(),
    };

    try{
    Map<String, dynamic> randLatLon = GeoLocationCommand().getRandomPosition(
        locationData['latitude'], locationData['longitude'], radius);
    print(
        "Latitude: ${randLatLon['latitude']} Longitude: ${randLatLon['longitude']}");
    // Map<String, dynamic> randPlaceRes = await GeoLocationCommand()
    //     .getPlacemark(randLatLon['latitude'], randLatLon['longitude']);

    // print("randPlaceRes: ");
    // print(randPlaceRes);
    // if (randPlaceRes["success"]) {
      Map<String, dynamic> randomLocation = {"latitude": randLatLon['latitude'], "longitude": randLatLon['longitude']};
      generateRandomLocation["data"]["randomLocation"] = randomLocation;
      generateRandomLocation["success"] = true;
    // }
    }catch(e){
      print("Error: " + e.toString());
    }

    return generateRandomLocation;
  }
}
