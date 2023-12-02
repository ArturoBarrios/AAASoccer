import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Dialogues/congrats_dialogue.dart';
import 'package:soccermadeeasy/components/Dialogues/rating_dialogue.dart';
import 'package:soccermadeeasy/components/image_selection_widget.dart';
import 'package:soccermadeeasy/components/logo.dart';
import 'package:soccermadeeasy/components/rating_widget.dart';
import 'package:soccermadeeasy/components/sideways_pill_widget.dart';
import 'package:soccermadeeasy/svg_widgets.dart';

import '../commands/base_command.dart';
import '../commands/subscriptions_command.dart';
import '../constants.dart';
import '../models/enums/AmenityType.dart';
import '../styles/colors.dart';
import '../styles/font_sizes.dart';
import 'Buttons/basic_elevated_button.dart';
import 'Buttons/circle_outline_icon.dart';
import 'Buttons/custom_button.dart';
import 'Cards/tsn_pickup_card.dart';
import 'Loading/loading_icon.dart';
import 'agreement_form_widget.dart';
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

  void _showAgreementDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AgreementFormWidget(
          title: 'Agreement Title',
          bodyText: 'Your agreement text goes here...',
          onAccept: () {
            print("Accepted");
            Navigator.of(context).pop(); // Close the dialog
          },
          onReject: () {
            print("Rejected");
            Navigator.of(context).pop(); // Close the dialog
          },
        );
      },
    );
  }

  void test(){

  }

  
  List<String> selectedAmenities = [];

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
          RatingWidget(rating: 5),
          CustomFooter(),
          ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 300, // You can adjust this height
      ),
      child: ImageSelectionWidget(
        selectionList: Constants.hostAmenities,
        onSelectionChanged: (newSelection) {
          setState(() {
            selectedAmenities = newSelection;
          });
        }, viewMode: true,
      ),
    ),
          Center(
        child: ElevatedButton(
          onPressed: () => _showAgreementDialog(context),
          child: Text("Show Agreement"),
        ),
      ),
          // AgreementFormWidget(
          //   title: "Terms and Conditions",
          //   bodyText: "This is the body text",
          //   onAccept: () {
          //     print("Accepted");
          //   },
          //   onReject: () {
          //     print("Rejected");
          //   },

          // ),
          // RatingDialogue(),
          
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
