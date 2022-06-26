import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import '../services/geolocation_services.dart';

class GeoLocationCommand extends BaseCommand {
  
  void getLocation() async {
    await GeoLocationServices().getPosition();
    
  }

}