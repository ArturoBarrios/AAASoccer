import 'dart:ui';

import 'package:flutter/material.dart';

// // // // // // // // // // // // // // //
class SearchBar extends StatefulWidget {
  @override
  _SearchBar createState() => _SearchBar();

  
}

class _SearchBar extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
  padding: EdgeInsets.only(top: 16,left: 16,right: 16),
  child: TextField(
    decoration: InputDecoration(
      hintText: "Search...",
      hintStyle: TextStyle(color: Colors.grey.shade600),
      prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: EdgeInsets.all(8),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
              color: Colors.grey.shade100
          )
      ),
    ),
  ),
);
}
}
