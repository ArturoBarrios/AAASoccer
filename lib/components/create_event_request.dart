import 'package:flutter/material.dart';

class CreateEventRequest extends StatefulWidget {
  ValueNotifier<bool> withRequest;

  CreateEventRequest({bool withRequest = false})
      : withRequest = ValueNotifier(withRequest);

  @override
  _CreateEventRequest createState() => _CreateEventRequest();
}

class _CreateEventRequest extends State<CreateEventRequest> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.withRequest,
      builder: (context, bool value, _) {
        return Container(
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Join With Request?"),
                Checkbox(
                  
                  value: value,
                  onChanged: (bool? newValue) {
                    widget.withRequest.value = newValue ?? false;
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
