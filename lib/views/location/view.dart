import 'package:flutter/material.dart';
import '../../commands/location_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/headers.dart';
import '../../components/location_search_bar.dart';
import '../../components/my_map_page.dart';


class LocationView extends StatefulWidget {
  const LocationView(
      {Key? key, required this.location})
      : super(key: key);

  final dynamic location;  

  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  bool _isLoading = false;
  LocationSearchBar locationSearchBar = new LocationSearchBar();

  void updateAddress(){

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
          .getBackHeader(context, "View Location"),
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
            : ListView(padding: EdgeInsets.all(16), children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.amber[600],
                width: MediaQuery.of(context).size.width -
                    (MediaQuery.of(context).size.width *
                        .1), //10% padding
                height: 200.0,
                child: MyMapPage(
                  latitude: widget.location['data'][0]
                        ['latitude'],
                  longitude: widget.location['data'][0]
                        ['longitude']),
              ),
              locationSearchBar = LocationSearchBar(
                initialValue: widget.location['data'][0]['name']),
            ]),
    );
  }
}
