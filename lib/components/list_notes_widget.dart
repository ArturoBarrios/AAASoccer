import 'package:flutter/material.dart';

class ListNotes extends StatefulWidget {
  final String title;
  final List<String> notes;

  const ListNotes({Key? key, required this.title, required this.notes})
      : super(key: key);

  @override
  _ListNotesState createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ...widget.notes.take(isExpanded ? widget.notes.length : 1).map((note) => Text(note)).toList(),
        if (widget.notes.length > 1)
          TextButton(
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(isExpanded ? "- Read Less" : "+ Read More"),
          ),
      ],
    );
  }
}
