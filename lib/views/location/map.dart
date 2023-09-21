import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../commands/location_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/headers.dart';
import '../../components/my_map_page.dart';


class LocationsMap extends StatefulWidget {
  const LocationsMap(
      {Key? key})
      : super(key: key);


  @override
  _LocationsMapState createState() => _LocationsMapState();
}

class _LocationsMapState extends State<LocationsMap> {
  bool _isLoading = true;
  late Position location;  


  Future<void> loadInitialData() async{
    print("loadInitialData");
    location = await LocationCommand().getCurrentPosition();

    setState(() {
      _isLoading = false;
    });
    
  }

  @override
  void initState() {
    print("views/locations/create.dart init state");
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Headers()
          .getBackHeader(context, "Locations"),
      body: _isLoading
            ? Container(
                height: double.infinity,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child:
                      // BottomNav()//for times when user deleted in cognito but still signed into app
                      LoadingScreen(
                          currentDotColor: Colors.white,
                          defaultDotColor: Colors.black,
                          numDots: 10),
                ),
              )
            : Container(
              
            )
    );
  }
}
