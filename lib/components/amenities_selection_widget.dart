import 'package:flutter/material.dart';

import '../models/enums/AmenityType.dart';
import '../styles/colors.dart';

class AmenitiesSelectionWidget extends StatefulWidget {
  final List<AmenityType> amenities;
  final Function(List<AmenityType>) onSelectionChanged;

  const AmenitiesSelectionWidget({
    Key? key,
    required this.amenities,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _AmenitiesSelectionWidgetState createState() => _AmenitiesSelectionWidgetState();
}

class _AmenitiesSelectionWidgetState extends State<AmenitiesSelectionWidget> {
  List<AmenityType> selectedAmenities = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 3, // Assuming 3 items per row at max
        childAspectRatio: 1.0,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: widget.amenities.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
      itemBuilder: (context, index) {
        var amenity = widget.amenities[index];
        bool isSelected = selectedAmenities.contains(amenity);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedAmenities.remove(amenity);
              } else {
                selectedAmenities.add(amenity);
              }
              widget.onSelectionChanged(selectedAmenities);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.tsnGreen : null, // Change color when selected
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.ac_unit), // Replace with desired icon
                Text(amenity.toString().split('.').last),
              ],
            ),
          ),
        );
      },
    );
  }
}
