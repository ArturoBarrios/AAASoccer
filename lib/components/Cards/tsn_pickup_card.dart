import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../styles/colors.dart';
import '../../styles/font_sizes.dart';

class TSNPickupCard extends StatelessWidget {
  final List<Widget> topLeft;
  final List<Widget> topRight;
  final List<Widget> bottomLeft;
  final List<Widget> bottomRight;
  final Color backgroundColor;
  final Svg? svgImage;
  final double? width;
  final double? height;

  TSNPickupCard({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
    required this.backgroundColor,
    this.svgImage,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: backgroundColor,
      child: Container(
        width: width,
        height: screenHeight*.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            // ... Image part

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("07/26/1997",
                                    style: TextStyle(
                                      color: AppColors.tsnWhite,                                      
                                      fontSize: FontSizes.xxs(context),
                                    )),
                                // Text("TL 1b"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: AppColors.tsnGreen),
                                Text(
                                  "Philadelphia, PA",
                               style: TextStyle(
                                      color: AppColors.tsnGrey,                                      
                                      fontSize: FontSizes.xxs(context),
                                    )),
                                // Text("TL 2b"),
                              ],
                            ),
                          ],
                        ),  
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                // Text("TR 1a"),
                                // Text("TR 1b"),
                              ],
                            ),
                            Row(
                              children: [
                                Text("TR 2a"),
                                Text("TR 2b"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("BL 1a"),
                                Text("BL 1b"),
                              ],
                            ),
                            Row(
                              children: [
                                Text("BL 2a"),
                                Text("BL 2b"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text("BR 1a"),
                                Text("BR 1b"),
                              ],
                            ),
                            Row(
                              children: [
                                Text("BR 2a"),
                                Text("BR 2b"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
