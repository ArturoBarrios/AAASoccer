import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:soccermadeeasy/models/coordinates.dart';
import '../../commands/location_command.dart';

class LocationSearchBar extends StatefulWidget {
  Coordinates coordinates = Coordinates(0, 0);
  String address = "";
  final locationController = TextEditingController();
  final bool readonly;
  final String initialValue;

  LocationSearchBar({this.readonly = false, this.initialValue = ''});

  @override
  _LocationSearchBar createState() => _LocationSearchBar();
}

class _LocationSearchBar extends State<LocationSearchBar> {
  final locationController = TextEditingController();
  List<dynamic> addressPredictions = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialValue.isNotEmpty) {
      placesApiAutoComplete(widget.initialValue);
    }
  }

  Future<void> placesApiAutoComplete(String value) async {
    Map<String, dynamic> place_api_autocompleteResp =
        await LocationCommand().place_api_autocomplete(value);
    print(
        "place_api_autocompleteResp: " + place_api_autocompleteResp.toString());
    List<dynamic> predictionObjects = place_api_autocompleteResp["data"];

    setState(() {
      this.addressPredictions = predictionObjects;
      print("predictions: " + this.addressPredictions.toString());
    });
  }

  void chooseAddress(dynamic location) async {
    print("chooseAddress");
    locationController.text = location['description'];
    widget.address = location['description'];
    List<Location> addresses =
        await locationFromAddress(location['description']);
    Location addressToChoose = addresses.first;

    print("addressToChoose: $addressToChoose");
    widget.coordinates =
        Coordinates(addressToChoose.latitude, addressToChoose.longitude);
    print("coordinates: ${widget.coordinates}");
    widget.coordinates.latitude;
    widget.coordinates.longitude;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: locationController,
          decoration: InputDecoration.collapsed(hintText: ''),
          onChanged: (value) async => {placesApiAutoComplete(value)},
          enabled: !widget.readonly,
        ),
        SizedBox(
          height: 200,
          child: Expanded(
            child: addressPredictions.isNotEmpty
                ? ListView.builder(
                    itemCount: addressPredictions.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            chooseAddress(addressPredictions[index]);
                          },
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    addressPredictions[index]["description"]!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18.0,
                                      fontFamily: 'supermarket',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text('Add Address'),
                  ),
          ),
        ),
      ],
    );
  }
}
