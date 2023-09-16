import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({
    Key? key,
    this.onTap,
    this.isActive = false,
  }) : super(key: key);

  /// On tapping the switch button.
  final void Function(bool)? onTap;

  /// If switch button is active value will be true.
  final bool isActive;

  @override
  Widget build(final BuildContext context) => CupertinoSwitch(
        value: isActive,
        onChanged: onTap,
        trackColor: Colors.blueGrey,
        activeColor: isActive ? Colors.blueGrey : Colors.blueGrey,
        thumbColor: isActive ? Colors.blue : Colors.grey,
      );
}
