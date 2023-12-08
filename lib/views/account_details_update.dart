import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import 'package:soccermadeeasy/views/splash_screen.dart';

import '../commands/user_command.dart';
import '../components/Validator.dart';
import '../components/custom_textfield.dart';
import '../components/headers.dart';
import '../components/models/button_model.dart';
import '../models/enums/GenderType.dart';
import '../strings.dart';
import '../styles/colors.dart';

class AccountDetailsUpdate extends StatefulWidget {
  @override
  _AccountDetailsUpdateState createState() => _AccountDetailsUpdateState();
}

class _AccountDetailsUpdateState extends State<AccountDetailsUpdate> {
  final _formKey = GlobalKey<FormState>();
  dynamic user;
  bool isLoading = true;
  DateTime startTime = DateTime.now();
  String startTimestamp = "";
  bool startTimeSet = false;
  final birthdateFormatter = MaskTextInputFormatter(
    mask: 'mm-dd-yyyy',
    filter: {
      "m": RegExp(r'[0-9]'),
      "d": RegExp(r'[0-9]'),
      "y": RegExp(r'[0-9]'),
    },
    type: MaskAutoCompletionType.lazy,
  );
  
  String? selectedGender;
  List<String> get genderOptions => GenderType.values.map((e) => e.name).toList();

  // Define your controllers here
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  void setStartTime(DateTime time) {
    startTime = time;
    startTimestamp = time.millisecondsSinceEpoch.toString();
    birthdateController.text = '${time.day}/${time.month}/${time.year} '
        ' ${time.hour}:${time.minute}';
    startTimeSet = true;    
  }

  void loadInitialData(){
    user = UserCommand().getAppModelUser();
    setState(() {
      nameController.text = user['name'];
      birthdateController.text = user['birthdate'];
      genderController.text = user['gender'];
      



      isLoading = false;

      
    });
  }

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headers(
              playerStepperButton: ButtonModel(
                prefixIconData: Icons.play_circle_fill_rounded,
                onTap: () {},
              ),
            ).getMainHeader(context),
      body: 
      isLoading ? SplashScreen() : 
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextFormField(
                              style: TextStyle(color: AppColors.fieldTextInsideDarkFill,),
                              controller: nameController,
                              keyboardType: TextInputType.name,                              
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }                                
                                return null;
                              },
                              
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: AppColors.fieldLabelTextInsideDarkFill,),                                                                                                
                                hintText: 'Name',
                                filled: true,                                
                                fillColor: AppColors.fieldFillDark,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,                                  
                                ),
                              ),
                            ),
            ),
          ),
          ],
      ),
               Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0, top: 8.0),
              child:
               TextFormField(
                              style: TextStyle(color: AppColors.fieldTextInsideDarkFill,),
                              controller: birthdateController,
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                              inputFormatters: [birthdateFormatter],
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: AppColors.fieldLabelTextInsideDarkFill,),                                                                                                
                                hintText: 'mm-dd-yyyy',
                                // helperText: "mm-dd-yyyy",
                                filled: true,
                                fillColor: AppColors.fieldFillDark,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                              ),
            ))),

          //     CustomTextFormField(
          //   label: "Birthdate",
          //   hintText: StringConstants.startDateTimeHint,
          //   keyboardType: TextInputType.datetime,
          //   controller: birthdateController,
          //   isSuffixIcon: true,
          //   validator: (value) => Validators.validateRequired(
          //       value!, StringConstants.startDateTimeErrorValue),
          //   suffixIcon: IconButton(
          //       onPressed: () {
          //         DatePicker.showDateTimePicker(context,
          //             showTitleActions: true,
          //             onChanged: (date) {}, onConfirm: (date) {
          //           setStartTime(date);
          //         }, currentTime:  startTime);
          //       },
          //       icon: const Icon(Icons.calendar_today_outlined)),
          //   onPressed: () {
          //     DatePicker.showDateTimePicker(context,
          //         showTitleActions: true,
          //         onChanged: (date) {}, onConfirm: (date) {
          //       setStartTime(date);
          //     }, currentTime: startTime);
          //   },
          // ),
          Expanded(
  child: Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: DropdownButtonHideUnderline(
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: 'Gender',
          hintStyle: TextStyle(color: AppColors.tsnGrey),
          filled: true,
          fillColor: AppColors.tsnAlmostBlack,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: DropdownButtonFormField<String>(
          value: selectedGender,
          style: TextStyle(color: AppColors.tsnAlmostBlack),
          decoration: InputDecoration.collapsed(hintText: ''),
          items: [
            DropdownMenuItem(
              value: null,
              child: Text(
                'Gender',
                style: TextStyle(color: AppColors.tsnGrey),
              ),
            ),
            ...genderOptions.map((String gender) {
              return DropdownMenuItem(
                value: gender,
                child: Text(
                  gender,
                  style: TextStyle(color: AppColors.tsnWhite),
                ),
              );
            }).toList(),
          ],
          onChanged: (String? newValue) {
            setState(() {
              selectedGender = newValue;
            });
            genderController.text = newValue ?? '';
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This field is required";
            }
            return null;
          },
          dropdownColor: AppColors.fieldFillDark,
        ),
      ),
    ),
  ),
),
              // CustomTextFormField(
              //   label: 'Gender',
              //   hintText: 'Enter Age',
              //   keyboardType: TextInputType.numberWithOptions(
              //       signed: true, decimal: false),
              //   controller: ageController,
              //   // Add your validator logic here
              // ),
              
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(
                    top: 26.0, bottom: 16.0, left: 16.0, right: 16.0),
                child:BasicElevatedButton(
        
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission logic here
                  }
                },
                backgroundColor: AppColors.tsnGreen,
                text: "Update Details"
              )),
    );
  }
}
