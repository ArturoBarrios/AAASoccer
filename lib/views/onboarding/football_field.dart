import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import 'player_position_circle.dart';

class FootballField extends StatelessWidget {
  const FootballField({Key? key, this.onTapPosition, this.selectedPosition})
      : super(key: key);

  final Function(int)? onTapPosition;
  final int? selectedPosition;

  static const Map<int, List<double>> playerCoordinates = {
    1: [0.46, 0.02], // GK
    2: [0.1, 0.2], // LB
    3: [0.3, 0.15], // LCB
    4: [0.6, 0.15], // RCB
    5: [0.8, 0.2], // RB
    6: [0.1, 0.6], // LW
    7: [0.30, 0.5], // LCM
    8: [0.6, 0.5], // RCM
    9: [0.8, 0.6], // RW
    10: [0.3, 0.8], // LS
    11: [0.7, 0.8], // RS
  };

  @override
  Widget build(BuildContext context) {
    List<double>? spotlightPosition;

    // If a position is selected, get its (x, y) position from the map
    if (selectedPosition != null) {
      spotlightPosition = playerCoordinates[selectedPosition];
    }

    return AspectRatio(
      aspectRatio: 1 / 2,
      child: CustomPaint(
        painter: FieldPainter(),
        foregroundPainter: spotlightPosition != null
            ? SpotlightPainter(spotlightPosition[0], spotlightPosition[1])
            : null,
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return Stack(
              children: [
                playerPosition(constraints, 0.46, 0.02, 'GK', 1), // Goalkeeper

                playerPosition(constraints, 0.1, 0.2, 'LB', 2), // Left Back
                playerPosition(
                    constraints, 0.3, 0.15, 'LCB', 3), // Left Center Back
                playerPosition(
                    constraints, 0.6, 0.15, 'RCB', 4), // Right Center Back
                playerPosition(constraints, 0.8, 0.2, 'RB', 5), // Right Back

                playerPosition(constraints, 0.1, 0.6, 'LW', 6), // Left Wing
                playerPosition(
                    constraints, 0.30, 0.5, 'LCM', 7), // Left Central Midfield
                playerPosition(
                    constraints, 0.6, 0.5, 'RCM', 8), // Right Central Midfield
                playerPosition(constraints, 0.8, 0.6, 'RW', 9), // Right Wing

                playerPosition(constraints, 0.3, 0.8, 'LS', 10), // Left Striker
                playerPosition(
                    constraints, 0.7, 0.8, 'RS', 11), // Right Striker
              ],
            );
          },
        ),
      ),
    );
  }

  Widget playerPosition(BoxConstraints constraints, double x, double y,
      String position, int index) {
    return PlayerPositionCircle(
      constraints: constraints,
      x: x,
      y: y,
      positionName: position,
      isSelected: selectedPosition == index,
      onTap: () => onTapPosition?.call(index),
    );
  }
}

class SpotlightPainter extends CustomPainter {
  final double x;
  final double y;

  SpotlightPainter(this.x, this.y);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;

    final Gradient gradient = RadialGradient(
      center: Alignment(x * 2 - 0.9, y * 2 - 0.9),
      radius: 0.2,
      colors: const [Colors.transparent, Colors.black54],
      stops: const [0.0, 1.0],
    );

    canvas.drawRect(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class FieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.tsnGreen
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final goalAreaWidth = size.width * 0.2;
    final penaltyAreaWidth = size.width * 0.5;

    // Draw field background
    canvas.drawRect(const Offset(0, 0) & size, paint);

    // Draw middle line
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(size.width, size.height / 2), linePaint);

    // Draw center circle
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 10, linePaint);

    // Top goal area
    canvas.drawRect(
      Offset((size.width - goalAreaWidth) / 2, 0) &
          Size(goalAreaWidth, size.height * 0.1),
      linePaint,
    );

    // // Bottom goal area
    // canvas.drawRect(
    //   Offset((size.width - goalAreaWidth) / 2, size.height) &
    //       Size(goalAreaWidth, -size.height * 0.1),
    //   linePaint,
    // );

    // Top penalty area
    canvas.drawRect(
      Offset((size.width - penaltyAreaWidth) / 2, 0) &
          Size(penaltyAreaWidth, size.height * 0.15),
      linePaint,
    );

    // // Bottom penalty area
    // canvas.drawRect(
    //   Offset((size.width - penaltyAreaWidth) / 2, size.height) &
    //       Size(penaltyAreaWidth, -size.height * 0.15),
    //   linePaint,
    // );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
