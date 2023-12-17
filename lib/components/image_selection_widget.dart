import 'package:flutter/material.dart';
import '../styles/colors.dart';

class ImageSelectionWidget extends StatefulWidget {
  final List<String> selectionList;
  final bool viewMode;
  final Function(List<String>) onSelectionChanged;

  const ImageSelectionWidget({
    Key? key,
    required this.viewMode,
    required this.selectionList,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _ImageSelectionWidgetState createState() => _ImageSelectionWidgetState();
}

class _ImageSelectionWidgetState extends State<ImageSelectionWidget> {
  List<String> selectedAmenities = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 3, // Assuming 3 items per row at max
        childAspectRatio: 1.0,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: widget.selectionList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
      itemBuilder: (context, index) {
        var amenity = widget.selectionList[index];
        bool isSelected = selectedAmenities.contains(amenity);
        return GestureDetector(
          onTap: widget.viewMode ? null : () {
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
