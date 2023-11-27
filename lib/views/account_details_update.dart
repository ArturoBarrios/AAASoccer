import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:soccermadeeasy/views/splash_screen.dart';

import '../commands/user_command.dart';
import '../components/Validator.dart';
import '../components/custom_textfield.dart';
import '../components/headers.dart';
import '../components/models/button_model.dart';
import '../strings.dart';

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

  // Define your controllers here
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();

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
      usernameController.text = user['name'];
      birthdateController.text = user['birthdate'];
      ageController.text = user['age'];



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
              CustomTextFormField(
                label: 'Name',
                keyboardType: TextInputType.name,
                hintText: 'Enter your username',
                // Add your validator logic here
                controller: usernameController,
              ),
              CustomTextFormField(
            label: StringConstants.startDateTimeLabel,
            hintText: StringConstants.startDateTimeHint,
            keyboardType: TextInputType.datetime,
            controller: birthdateController,
            isSuffixIcon: true,
            validator: (value) => Validators.validateRequired(
                value!, StringConstants.startDateTimeErrorValue),
            suffixIcon: IconButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      onChanged: (date) {}, onConfirm: (date) {
                    setStartTime(date);
                  }, currentTime:  startTime);
                },
                icon: const Icon(Icons.calendar_today_outlined)),
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  onChanged: (date) {}, onConfirm: (date) {
                setStartTime(date);
              }, currentTime: startTime);
            },
          ),
              CustomTextFormField(
                label: 'Age',
                hintText: 'Enter Age',
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: false),
                controller: ageController,
                // Add your validator logic here
              ),
              CustomTextFormField(
                label: 'Capacity',
                hintText: 'Enter capacity',
                keyboardType: TextInputType.number,
                controller: capacityController,
                // Add your validator logic here
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission logic here
                  }
                },
                child: Text('Update Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
