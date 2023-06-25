import 'package:flutter/material.dart';

class AnimatedDialog extends StatefulWidget {
  AnimatedDialog({
    Key? key, 
    required this.details,
    required this.items, 
    required this.singleSelect, 
    required this.secondaryItems,
    required this.goToFunctions,    
  }) : super(key: key);

  final dynamic details;  
  final List<dynamic> items;
  final bool singleSelect;    
  final List<dynamic> secondaryItems;  
  final List <Function> goToFunctions;

  @override
  _AnimatedDialogState createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog> {
  List<dynamic> _selectedItems = [];  
  Map<int,dynamic> resultItems = {};

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
  }

  void goTo(int functionIndex, dynamic object){
    widget.goToFunctions[functionIndex](object);
  }

  void addSecondaryItems(int index, Map<int,dynamic> secondaryChosenItems){
    resultItems[index] = secondaryChosenItems;
  }

  void processItemsSelected(){
    if(widget.secondaryItems.length == 0){
      for(int i = 0; i < _selectedItems.length; i++){
        if(_selectedItems[i]){
          resultItems[i] = {};
        }
      }
    }
    Navigator.pop(context, resultItems);
  }

  Widget _handleSecondaryItemPressed(int index) {
    return AnimatedDialog(details: widget.details, items: widget.secondaryItems, singleSelect: false, secondaryItems: [], goToFunctions: [], );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  ),
  child: Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.details['title'],
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.deepOrange),
        ),
        Divider(thickness: 2.0, color: Colors.deepOrange),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.items[index].toString(), style: TextStyle(fontSize: 18.0)),
                leading: widget.singleSelect
                    ? Radio(
                        value: true,
                        groupValue: _selectedItems[index],
                        onChanged: (value) async {
                          _handleItemPressed(index);
                          // Rest of your code
                        },
                        activeColor: Colors.deepOrange,
                      )
                    : Checkbox(
                        value: _selectedItems[index],
                        onChanged: (value) async {
                          _handleItemPressed(index);
                          // Rest of your code
                        },
                        activeColor: Colors.deepOrange,
                      ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.secondaryItems.length > 0
                        ? ElevatedButton(
                            onPressed: () async {
                              Widget secondaryDialog = _handleSecondaryItemPressed(index);
                            },
                            child: Text('Secondary'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange,
                            ),
                          )
                        : Container(),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        print("Right arrow button pressed");
                        goTo(0, widget.items[index]);
                      },
                    ),
                  ],
                ),
                onTap: () async {
                  _handleItemPressed(index);
                  // Rest of your code
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
              child: Text('CANCEL', style: TextStyle(color: Colors.deepOrange)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 8.0),
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                processItemsSelected();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ],
    ),
  ),
);

  }
}
