// dart lib/testing/seeding/database_seeder.service.dart
/// This file is at lib/testing/seeding/seed_services.service.dart
import 'dart:convert';
import 'location_seeder.dart';
import 'user_seeder.dart';

// import '../../models/Location.dart';

class DatabaseSeeder {
  Map<String, dynamic> data = {
  "numberOfUserLocations": 4,//4500,
  'numberOfUsers': 4,//4500,
  'randomLocations': [],
 };

  void run() async {
    print("run DatabaseSeeder");
      //users
    Map<String, dynamic> createRandomUsersResp = await UserSeeder().createRandomUsers(data);
    

  }
}
