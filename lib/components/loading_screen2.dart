import 'package:flutter/material.dart';

import 'Loading/loading_screen.dart';

class LoadingScreen2 extends StatelessWidget {
  const LoadingScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LoadingScreen(
            currentDotColor: Colors.white,
            defaultDotColor: Colors.black,
            numDots: 10),
      ),
    );
  }
}
