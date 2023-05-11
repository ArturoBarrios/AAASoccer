import 'package:flutter/material.dart';

class PlayerList extends StatefulWidget {
  final dynamic playersDetails;

  PlayerList({required this.playersDetails});

  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  bool _isExpanded = false;
  List<dynamic> _selectedPlayersDetails = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'Showing Selected' : 'Showing All',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        // if (_isExpanded)
        //   Container(
        //     padding: EdgeInsets.symmetric(vertical: 10),
        //     child: Column(
        //       children: [
        //         TextField(
        //           decoration: InputDecoration(
        //             hintText: 'Search',
        //             prefixIcon: Icon(Icons.search),
        //           ),
        //           onChanged: (value) {
        //             // TODO: Implement search functionality
        //           },
        //         ),
        //         SizedBox(height: 10),
        //         Expanded(
        //           child: ListView.builder(
        //             itemCount: widget.playersDetails.length,
        //             itemBuilder: (BuildContext context, int index) {
        //               final playerDetails = widget.playersDetails[index];
        //               final isSelected = _selectedPlayersDetails.contains(playerDetails);
        //               return CheckboxListTile(
        //                 title: Text(playerDetails['name']),
        //                 value: isSelected,
        //                 onChanged: (value) {
        //                   setState(() {
        //                     if (value == true) {
        //                       _selectedPlayersDetails.add(playerDetails);
        //                     } else {
        //                       _selectedPlayersDetails.remove(playerDetails);
        //                     }
        //                   });
        //                 },
        //               );
        //             },
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('John Doe'),
                        ),
                        IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Player Details'),
                                  content: Text('This is John Doe.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Jane Smith'),
                        ),
                        IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {
                            
                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Player Details'),
                            //       content: Text('This is Jane Smith.'),
                            //       actions: [
                            //         TextButton(
                            //           onPressed: () {
                            //             Navigator.pop(context);
                            //           },
                            //           child: Text('OK'),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                        ),
                        IconButton(
                          //remove by role, choose role(s) 
                          //to remove from player
                          icon: Icon(Icons.delete),
                          onPressed: () {

                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Player Details'),
                            //       content: Text('This is Jane Smith.'),
                            //       actions: [
                            //         TextButton(
                            //           onPressed: () {
                            //             Navigator.pop(context);
                            //           },
                            //           child: Text('OK'),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
