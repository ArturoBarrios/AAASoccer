import 'package:flutter/material.dart';
import 'package:soccermadeeasy/styles/colors.dart';
import 'dart:math' as math;

import '../../styles/asset_constants.dart';

enum PrefferedFoot { left, right }

class FootSelection extends StatelessWidget {
  const FootSelection({Key? key, this.onTapPrefferedFoot, this.selectedFoot})
      : super(key: key);

  final Function(PrefferedFoot)? onTapPrefferedFoot;
  final PrefferedFoot? selectedFoot;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onTapPrefferedFoot?.call(PrefferedFoot.left),
            child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        selectedFoot == PrefferedFoot.left
                            ? AppColors.orangeColorShade500
                            : Colors.transparent,
                        BlendMode.color),
                    child: Image.asset(AssetConstants.player))),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => onTapPrefferedFoot?.call(PrefferedFoot.right),
            child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    selectedFoot == PrefferedFoot.right
                        ? AppColors.orangeColorShade500
                        : Colors.transparent,
                    BlendMode.color),
                child: Image.asset(AssetConstants.player)),
          ),
        ),
      ],
    );
  }
}
