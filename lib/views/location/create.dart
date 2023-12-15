import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/headers.dart';
import '../../commands/base_command.dart';
import '../../commands/location_command.dart';
import '../../components/Validator.dart';
import '../../components/location_search_bar.dart';
import '../../components/models/button_model.dart';
import '../../components/models/custom_stepper_model.dart';
import '../../components/custom_stepper.dart';
import '../../components/custom_textfield.dart';
import '../../components/selectable_icon_grid.dart';
import '../../strings.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../svg_widgets.dart';

class LocationCreate extends StatefulWidget {
  const LocationCreate(
      {Key? key})
      : super(key: key);  

  @override
  _LocationCreateState createState() => _LocationCreateState();
}

class _LocationCreateState extends State<LocationCreate> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final urlController = TextEditingController();
  late LocationSearchBar locationSearchBar;

  List<Svg> locationSvgs = [];
  List<Svg> moneySvgs = [];

  bool isPrivate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  

  void goBack() {
    Navigator.pop(context);
  }  

  Future<void> createLocation() async {
    print("createLocation");
    Map<String, dynamic> locationInput = {
      "name": nameController.text,
      "description": descriptionController.text,
      "url": urlController.text,
      "isPrivate": isPrivate,
    };
    LocationCommand().createLocation(
      locationInput
    );
    
  }

   int activeStep = 0;

  void changeStepValue(final int value) {
    setState(() {
      if (!value.isNegative) {
        activeStep = value;
      }
    });
  }

  Future<void> onTapCreate() async {
    await createLocation();
    goBack();
  }

  void initialLoad(){
    locationSvgs = BaseCommand().getLocationSvgs();
    locationSvgs = BaseCommand().getPriceSvgs();
  }

  @override
  void initState() {
    print("views/locations/create.dart init state");
    super.initState();
    initialLoad();

  }

  

  @override
  Widget build(BuildContext context) {
    final stepperList = [
      CustomStepperModel(
        widgets: [
          CustomTextFormField(
            label: StringConstants.nameLabel,
            keyboardType: TextInputType.name,
            hintText: StringConstants.nameHint,
            validator: (value) => Validators.validateRequired(
                value!, StringConstants.nameErrorValue),
            controller: nameController,
          ),          
          locationSearchBar,

          CustomTextFormField(
            label: StringConstants.urlLabel,
            hintText: StringConstants.urlHint,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: false,
            ),
            controller: urlController,
            validator: (value) => Validators.validateRequired(
              value!,
              StringConstants.urlErrorValue,
            ),
          ),
          SelectableIconGrid(svgs: moneySvgs),          
        ],
      ),
      CustomStepperModel(
        widgets: [
          SelectableIconGrid(svgs: locationSvgs)
        ],
      ),
    ];

    Future<void> onCancelTap() async {
      (activeStep == 0)
          ? Navigator.of(context).pop()
          : changeStepValue(activeStep - 1);
    }

    Future<void> onConfirmTap() async {
      if (_formKey.currentState!.validate()) {
        (activeStep == (stepperList.length - 1))
            ? await onTapCreate()
            : changeStepValue(activeStep + 1);
      }
    }

    return Scaffold(
      appBar: const Headers()
          .getBackHeader(context, "Create Location"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: CustomStepper(
          formKey: _formKey,
          title: (activeStep == (stepperList.length - 1))
              ? 'Complete'
              : 'Create Game',
          stepperModel: stepperList,
          activeStep: activeStep,
          backButton: ButtonModel(
            text: (activeStep == (stepperList.length - 1))
                ? StringConstants.backBtn
                : StringConstants.cancelBtn,
            onTap: onCancelTap,
          ),
          confirmButton: ButtonModel(
            backgroundColor:
                (activeStep == (stepperList.length - 1)) ? Colors.red : null,
            text: (activeStep == (stepperList.length - 1))
                ? StringConstants.createGameBtn
                : StringConstants.nextBtn,
            onTap: onConfirmTap,
          ),
        ),
      ),
    );
  }
}
