import 'package:flutter/material.dart';
import 'dart:async';

import '../../components/images/svg_image.dart';

class SoccerLoadingIndicator extends StatefulWidget {
  const SoccerLoadingIndicator({Key? key}) : super(key: key);

  @override
  State<SoccerLoadingIndicator> createState() => _SoccerLoadingIndicatorState();
}

class _SoccerLoadingIndicatorState extends State<SoccerLoadingIndicator> {
  late Timer _timer;
  int _currentStep = 0;

  static const loadingParticles = [
    'lib/assets/svgs/loading_particles/particles_1.svg',
    'lib/assets/svgs/loading_particles/particles_2.svg',
    'lib/assets/svgs/loading_particles/particles_3.svg',
    'lib/assets/svgs/loading_particles/particles_4.svg',
    'lib/assets/svgs/loading_particles/particles_5.svg',
    'lib/assets/svgs/loading_particles/particles_6.svg',
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
        const Duration(milliseconds: 100), (Timer t) => _updateStep());
  }

  void _updateStep() {
    if (_currentStep >= 5) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;

        setState(() {
          _currentStep = 0;
        });
      });
    } else {
      if (!mounted) return;

      setState(() {
        _currentStep++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentStep,
      children: List.generate(loadingParticles.length, (index) {
        return SvgImage(
          svgPath: loadingParticles[index],
          height: 40,
          color: const Color.fromARGB(250, 108, 182, 50),
        );
      }),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
