import 'package:flutter/material.dart';
import 'package:soccermadeeasy/styles/font_sizes.dart';
import 'package:soccermadeeasy/views/home.dart';
import 'package:soccermadeeasy/views/onboarding/rich_text_selectable_chip_list.dart';

import '../../commands/base_command.dart';
import '../../commands/user_command.dart';
import '../../components/custom_stepper.dart';
import '../../components/headers.dart';
import '../../components/models/button_model.dart';
import '../../components/models/custom_stepper_model.dart';
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
  int stepperListLength = 4;
  int selectedFieldPosition = 0;
  int selectedInterestIndex = -1;
  PrefferedFoot? selectedFoot;
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
  final rateTextList = [
    'Beginner',
    'Above Beginner',
    'Intermediate',
    'Advanced',
    'Amateur',
    'Semi-Pro',
    'Professional',
  ];

  void changeStepValue(final int value) {
    if (!value.isNegative) {
      setState(() {
        activeStep = value;
      });
    }
  }

  Future<void> onCancelTap() async {
    (activeStep == 0) ? null : changeStepValue(activeStep - 1);
  }

  void updateUserOnboarding() async {
      print("updateUserOnboarding");
      dynamic currentUser = UserCommand().getAppModelUser();
      // dynamic userObjectResp = await UserCommand().findMyUserById();
      dynamic userObject = currentUser;//userObjectResp['data'];
      print("userObject: $userObject");
      Map<String, dynamic> partialUserInput = {        
        '_id': userObject['_id'],                    
        'onboarded': true                            
      };
      BaseCommand().initialUserConditionsMet();
      await UserCommand().updateUserOnboarding(partialUserInput);
      BaseCommand().setOnboarded(true);
      

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Home();
          },
        ),
      );
    }

  Future<void> onConfirmTap() async {
    (activeStep == (stepperListLength - 1))
        ? updateUserOnboarding()
        : changeStepValue(activeStep + 1);
  }

  void changeSelectedPosition(final int value) {
    setState(() {
      selectedFieldPosition = value;
    });
  }

  void changeSelectedInterest(final int value) {
    setState(() {
      selectedInterestIndex = value;
    });
  }

  void changeSelectedFoot(PrefferedFoot foot) {
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
    double paddingValue = 0;
    final stepperList = [
      CustomStepperModel(
        widgets: [
          Padding(
                        padding: EdgeInsets.fromLTRB(paddingValue, paddingValue,
                            paddingValue, paddingValue/2),
                        child:
                        ClipRRect(
    borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
    child:
          SizedBox(
            width: MediaQuery.of(context).size.width, // full screen width
            height:
                MediaQuery.of(context).size.height * 0.4, // half screen height
            child: FootballField(
              onTapPosition: (final selectedPosition) =>
                  changeSelectedPosition(selectedPosition),
              selectedPosition: selectedFieldPosition,
            ),
          ))),
        ],
      ),
      CustomStepperModel(
        widgets: [
          emojiList[getSkillLevelIndex(currentRateValue)],
          PlayerRateSlider(
            currentMaxValue: currentRateValue,
            rangeCallback: changeRateValue,
          ),
          Text(rateTextList[getSkillLevelIndex(currentRateValue)],
              style: const TextStyle(fontSize: 20)),
        ],
      ),
      CustomStepperModel(
        widgets: [
          FootSelection(
            onTapPrefferedFoot: changeSelectedFoot,
            selectedFoot: selectedFoot,
          ),
        ],
      ),
      CustomStepperModel(
        widgets: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: RichTextSelectableChipList(
              richTextList: const [
                [
                  TextSpan(
                    text: 'Just for Fun: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Players who are mainly interested in casual play and relaxation, without any competitive edge.',
                  ),
                ],
                [
                  TextSpan(
                    text: 'Recreational Competitor: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Players who enjoy regular games with friends, maybe in local leagues, but mainly for social engagement.',
                  ),
                ],
                [
                  TextSpan(
                    text: 'Serious Hobbyist: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Players who are starting to take the game more seriously, investing time in practice and improvement.',
                  ),
                ],
                [
                  TextSpan(
                    text: 'Aspiring Athlete: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Players who have competitive goals, engaging in regular training, and aiming for higher-level competition.',
                  ),
                ],
                [
                  TextSpan(
                    text: 'Semi-Professional: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Players who are engaged in more structured competitions, with a focus on advancement and potential earnings from the sport.',
                  ),
                ],
                [
                  TextSpan(
                    text: 'Professional Hopeful: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Players on the cusp of professional level, dedicating significant time and effort in pursuit of professional leagues.',
                  ),
                ],
                [
                  TextSpan(
                    text: 'Professional: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Players who play or are aspiring to play at the professional level, making the sport their primary focus.',
                  ),
                ]
              ],
              onTap: changeSelectedInterest,
              selectedIndex: selectedInterestIndex,
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
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
    child: Center( // Center the inner content
      child: Container(
        padding: EdgeInsets.all(20), // You can adjust the padding for spacing
        width: MediaQuery.of(context).size.width * 0.95, // 80% of screen width
        height: MediaQuery.of(context).size.height * 0.8, // 60% of screen height
        decoration: BoxDecoration(
          color: AppColors.tsnDarkGrey, // Inner Container with white background
          borderRadius: BorderRadius.circular(12), // Optional rounded corners
        ),
        child: CustomStepper(
          title: getTitle(),
          titleTextStyle: TextStyle(
            color: AppColors.tsnWhite,     
            fontSize: FontSizes.xl(context)       
          ),
          stepperModel: stepperList,
          activeStep: activeStep,
          cancelButton: ButtonModel(
            text: (activeStep == (stepperListLength - 1))
                ? StringConstants.backBtn
                : StringConstants.cancelBtn,
            onTap: onCancelTap,
          ),
          confirmButton: ButtonModel(
            backgroundColor:
                (activeStep == (stepperListLength - 1)) ? Colors.red : null,
            text: (activeStep == (stepperListLength - 1))
                ? 'Save'
                : StringConstants.nextBtn,
            onTap: onConfirmTap,
          ),
        ),
      ),
    ),
  ),
);
  }

  String getTitle() => activeStep == 0
      ? 'Select the position'
      : activeStep == 1
          ? 'Rate yourself'
          : activeStep == 2
              ? 'Preffered foot'
              : activeStep == 3
                  ? 'Which Best Describes You?'
                  : '';

  int getSkillLevelIndex(double value) {
    if (value >= 0 && value <= 20) return 0;
    if (value > 20 && value <= 40) return 1;
    if (value > 40 && value <= 69) return 2;
    if (value > 69 && value <= 84) return 3;
    if (value > 84 && value <= 92) return 4;
    if (value > 92 && value <= 97) return 5;
    if (value > 97 && value <= 100) return 6;
    return 0;
  }
}
