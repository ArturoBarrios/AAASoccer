import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:soccermadeeasy/models/componentModels/coordinates.dart';
import '../../commands/location_command.dart';

class LocationSearchBar extends StatefulWidget {
  final bool readonly;
  final String initialValue;
  final Function(Coordinates coordinates, String address)? onCoordinatesChange;

  const LocationSearchBar({
    Key? key,
    this.onCoordinatesChange,
    this.readonly = false,
    this.initialValue = '',
  }) : super(key: key);

  @override
  State<LocationSearchBar> createState() => _LocationSearchBar();
}

class _LocationSearchBar extends State<LocationSearchBar> {
  Coordinates coordinates = Coordinates(latitude: 0, longitude: 0);
  String address = "";
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
    Map<String, dynamic> placeApiAutocompleteresp =
        await LocationCommand().place_api_autocomplete(value);
    print("place_api_autocompleteResp: $placeApiAutocompleteresp");
    List<dynamic> predictionObjects = placeApiAutocompleteresp["data"];

    setState(() {
      addressPredictions = predictionObjects;
      print("predictions: $addressPredictions");
    });
  }

  void chooseAddress(dynamic location) async {
    print("chooseAddress");
    locationController.text = location['description'];
    address = location['description'];
    List<Location> locations =
        await locationFromAddress(location['description']);

    if (locations.isNotEmpty) {
      Location addressToChoose = locations.first;
      print("addressToChoose: $addressToChoose");
      coordinates = Coordinates(
        latitude: addressToChoose.latitude,
        longitude: addressToChoose.longitude,
      );
      print("coordinates: $coordinates");
    } else {
      print('No Locations found!');
    }
    widget.onCoordinatesChange?.call(coordinates, address);
    addressPredictions.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: locationController,
          decoration: const InputDecoration(
            hintText: 'Location',
            labelText: 'Location',
            border: InputBorder.none,
            filled: true,
          ),
          onChanged: (value) async => {placesApiAutoComplete(value)},
          enabled: !widget.readonly,
        ),
        SizedBox(
          height: 200,
          child: Expanded(
              child: ListView.builder(
            itemCount: addressPredictions.length,
            itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  onTap: () {
                    chooseAddress(addressPredictions[index]);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          addressPredictions[index]["description"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18.0,
                            fontFamily: 'supermarket',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
        ),
      ],
    );
  }
}
