// dart lib/testing/seeding/database_seeder.service.dart
/// This file is at lib/testing/seeding/seed_services.service.dart
import 'dart:convert';
import 'location_seeder.dart';

// import '../../models/Location.dart';

class DatabaseSeeder {
  void run(Map<String, dynamic> data) async {
    LocationSeeder().createRandomUserLocations(data);
  }
}
