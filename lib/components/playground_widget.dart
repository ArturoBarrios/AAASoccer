import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Dialogues/congrats_dialogue.dart';
import 'package:soccermadeeasy/components/Dialogues/rating_dialogue.dart';
import 'package:soccermadeeasy/components/logo.dart';
import 'package:soccermadeeasy/components/sideways_pill_widget.dart';
import 'package:soccermadeeasy/svg_widgets.dart';

import '../commands/base_command.dart';
import '../commands/subscriptions_command.dart';
import '../styles/colors.dart';
import '../styles/font_sizes.dart';
import 'Buttons/basic_elevated_button.dart';
import 'Buttons/circle_outline_icon.dart';
import 'Buttons/custom_button.dart';
import 'Cards/tsn_pickup_card.dart';
import 'Loading/loading_icon.dart';
import 'custom_footer.dart';
import 'logo_text.dart';

class PlaygroundWidget extends StatefulWidget {
  @override
  _PlaygroundWidgetState createState() => _PlaygroundWidgetState();
}

class _PlaygroundWidgetState extends State<PlaygroundWidget> {
  // Add your state variables and methods here
  List<String> items = []; // You can replace this with your actual data

  // This is a method to simulate adding more items to the list.
  void addItem() {
    setState(() {
      items.add('New Item ${items.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Playground Widget'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          CustomFooter(),
          RatingDialogue(),
          
          SidewaysPillWidget(
  text: "Follow",
  // icon: Icons.star,
),
        
          CustomButton(
  iconData: Icons.person, 
  buttonText: "5/12",
  fontSize: FontSizes.xxs(context),
),

          TextButton(
            onPressed: () {
              // This is where you'd typically handle the button press.
              // You could, for example, navigate to another screen.
              print('Create Subscription button pressed');
            },
            child: Text(
              'Create Subscription',
              style: TextStyle(
                color: Colors.green, // you can customize the color here
              ),
            ),
          ),
          BasicElevatedButton(
              customIcon: SVGWidgets().getSoccerBallSVGImage(),
              height: screenHeight * 0.05, // 10% of screen height
              width: screenWidth * 0.35,
              backgroundColor: AppColors.tsnGreen,
              text: "Enable",
              fontSize: FontSizes.xxs(context),
              
              ),
          CircleOutlineIcon(
            icon: Icon(Icons.star, color: Colors.white),
            backgroundColor: Colors.blue,
            borderColor: Colors.red,
            circleSize: 60.0,
            borderThickness: 3.0,
          ),
          LoadingIcon(
              width: 20,
              height: 20,
              svgImage: SVGWidgets().getSoccerBallSVGImage()),
         
          LogoWidget(
            width: 100.0,
            height: 100.0, //Replace with your actual image provider
            backgroundColor: Colors.transparent,
          ),
          LogoTextWidget(
            width: 300.0,
            height: 50.0, //Replace with your actual image provider
            backgroundColor: Colors.transparent,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        child: Icon(Icons.add),
      ),
    );
  }
}
