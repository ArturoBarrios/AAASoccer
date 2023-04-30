import 'package:flutter/material.dart';

class AnimatedDialog extends StatefulWidget {
  final List<String> items;

  AnimatedDialog({required this.items});

  @override
  _AnimatedDialogState createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  List<String> _selectedItems = [];

  void _openSubDialog(String item) async {
    final List<String>? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnimatedDialog(
          items: ['${item}_1', '${item}_2', '${item}_3'],
        );
      },
    );
    if (result != null) {
      setState(() {
        _selectedItems.addAll(result);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: AlertDialog(
        title: Text('Select Items'),
        contentPadding: EdgeInsets.all(16.0),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (String item in widget.items)
                CheckboxListTile(
                  title: Text(item),
                  value: _selectedItems.contains(item),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null && value) {
                        _selectedItems.add(item);
                        _openSubDialog(item);
                      } else {
                        _selectedItems.remove(item);
                      }
                    });
                  },
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('CANCEL'),
            onPressed: () {
              _controller.reverse().then((value) => Navigator.pop(context));
            },
          ),
          TextButton(
            child: Text('OK'),
            onPressed: () {
              _controller.reverse().then((value) {
                Navigator.pop(context, _selectedItems);
              });
            },
          ),
        ],
      ),
    );
  }
}
