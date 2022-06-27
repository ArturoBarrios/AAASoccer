import 'package:flutter/material.dart';
import '../../testing/seeding/database_seeder.service.dart';

class BasicElevatedButton extends StatefulWidget {
  const BasicElevatedButton({Key? key}) : super(key: key);

  @override
  State<BasicElevatedButton> createState() => _BasicElevatedButton();
}


class _BasicElevatedButton extends State<BasicElevatedButton> {
 bool visible = false;
 Map<String, dynamic> data = {
  "num_of_user_locs": 4500,
  'num_of_users': 4500
 };
  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return SizedBox(
          height: 30,
          child: ElevatedButton(
            style: buttonStyle,
            onPressed: () {DatabaseSeeder().run(data);},
            child: 
              const Text('Enabled'),
        )   
    );
  }
}