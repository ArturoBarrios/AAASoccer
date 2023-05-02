import 'package:flutter/material.dart';

class AnimatedDialog extends StatefulWidget {
 

AnimatedDialog(
      {Key? key, required this.items, required this.singleSelect, required this.secondaryItems})
      : super(key: key);
  
    final List<dynamic> items;
    final bool singleSelect;    
    final List<dynamic> secondaryItems;
  

  @override
  _AnimatedDialogState createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog> {
  List<dynamic> _selectedItems = [];  
  //[[]]
  Map<int,dynamic> resultItems = {};

  @override
  void initState() {
    super.initState();
    _selectedItems = List.filled(widget.items.length, false);
  }

  void _handleItemPressed(int index) {
    print("_handleItemPressed");
    print("index: $index");
    setState(() {
      if (widget.singleSelect) {
        _selectedItems = List.filled(widget.items.length, false);
        _selectedItems[index] = true;
      } else {
        _selectedItems[index] = !_selectedItems[index];
      }

    });
   
  }

  void addSecondaryItems(int index, Map<int,dynamic> secondaryChosenItems){
    print("addSecondaryItems");
    print("index: $index");    
    resultItems[index] = secondaryChosenItems;
    print("resultItems: $resultItems");
  }

  void processItemsSelected(){
    print("processItemsSelected");
    print("resultItems: $resultItems");
    print("_selectedItems: $_selectedItems");    
    if(widget.secondaryItems.length == 0){
      print("secondaryItems.isEmpty");
      for(int i = 0; i < _selectedItems.length; i++){
        if(_selectedItems[i]){
          resultItems[i] = {};
          // if(secondaryItems.isNotEmpty){
          //   resultItems[i] = secondaryItems;
          // }
        }
      }

    }
    print("resultItems: $resultItems");
    Navigator.pop(context, resultItems);
  }

  Widget _handleSecondaryItemPressed(int index) {
    print("_handleSecondaryItemPressed");
    return AnimatedDialog(items: widget.secondaryItems, singleSelect: false, secondaryItems: []);
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
                          onChanged: (value) async {
                            _handleItemPressed(index);
                            if (widget.secondaryItems.length > 0) {
                              Widget secondaryDialog =
                                  _handleSecondaryItemPressed(index);
                              Map<int,dynamic> secondaryItems = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return secondaryDialog;
                                },
                              );
                              if (secondaryItems.isNotEmpty) {
                                addSecondaryItems(index, secondaryItems);
                              }
                            }
                           
                          },
                        )
                      : Checkbox(
                          value: _selectedItems[index],
                          onChanged: (value) async{
                            _handleItemPressed(index);
                             if (widget.secondaryItems.length > 0) {
                              Widget secondaryDialog =
                                  _handleSecondaryItemPressed(index);
                              Map<int,dynamic> secondaryItems = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return secondaryDialog;
                                },
                              );
                              if (secondaryItems.isNotEmpty) {
                                addSecondaryItems(index, secondaryItems);
                              }
                            }
                          },
                        ),
                 trailing: widget.secondaryItems.length > 0
    ? ElevatedButton(
        onPressed: () async {
          // Call _handleSecondaryItemPressed
          Widget secondaryDialog = _handleSecondaryItemPressed(index);

         
        },
        child: Text('Secondary'),
      )
    : null,

                  onTap: () async {
                    _handleItemPressed(index);
                    if (widget.secondaryItems.length > 0) {
                              Widget secondaryDialog =
                                  _handleSecondaryItemPressed(index);
                              Map<int,dynamic> secondaryItems = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return secondaryDialog;
                                },
                              );
                              if (secondaryItems.isNotEmpty) {
                                addSecondaryItems(index, secondaryItems);
                              }
                            }
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
                  processItemsSelected();
                  // Navigator.pop(context, _selectedItems);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
