import 'package:flutter/material.dart';

import '../components/logo_text.dart';
import '../styles/colors.dart';
import '../styles/font_sizes.dart';
import '../svg_widgets.dart';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1000),
      vsync: this,
    )..repeat();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {   

// ...
      // Full-screen rotated image
      // Positioned.fill(
      //   child: Transform.rotate(
      //     angle: pi / 2,
      //     child: Transform.scale(
      //       scale: max(
      //         MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
      //         MediaQuery.of(context).size.height / MediaQuery.of(context).size.width,
      //       ),
      //       child: 
      //       Opacity(
      //           opacity: 0.3,
      //           child:
      //         Image.asset(
      //           'lib/assets/images/Sketch-1.png',
      //           fit: BoxFit.contain,
      //           color: AppColors.tsnAlmostBlack,
                
      //         ),

      //       )
      //     ),
      //   ),
      // ),

return Scaffold(
  backgroundColor: AppColors.tsnBlack,
  body: Stack(
    fit: StackFit.expand,    
    children: [
      // Centered logo
      Center(
        child: LogoTextWidget(
          textColor: AppColors.tsnWhite,
          fontSize: FontSizes.lg(context),
          width: 60.0,
          height: 60.0,
          backgroundColor: Colors.transparent,
          hasAnimation: true,
          
        ),
      ),
    ],
  ),
);

  }
}
