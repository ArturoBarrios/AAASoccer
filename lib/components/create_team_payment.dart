import 'package:flutter/material.dart';

class CreateTeamPayment extends StatefulWidget {
  ValueNotifier<bool> withPayment;

  CreateTeamPayment({bool withPayment = false})
      : withPayment = ValueNotifier(withPayment);

  @override
  _CreateTeamPayment createState() => _CreateTeamPayment();
}

class _CreateTeamPayment extends State<CreateTeamPayment> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.withPayment,
      builder: (context, bool value, _) {
        return Container(
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Join With Team Payment?"),
                Checkbox(
                  value: value,
                  onChanged: (bool? newValue) {
                    widget.withPayment.value = newValue ?? false;
                  },
                ),
              ],
            ),
          ]),
        );
      },
    );
  }
}
