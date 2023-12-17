import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import 'package:collection/collection.dart';

import '../styles/font_sizes.dart';
import 'Buttons/basic_elevated_button.dart';
import 'models/button_model.dart';
import 'models/custom_stepper_model.dart';

class CustomStepper extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final String? title;
  final TextStyle? titleTextStyle;
  final List<CustomStepperModel>? stepperModel;
  final int? activeStep;
  final ButtonModel? confirmButton;
  final ButtonModel? backButton;
  final Color? backButtonColor;

  const CustomStepper({
    Key? key,
    this.formKey,
    this.title,
    this.titleTextStyle,
    this.stepperModel,
    this.activeStep = 0,
    this.confirmButton,
    this.backButton,
    this.backButtonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stepperLegth = (stepperModel?.length ?? 0);
double screenWidth = MediaQuery.of(context).size.width;
    List<Widget> circularSteps = [];
    if (1 < stepperLegth) {
      for (int i = 0; i < stepperLegth; i++) {
        circularSteps.add(
          Expanded(
            child: Container(
              height: 10,
              color: (i < (activeStep ?? 0) || i == activeStep)
                  ? AppColors.tsnGreen
                  : AppColors.tsnAlmostBlack,
            ),
          ),
        );

        if (i < stepperLegth - 1) {
          circularSteps.add(
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (i < (activeStep ?? 0))
                    ? AppColors.tsnGreen
                    : AppColors.tsnAlmostBlack,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text((i + 1).toString(),
                    style: const TextStyle(color: AppColors.whiteColor)),
              ),
            ),
          );
        }
      }
    }

    return Form(
      key: formKey,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min, // Change to min
            children: [
              const SizedBox(height: 10),
              if (title != null)
                Text(
                  title ?? '',
                  style: titleTextStyle ??
                      const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                ),
              const SizedBox(height: 10),
              if (circularSteps.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: circularSteps),
                ),
              if (circularSteps.isNotEmpty) const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: stepperModel
                                ?.mapIndexed((final index, final item) =>
                                    Column(
                                      children: index == activeStep
                                          ? (stepperModel?[index].widgets ?? [])
                                          : [],
                                    ))
                                .toList() ??
                            [],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
  alignment: Alignment.bottomCenter,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding around the edges
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly space the children across the row
      children: [
        // Use Flexible instead of Container with fixed width
        if (backButton != null) 
          Flexible(
            flex: 1, // Flex factor
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Padding between buttons
              child: BasicElevatedButton(
                backgroundColor: backButtonColor != null ? backButtonColor : AppColors.tsnRed,
                text: backButton?.text ?? '',
                fontSize: FontSizes.m(context),
                onPressed: backButton?.onTap,
              ),
            ),
          ),
        if (confirmButton != null) 
          Flexible(
            flex: 1, // Flex factor
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Padding between buttons
              child: BasicElevatedButton(
                backgroundColor: AppColors.tsnGreen,
                text: confirmButton?.text ?? '',
                fontSize: FontSizes.m(context),
                onPressed: confirmButton?.onTap,
              ),
            ),
          ),
      ],
    ),
  ),
)


        ],
      ),
    );
  }
}
