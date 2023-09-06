import 'package:flutter/material.dart';
import '../models/pageModels/app_model.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key, required this.testText}) : super(key: key);

  final String testText;

  @override
  State<SearchField> createState() => _SearchField();
}

class _SearchField extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30)),
        prefixIcon: const Icon(Icons.search),
        prefixIconColor:
            MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return Colors.green;
          }
          if (states.contains(MaterialState.error)) {
            return Colors.red;
          }
          return Colors.grey;
        }),
        labelText: widget.testText,
      ),
    );
  }
}
