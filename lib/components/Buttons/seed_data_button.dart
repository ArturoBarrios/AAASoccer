import 'package:flutter/material.dart';
import '../../testing/seeding/database_seeder.service.dart';

class SeedDataButton extends StatefulWidget {
  const SeedDataButton({Key? key}) : super(key: key);

  @override
  State<SeedDataButton> createState() => _SeedDataButton();
}

class _SeedDataButton extends State<SeedDataButton> {
  bool visible = false;

  void runDatabaseSeeder() {
    print("runDatabaseSeeder");
    DatabaseSeeder().run();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return SizedBox(
        height: 30,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            runDatabaseSeeder();
          },
          child: const Text('Run database Seeder'),
        ));
  }
}
