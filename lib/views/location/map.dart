import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../commands/event_command.dart';
import '../../commands/location_command.dart';
import '../../commands/team_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/headers.dart';
import '../../components/my_map_page.dart';
import '../../models/appModels/Location.dart';
import '../../models/enums/LocationType.dart';

class LocationsMap extends StatefulWidget {
  const LocationsMap({Key? key}) : super(key: key);

  @override
  _LocationsMapState createState() => _LocationsMapState();
}

class _LocationsMapState extends State<LocationsMap> {
  bool _isLoading = true;
  late Position initialLocation;
  LatLng initialLatLng = LatLng(0, 0);
  List<LatLng> eventLatLngs = [];
  List<LatLng> teamLatLngs = [];
  List<Location> locations = [];

  BitmapDescriptor locationIcon = BitmapDescriptor.defaultMarker;

  Future<void> addCustomIcons() async {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/Location_marker.png")
        .then(
      (icon) {
        setState(() {
          locationIcon = icon;
        });
      },
    );
  }

  Future<void> loadLocations() async {
    // Map<String, dynamic> getLocationsNearMeResp =
    //     await LocationCommand().getLocationsNearMe(LocationType.FIELDLOCATION);
    // if (getLocationsNearMeResp["success"]) {
    //   locations = getLocationsNearMeResp["data"];
    //   locations.forEach((location) {
    //     eventLatLngs.add(LatLng(location.latitude!, location.longitude!));
    //   });
    // }
  }

  Future<void> loadInitialData() async {
    print("loadInitialData");
    initialLocation = await LocationCommand().getCurrentPosition();
    initialLatLng = LatLng(initialLocation.latitude, initialLocation.longitude);

    setState(() {
      _isLoading = false;
    });
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 300, // You can adjust this height
            child: Center(
              child: Text("Hello, I'm a bottom sheet"),
            ),
          );
        });
  }

  @override
  void initState() {
    print("views/locations/create.dart init state");
    super.initState();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const Headers().getBackHeader(context, "Locations"),
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
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.422131, -122.084801), //initialLatLng,
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("marker1"),
                  position: const LatLng(37.422131, -122.084801),
                  icon: locationIcon,                  
                  draggable: true,
                  onDragEnd: (value) {
                    // value is the new position
                  },
                  onTap:() {
                     _showBottomSheet();
                  },
                ),
                Marker(
                  markerId: const MarkerId("marker2"),
                  position: const LatLng(37.415768808487435, -122.08440050482749),
                  onTap:() {
                     _showBottomSheet();
                  },
                ),
              },
              // ToDO: add markers
            ),
    );
  }
}
