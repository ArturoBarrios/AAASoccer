import 'package:flutter/material.dart';

class CreateEventPayment extends StatefulWidget {
  ValueNotifier<bool> withPayment;

  CreateEventPayment({bool withPayment = false})
      : withPayment = ValueNotifier(withPayment);

  @override
  _CreateEventPayment createState() => _CreateEventPayment();
}

class _CreateEventPayment extends State<CreateEventPayment> {
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
                Text("Join With Payment?"),
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
