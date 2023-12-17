import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  const SvgImage({
    Key? key,
    this.svgPath,
    this.onTap,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  /// Callback when image tapped.
  final VoidCallback? onTap;

  /// The height of the image.
  final double? height;

  /// The width of the image.
  final double? width;

  /// Image path.
  final String? svgPath;

  /// Color of the image.
  final Color? color;

  @override
  Widget build(final BuildContext context) {
    final localColor = color;

    return svgPath != null
        ? GestureDetector(
            onTap: onTap,
            child: SvgPicture.asset(
              svgPath ?? '',
              height: height,
              colorFilter: localColor == null
                  ? null
                  : ColorFilter.mode(localColor, BlendMode.srcIn),
              width: width,
            ),
          )
        : const SizedBox();
  }
}
