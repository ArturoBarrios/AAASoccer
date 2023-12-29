import 'package:flutter/material.dart';
import 'package:soccermadeeasy/styles/font_sizes.dart';
import 'package:soccermadeeasy/views/home.dart';
import 'package:soccermadeeasy/views/onboarding/rich_text_selectable_chip_list.dart';

import '../../commands/base_command.dart';
import '../../commands/user_command.dart';
import '../../components/Buttons/basic_elevated_button.dart';
import '../../components/custom_stepper.dart';
import '../../components/headers.dart';
import '../../components/models/button_model.dart';
import '../../components/models/custom_stepper_model.dart';
import '../../components/selection_list_widget.dart';
import '../../constants.dart';
import '../../strings.dart';
import '../../styles/colors.dart';
import 'football_field.dart';
import 'player_rate_slider.dart';
import 'preffered_foot.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int activeStep = 0;
  // int stepperListLength = 3;
  List<CustomStepperModel> stepperList = [];
  String preferredPosition = Constants.playerCoordinates[4]?[2];  
  int preferredPositionIndex = 4;
  int selectedInterestIndex = 0;
  PreferredFoot? selectedFoot = PreferredFoot.right;
  String? selectedSkillLevel = Constants.skillLevels[0]['title'];
  int selectedSkillLevelIndex = 0;
  String? selectedInterest = Constants.interests[0]['title'];
  double currentRateValue = 50;

  final emojiList = [
    const Text('⚽', style: TextStyle(fontSize: 30.0)),
    const Text('🏃', style: TextStyle(fontSize: 30.0)),
    const Text('👌', style: TextStyle(fontSize: 30.0)),
    const Text('🌟', style: TextStyle(fontSize: 30.0)),
    const Text('👏', style: TextStyle(fontSize: 30.0)),
    const Text('🎖', style: TextStyle(fontSize: 30.0)),
    const Text('🏆', style: TextStyle(fontSize: 30.0)),
  ];


  void changeStepValue(final int value) {
    if (!value.isNegative) {
      setState(() {
        activeStep = value;
      });
    }
  }

  Future<void> onBackTap() async {
    (activeStep == 0) ? null : changeStepValue(activeStep - 1);
  }

  void updateUserOnboarding() async {
    print("updateUserOnboarding");
    print("selectedFoot: "+ selectedFoot.toString());
    dynamic currentUser = UserCommand().getAppModelUser();
    // dynamic userObjectResp = await UserCommand().findMyUserById();
    dynamic userObject = currentUser; //userObjectResp['data'];
    // print("userObject: $userObject");
    Map<String, dynamic> partialUserInput = {
      '_id': userObject['_id'],
      'onboarded': true,
      'preferredFoot': selectedFoot!.index == 1 ? "RIGHT" : "LEFT",
      'preferredPosition': preferredPosition,
      'skillLevel': selectedSkillLevel,
      // 'interestedIn': selectedInterest,
    };
    print("partialUserInput: $partialUserInput");

    Map<String,dynamic> updateUserOnboardingResp = await UserCommand().updateUserOnboarding(partialUserInput);
    print("updateUserOnboardingResp: $updateUserOnboardingResp");
    if(updateUserOnboardingResp['success'] == true){
      print("updateUserOnboardingResp['data']: ${updateUserOnboardingResp['data']}");
      // UserCommand().setAppModelUser(updateUserOnboardingResp['data']);
      UserCommand().setUserOnboardingProperties(partialUserInput);
      BaseCommand().initialUserConditionsMet();
      BaseCommand().setOnboarded(true);
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Home();
        },
      ),
    );
  }

  Future<void> onConfirmTap() async {
    print("onboarding onConfirmTap");
    print("activeStep: $activeStep");
    print("stepperList.length: " + stepperList.length.toString());
    (activeStep == (stepperList.length - 1))
        ? updateUserOnboarding()
        : changeStepValue(activeStep + 1);
  }

  void changeSelectedPosition(final String value) {
    print("changeSelectedPosition");
    print("value: $value");
    setState(() {
      preferredPosition = value;
      preferredPositionIndex = Constants.playerCoordinates.entries
        .firstWhere((entry) => entry.value[2] == value,
            orElse: () => MapEntry(-1, []))
        .key;
  
     
    });
  }

  void changeSelectedInterest(final int value) {
      print("changeSelectedInterest: "+ value.toString());
    setState(() {
      selectedInterestIndex = value;
      selectedInterest = Constants.interests[selectedInterestIndex]['title'];
    });
  }
  
  void changeSelectedSkillLevel(final int value) {
      print("changeSelectedSkillLevel: "+ value.toString());
    setState(() {
      selectedSkillLevelIndex = value;
      selectedSkillLevel = Constants.skillLevels[selectedSkillLevelIndex]['title'];
    });
  }

  void changeSelectedFoot(PreferredFoot foot) {
    
    setState(() {
      selectedFoot = foot;
    });
  }

  void changeRateValue(final double value) {
    setState(() {
      currentRateValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double paddingValue = 16;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    stepperList = [
      CustomStepperModel(
        widgets: [
          Padding(
              padding: EdgeInsets.fromLTRB(
                  paddingValue, paddingValue, paddingValue, paddingValue / 2),
              child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(15), // Adjust the radius as needed
                  child: SizedBox(
                    width:
                        MediaQuery.of(context).size.width, // full screen width
                    height: MediaQuery.of(context).size.height *
                        0.5, // half screen height
                    child: FootballField(
                      onTapPosition: (final selectedPosition) =>
                          changeSelectedPosition(selectedPosition),
                      selectedPosition: preferredPositionIndex,
                    ),
                  ))),
        ],
      ),
      CustomStepperModel(
        widgets: [
          FootSelection(
            onTapPreferredFoot: changeSelectedFoot,
            selectedFoot: selectedFoot,
          ),
        ],
      ),
      CustomStepperModel(
        widgets: [
          Container(
              height: screenHeight*.6,
              child: SelectionListWidget(
                selections: Constants.skillLevels,
                onTap: (index) {
                  // Handle tap event
                  changeSelectedSkillLevel(index);
                },
                selectedIndex: selectedSkillLevelIndex,
              )),
              
        ],
      ),      
      // CustomStepperModel(
      //   widgets: [
      //     Container(
      //         height: 400,
      //         child: SelectionListWidget(
      //           selections: Constants.interests,
      //           onTap: (index) {
      //             // Handle tap event
      //             changeSelectedInterest(index);
      //           },
      //           selectedIndex: selectedInterestIndex,
      //         )),
      //     const SizedBox(height: 20)
      //   ],
      // ),
    ];

    return Scaffold(
      appBar: Headers(
        playerStepperButton: ButtonModel(
          prefixIconData: Icons.play_circle_fill_rounded,
          onTap: () {},
        ),
      ).getMainHeader(context),
      body: Container(
          color: AppColors.tsnBlack, // Outer Container with black background
          child: Column(
              // mainAxisSize:
              //     MainAxisSize.min, // Use the minimum space needed by children
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            width: screenWidth / 4,
                            child: BasicElevatedButton(
                              onPressed: () {
                                setState(() {
                                activeStep = stepperList.length - 1;
                                onConfirmTap();
                                  
                                });
                              },
                              icon: Icons.close,
                              iconColor: AppColors.tsnRed,
                              backgroundColor: AppColors.tsnDarkGrey,
                              text: "Skip",
                              textColor: AppColors.tsnRed,
                              fontSize: FontSizes.xxs(context),
                            )))),
                // SizedBox(height: 20),
                Center(
                  // Center the inner content
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      0,0,0,8
                        ), // You can adjust the padding for spacing
                    width: MediaQuery.of(context).size.width *
                        0.95, // 80% of screen width
                    height: MediaQuery.of(context).size.height *
                        0.8, // 60% of screen height
                    decoration: BoxDecoration(
                      color: AppColors
                          .tsnDarkGrey, // Inner Container with white background
                      borderRadius:
                          BorderRadius.circular(12), // Optional rounded corners
                    ),
                    child: CustomStepper(
                      title: getTitle(),
                      titleTextStyle: TextStyle(
                          color: AppColors.tsnWhite,
                          fontSize: FontSizes.xl(context)),
                      stepperModel: stepperList,
                      activeStep: activeStep,                              
                      backButtonColor: activeStep == 0 ? AppColors.tsnGrey : AppColors.tsnRed,
                      backButton: 
                        ButtonModel(
                          text: StringConstants.backBtn,                            
                          onTap: onBackTap,
                        ),
                      confirmButton: ButtonModel(
                        backgroundColor: (activeStep == (stepperList.length - 1))
                            ? Colors.red
                            : null,
                        text: (activeStep == (stepperList.length - 1))
                            ? 'Save'
                            : StringConstants.nextBtn,
                        onTap: onConfirmTap,
                      ),
                    ),
                  ),
                )
              ])),
    );
  }

  String getTitle() => activeStep == 0
      ? 'Select the position'
      : activeStep == 1
          ? 'Preferred foot'
          : activeStep == 2
              ? 'Rate yourself'              
                  : '';

  // int getSkillLevelIndex(double value) {
  //   if (value >= 0 && value <= 20) return 0;
  //   if (value > 20 && value <= 40) return 1;
  //   if (value > 40 && value <= 69) return 2;
  //   if (value > 69 && value <= 84) return 3;
  //   if (value > 84 && value <= 92) return 4;
  //   if (value > 92 && value <= 97) return 5;
  //   if (value > 97 && value <= 100) return 6;
  //   return 0;
  // }
}
