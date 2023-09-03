import 'package:flutter/material.dart';
import 'package:soccermadeeasy/styles/colors.dart';

class PlayerPositionCircle extends StatelessWidget {
  const PlayerPositionCircle({
    Key? key,
    this.constraints,
    this.x,
    this.y,
    this.positionName,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  final BoxConstraints? constraints;
  final double? x;
  final double? y;
  final String? positionName;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (constraints?.maxWidth ?? 0) * (x ?? 0),
      top: (constraints?.maxHeight ?? 0) * (y ?? 0),
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          backgroundColor:
              isSelected ? AppColors.orangeColorShade500 : AppColors.whiteColor,
          child: Text(positionName ?? ''),
        ),
      ),
    );
  }
}
