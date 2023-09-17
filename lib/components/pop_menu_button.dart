import 'package:flutter/material.dart';

class PopMenuButton extends StatelessWidget {
  const PopMenuButton({
    Key? key,
    this.optionList,
    this.onTapOption,
  }) : super(key: key);

  final List<String>? optionList;
  final Function(String?)? onTapOption;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onTapOption,
      offset: const Offset(-15, 40),
      itemBuilder: (BuildContext context) {
        return optionList?.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList() ??
            [];
      },
    );
  }
}
