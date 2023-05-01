import 'package:flutter/material.dart';

class AnimatedDialog extends StatefulWidget {
  final List<String> items;
  final bool singleSelect;
  final bool secondaryItems;

  AnimatedDialog({
    required this.items,
    this.singleSelect = true,
    this.secondaryItems = false,
  });

  @override
  _AnimatedDialogState createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog> {
  List<bool> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _selectedItems = List.filled(widget.items.length, false);
  }

  void _handleItemPressed(int index) {
    setState(() {
      if (widget.singleSelect) {
        _selectedItems = List.filled(widget.items.length, false);
        _selectedItems[index] = true;
      } else {
        _selectedItems[index] = !_selectedItems[index];
      }
    });

    if (widget.secondaryItems) {
      _handleSecondaryItemPressed(index);
    }
  }

  void _handleSecondaryItemPressed(int index) {
    print('Button $index pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Text(
              'Select Items',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(thickness: 1.0),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.items[index]),
                  leading: widget.singleSelect
                      ? Radio(
                          value: true,
                          groupValue: _selectedItems[index],
                          onChanged: (value) {
                            _handleItemPressed(index);
                          },
                        )
                      : Checkbox(
                          value: _selectedItems[index],
                          onChanged: (value) {
                            _handleItemPressed(index);
                          },
                        ),
                  trailing: widget.secondaryItems
                      ? ElevatedButton(
                          onPressed: () {
                            _handleSecondaryItemPressed(index);
                          },
                          child: Text('Secondary'),
                        )
                      : null,
                  onTap: () {
                    _handleItemPressed(index);
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context, _selectedItems);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
