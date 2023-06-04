import 'package:flutter/material.dart';

class CreateTeamRequest extends StatefulWidget {
  ValueNotifier<bool> withRequest;

  CreateTeamRequest({bool withRequest = false})
      : withRequest = ValueNotifier(withRequest);

  @override
  _CreateTeamRequest createState() => _CreateTeamRequest();
}

class _CreateTeamRequest extends State<CreateTeamRequest> {
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
