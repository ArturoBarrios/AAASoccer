import 'dart:ui';

import 'package:flutter/material.dart';
import '../../commands/location_command.dart';
import 'package:geocoder/geocoder.dart';
//returns chosen address
// // // // // // // // // // // // // // //
class LocationSearchBar extends StatefulWidget {  
  final Function(String) chooseAddress;
  const LocationSearchBar({Key? key, required this.chooseAddress })
      : super(key: key);

   
  

  @override
  _LocationSearchBar createState() => _LocationSearchBar();


}

class _LocationSearchBar extends State<LocationSearchBar> {
  final locationController = TextEditingController();
  List<dynamic> addressPredictions = [];

  //not necessary now, but feels like a
  //method to process predictions will be
  // List processPredictions(List<dynamic> predictions){
  //   List processedPredictions = [];
  //   predictions.forEach((prediction) {
  //     processedPredictions.add(prediction["description"]);
  //   });

  //   return processedPredictions;
  // }

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
    List<Address> addresses = await Geocoder.local.findAddressesFromQuery(location['description']);
    Address address = addresses.first;
    widget.chooseAddress(location['description']);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(
          controller: locationController,
          decoration: new InputDecoration.collapsed(hintText: 'Location'),
          // onTap: () async {
          //   showSearch(
          //     context: context,
          //     delegate: AddressSearch(),
          //   );
          // },
          onChanged: (value) async => {placesApiAutoComplete(value)}),
      SizedBox(
          height: 200,
          child: Expanded(
              child: addressPredictions.isNotEmpty != 0
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
                                      fontFamily: 'supermarket'),
                                ),
                              ),
                            ],
                          )),
                        ));
                      },
                    )
                  : Center(
                      child: Text('Search'),
                    ))),
    ]);
  }
}
