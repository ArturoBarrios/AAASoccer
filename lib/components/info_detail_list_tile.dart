import 'package:flutter/material.dart';

// Change color here
const primaryColor = Color(0xff4338CA);

class InfoDetailListTile extends StatelessWidget {
  final String name;
  final String value;
  final String tooltip;
  final String date;

  const InfoDetailListTile(
      {required this.name,
      required this.value,
      required this.tooltip,
      required this.date,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, top: 10.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 15.0),
              ),
              const SizedBox(height: 7.0),
              Row(
                children: <Widget>[
                  Text(
                    tooltip,
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  ),
                  const SizedBox(width: 4.0),
                  const Icon(
                    Icons.timer,
                    size: 4.0,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  )
                ],
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                value,
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontFamily: 'Montserrat',
                    fontSize: 20.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}
