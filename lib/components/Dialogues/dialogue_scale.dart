import 'package:flutter/material.dart';


class DialogueScale extends StatefulWidget {
  const DialogueScale({Key? key}) : super(key: key);

  @override
  State<DialogueScale> createState() => _DialogueScale();
}

class _DialogueScale extends State<DialogueScale> {

    Widget _dialog(BuildContext context) {
        return AlertDialog(
          title: const Text("Dialog title"),
          content: const Text("Simple Dialog content"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Okay"))
          ],
        );
      }
    void _scaleDialog() {
        showGeneralDialog(
          context: context,
          pageBuilder: (ctx, a1, a2) {
            return Container();
          },
          transitionBuilder: (ctx, a1, a2, child) {
            var curve = Curves.easeInOut.transform(a1.value);
            return Transform.scale(
              scale: curve,
              child: _dialog(ctx),
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
      }
Widget build(BuildContext context) {
  return _dialog(context);

}

    
    

  }



