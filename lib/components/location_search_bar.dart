import 'dart:ui';

import 'package:flutter/material.dart';
import '../../commands/location_command.dart';

// // // // // // // // // // // // // // //
class LocationSearchBar extends StatefulWidget {
  const LocationSearchBar(
    {Key? key, required this.locationController })
    : super(key: key);

    final TextEditingController locationController;    

  @override
  _LocationSearchBar createState() => _LocationSearchBar();

  
}

class _LocationSearchBar extends State<LocationSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
          controller: widget.locationController,
          decoration: new InputDecoration.collapsed(hintText: 'Location'),
          // onTap: () async {
          //   showSearch(
          //     context: context,
          //     delegate: AddressSearch(),
          //   );
          // },
          onChanged: (value) async => {
            await LocationCommand().place_api_autocomplete(value),
          });
}
}

