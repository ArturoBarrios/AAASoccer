import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import 'package:collection/collection.dart';

import 'models/button_model.dart';
import 'models/custom_stepper_model.dart';

class CustomStepper extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final String? title;
  final TextStyle? titleTextStyle;
  final List<CustomStepperModel>? stepperModel;
  final int? activeStep;
  final ButtonModel? confirmButton;
  final ButtonModel? cancelButton;

  const CustomStepper({
    Key? key,
    this.formKey,
    this.title,
    this.titleTextStyle,
    this.stepperModel,
    this.activeStep = 0,
    this.confirmButton,
    this.cancelButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stepperLegth = (stepperModel?.length ?? 0);

    List<Widget> circularSteps = [];
    if (1 < stepperLegth) {
      for (int i = 0; i < stepperLegth; i++) {
        circularSteps.add(
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (i < (activeStep ?? 0) || i == activeStep)
                  ? AppColors.orangeColorShade500
                  : AppColors.grayColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text((i + 1).toString(),
                  style: const TextStyle(color: AppColors.whiteColor)),
            ),
          ),
        );

        if (i < stepperLegth - 1) {
          circularSteps.add(
            Expanded(
              child: Container(
                height: 10,
                color: (i < (activeStep ?? 0))
                    ? AppColors.orangeColorShade500
                    : AppColors.grayColor,
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
              if (cancelButton != null || confirmButton != null)
                const SizedBox(height: 80)
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: confirmButton == null || cancelButton == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                if (cancelButton != null)
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: FloatingActionButton.extended(
                      isExtended: true,
                      label: Text(
                        cancelButton?.text ?? '',
                        style: cancelButton?.textStyle ??
                            const TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                      ),
                      backgroundColor: cancelButton?.backgroundColor ??
                          AppColors.orangeColorShade500,
                      onPressed: cancelButton?.onTap,
                    ),
                  ),
                if (confirmButton != null)
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: FloatingActionButton.extended(
                      isExtended: true,
                      label: Text(
                        confirmButton?.text ?? '',
                        style: confirmButton?.textStyle ??
                            const TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                      ),
                      backgroundColor: confirmButton?.backgroundColor ??
                          AppColors.orangeColorShade500,
                      onPressed: confirmButton?.onTap,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
