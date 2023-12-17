import 'package:flutter/material.dart';

import 'Loading/loading_screen.dart';

class LoadingCircular extends StatelessWidget {
  const LoadingCircular({Key? key, this.height}) : super(key: key);

  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Align(
        alignment: Alignment.center,
        child: LoadingScreen(
            currentDotColor: Colors.white,
            defaultDotColor: Colors.black,
            numDots: 10),
      ),
    );
  }
}
