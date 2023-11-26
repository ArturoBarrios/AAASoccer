import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'home.dart';
import '../commands/user_command.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void updateUserOnboarding() async {
      //getCurrentUser
      dynamic currentUser = UserCommand().getAppModelUser();
      print("updateUserOnboarding");
      // dynamic userObjectResp = await UserCommand().findUserById(currentUser);
      dynamic userObject = currentUser;//userObjectResp['data'];
      print("userObject: $userObject");
      Map<String, dynamic> partialUserInput = {
        'user': {
          '_id': userObject['_id'],
          'dataToUpdate': """
          {
            onboarded: true
          }
          """,
        },
      };
      await UserCommand().updateUserOnboarding(partialUserInput);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Home();
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Title of blue page",
            body:
                "Welcome to the app! This is a description on a page with a blue background.",
            image: Center(
              child: Image.network(
                  "https://img.freepik.com/premium-vector/boy-playing-soccer-cartoon-vector-icon-illustration_663547-63.jpg",
                  height: 175.0),
            ),
            // decoration: const PageDecoration(
            //   pageColor: Colors.blue,
            // ),
          ),
          PageViewModel(
            title: 'Title of 2nd Page',
            body: 'Body of 2nd Page',
          ),
          PageViewModel(
            title: 'Title of 3rd Page',
            body: 'Body of 3rd Page',
          ),
          PageViewModel(
            title: 'Title of 4th Page',
            body: 'Body of 4th Page',
          ),
        ],
        onDone: () {
          // updateUserOnboarding();
        },
        skip: const Icon(Icons.skip_next),
        next: const Icon(Icons.forward),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.blue,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
