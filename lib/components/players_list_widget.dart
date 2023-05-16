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

  void _showPlayerDetailsDialog(BuildContext context, String playerName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Player Details'),
        content: Text('This is ' + playerName + '.'),
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
}

  @override
  void initState() {
    super.initState();
   print("initState PlayerList Widget ");
   print("playerDetails: " + widget.playersDetails.toString());
  }

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
      children: widget.playersDetails['players'].map<Widget>((player) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(player['name']),
                ),
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    _showPlayerDetailsDialog(context, player['name']);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // You can call a function here to handle player deletion
                  },
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ),
  ),
),
      ],
    );
  }
}
