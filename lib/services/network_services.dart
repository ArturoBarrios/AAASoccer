import 'package:location/location.dart';
import 'package:soccermadeeasy/commands/base_command.dart';



class NetworkServices {

  Future<void>enableLocationService()async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    Location location = new Location();
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    print("_serviceEnabled: "+_serviceEnabled.toString());
    print("_serviceEnabled.runType: "+_serviceEnabled.runtimeType.toString());
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) {
        print("location.requestService() worked");
    //this sometimes works and sometimes doesn't. Figure it out!
    _locationData = await location.getLocation();
    print("locationData: "+_locationData.latitude.toString() + _locationData.longitude.toString());
        
      }
    }

    _permissionGranted = await location.hasPermission();
  print("permissionGranted: "+_permissionGranted.toString());
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      
    }
  }   
  }

  


  

  


}
