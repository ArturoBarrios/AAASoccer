import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:amplify_api/amplify_api.dart';
import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import 'package:soccermadeeasy/components/Validator.dart';
import 'package:soccermadeeasy/components/custom_textfield.dart';
import 'package:soccermadeeasy/views/game/view.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/create_event_payment.dart';
import '../../components/create_event_request.dart';
import '../../components/create_team_payment.dart';
import '../../components/create_team_request.dart';
import '../../components/date_time_picker.dart';
import '../../components/headers.dart';
import '../../components/location_search_bar.dart';
import '../../commands/game_command.dart';
import '../../commands/game_command.dart';
import '../../commands/location_command.dart';
import '../../commands/event_command.dart';
import '../../enums/EventType.dart';
import '../../testing/seeding/event_seeder.dart';
import '../../testing/seeding/location_seeder.dart';
import '../../components/profile.dart';
import '../../views/home.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../styles/colors.dart';
import '../../strings.dart';
import '../../styles/static_decoration.dart';

class GameCreate extends StatefulWidget {
  @override
  _GameCreateState createState() => _GameCreateState();
}

class _GameCreateState extends State<GameCreate> {
  final nameController = TextEditingController();
  final hometeamController = TextEditingController();
  final awayteamController = TextEditingController();
  final isPickupController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();

  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final numberOfTeamsController = TextEditingController();
  final numberOfRoundsPerTeamController = TextEditingController();
  final numberOfTeamsPerGroupController = TextEditingController();
  final roundOfXController = TextEditingController();
  final knockoutRoundsController = TextEditingController();
  final teamPriceController = TextEditingController();
  final capacityController = TextEditingController();

  bool _isLoading = false;
  CreateEventRequest createEventRequestWidget = new CreateEventRequest();
  CreateEventPayment createEventPaymentWidget = new CreateEventPayment();
  CreateTeamPayment createTeamPaymentWidget = new CreateTeamPayment();
  CreateTeamRequest createTeamRequestWidget = new CreateTeamRequest();
  DateTimePicker dateTimePicker = new DateTimePicker();
  LocationSearchBar locationSearchBar = new LocationSearchBar();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  String startTimestamp = "";
  String endTimestamp = "";
  DateTime rightNow = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().millisecondsSinceEpoch ~/ 1000 * 1000);
  DateTime twoHoursFromStart = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().add(const Duration(hours: 2)).millisecondsSinceEpoch ~/
          1000 *
          1000);
  bool startTimeSet = false;

  Future<void> createPickupGame() async {
    print("createGame");
    Map<String, dynamic> createPickupGameResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {
      var rng = Random();
      print("priceee: " + priceController.text.toString());
      Map<String, dynamic> eventInput = {
        "name": nameController.text.toString(),
        'isMainEvent': true,
        'price': double.parse(priceController.text.toString()),
        'startTime': startTimestamp,
        'endTime': endTimestamp,
        'withRequest': createEventRequestWidget.withRequest.value,
        'withPayment': createEventPaymentWidget.withPayment.value,
        'withTeamPayment': createTeamPaymentWidget.withPayment.value,
        'withTeamRequest': createTeamRequestWidget.withRequest.value,
        'roles': "{PLAYER, ORGANIZER}",
        'createdAt': dateTimePicker.rightNow.millisecondsSinceEpoch.toString(),
        'type': EventType.GAME,
      };
      dynamic pickupData = {
        "pickup": true,
      };
      // Map<String, dynamic> randomPickupData =
      //     EventSeeder().getRandomPickupGameData();
      // Map<String, dynamic> generateRandomLocation = await LocationSeeder().generateRandomLocation(LocationSeeder().locations[0]);
      Map<String, dynamic> locationInput = {
        "name": locationSearchBar.address,
        "latitude": locationSearchBar.coordinates.latitude,
        "longitude": locationSearchBar.coordinates.longitude,
      };
      // Map<String, dynamic> locationInput = generateRandomLocation["data"]["randomLocation"];
      print("locationInputCheaheck: " + locationInput.toString());

      Map<String, dynamic> createPickupGameResp =
          await GameCommand().createGame(pickupData, eventInput, locationInput);
      print("createPickupGameResp: " + createPickupGameResp.toString());
      print(createPickupGameResp['data']);
      if (createPickupGameResp['success']) {
        Map<String, dynamic> createdGame = createPickupGameResp['data'];
        await EventCommand()
            .updateViewModelsWithEvent(createdGame['event'], true);

        Navigator.pop(
          context,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PickupView(game: createdGame['event'])),
        );
      }
    } on ApiException catch (e) {}
  }

  void goBack() {
    Navigator.pop(context);
  }

  void setStartTime(DateTime time) {
    startTime = time;
    startTimestamp = time.millisecondsSinceEpoch.toString();
    startTimeController.text = '${time.day}/${time.month}/${time.year} '
        ' ${time.hour}:${time.minute}';
    twoHoursFromStart = DateTime.fromMillisecondsSinceEpoch(
        time.add(const Duration(hours: 2)).millisecondsSinceEpoch ~/
            1000 *
            1000);
    startTimeSet = true;
    setEndTime(twoHoursFromStart);
  }

  void setEndTime(DateTime time) {
    endTime = time;
    endTimestamp = time.millisecondsSinceEpoch.toString();
    endTimeController.text = '${time.day}/${time.month}/${time.year} '
        ' ${time.hour}:${time.minute}';
  }

  var index = 0;
  var maxIndex = 1;

List<StepperData> stepperData() {
  List<StepperData> steppers = [];
  
  for (int currentIndex = 0; currentIndex <= maxIndex; currentIndex++) {
    steppers.add(
      StepperData(
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: index >= currentIndex
                ? AppColors.orangeColorShade500
                : AppColors.grayColor,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Center(
            child: Text(
              "${currentIndex + 1}",
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: AppColors.whiteColor
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  return steppers;
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Headers()
          .getBackHeader(context, StringConstants.headingCreateGame),
      body: Form(
        key: _formKey,
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: AnotherStepper(
            stepperList: stepperData(),
            stepperDirection: Axis.horizontal,
            iconWidth: 40,
            iconHeight: 40,
            activeBarColor: AppColors.orangeColorShade500,
            inActiveBarColor: AppColors.grayColor,
            inverted: true,
            verticalGap: 30,
            activeIndex: index,
            barThickness: 8,
          ),
        ),
        customHeight(10),
          
        (index == 0)
        ? Column(
            children: [
              CustomTextFormField(
                label: StringConstants.nameLabel,
                keyboardType: TextInputType.name,
                hintText: StringConstants.nameHint,
                validator: (value) => Validators.validateRequired(
                    value!, StringConstants.nameErrorValue),
                controller: nameController,
              ),
              // locationSearchBar,
              CustomTextFormField(
                label: StringConstants.startDateTimeLabel,
                hintText: StringConstants.startDateTimeHint,
                keyboardType: TextInputType.datetime,
                controller: startTimeController,
                isSuffixIcon: true,
                validator: (value) => Validators.validateRequired(
                    value!, StringConstants.startDateTimeErrorValue),
                suffixIcon: IconButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          onChanged: (date) {}, onConfirm: (date) {
                        setStartTime(date);
                      },
                          currentTime:
                              !startTimeSet ? rightNow : startTime);
                    },
                    icon: const Icon(Icons.calendar_today_outlined)),
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      onChanged: (date) {}, onConfirm: (date) {
                    setStartTime(date);
                  }, currentTime: !startTimeSet ? rightNow : startTime);
                },
              ),
              CustomTextFormField(
                label: StringConstants.endDateTimeLabel,
                hintText: StringConstants.endDateTimeHint,
                controller: endTimeController,
                keyboardType: TextInputType.datetime,
                isSuffixIcon: true,
                validator: (value) => Validators.validateRequired(
                    value!, StringConstants.endDateTimeErrorValue),
                suffixIcon: IconButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          onChanged: (date) {}, onConfirm: (date) {
                        setEndTime(date);
                      },
                          currentTime:
                              !startTimeSet ? rightNow : startTime);
                    },
                    icon: const Icon(Icons.calendar_today_outlined)),
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      onChanged: (date) {}, onConfirm: (date) {
                    setEndTime(date);
                  }, currentTime: !startTimeSet ? rightNow : startTime);
                },
              ),
              CustomTextFormField(
                label: StringConstants.priceLabel,
                hintText: StringConstants.priceHint,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                controller: priceController,
                validator: (value) => Validators.validateRequired(
                    value!, StringConstants.priceErrorValue),
              ),
            ],
          )
        : (index == 1)
            ? Column(
                children: [
                  locationSearchBar,
                  createEventRequestWidget,
                  createEventPaymentWidget,
                  createTeamRequestWidget,
                  createTeamPaymentWidget,
                ],
              ) :
            
       
        customHeight(50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.2,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: FloatingActionButton.extended(
                isExtended: true,
                label: Text(
                  (index == 0)
                      ? StringConstants.cancelBtn
                      : StringConstants.backBtn,
                  style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                backgroundColor: AppColors.orangeColorShade500,
                onPressed: () {
                  (index == 0)
                      ? Navigator.of(context).pop()
                      : setState(() {
                          index = index - 1;
                        });
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.2,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: FloatingActionButton.extended(
                isExtended: true,
                label: Text(
                  (index == maxIndex)
                      ? StringConstants.createGameBtn
                      : StringConstants.nextBtn,
                  style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                backgroundColor: AppColors.orangeColorShade500,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    (index == maxIndex)
                        ? {createPickupGame(), goBack()}
                        : setState(() {
                            index = index + 1;
                          });
                  }
                },
              ),
            ),
          ],
        ),
        customHeight(20),

        // Container(
        //   child: Text,
        //   decoration: BoxDecoration(color: Colors.amber),
        // )

        // TextField(
        //   controller: nameController,
        //   decoration: new InputDecoration.collapsed(hintText: 'Name'),
        // ),
        //       TextField(
        // controller: hometeamController,
        // decoration: new InputDecoration.collapsed(hintText: 'Home'),
        //       ),
        //       locationSearchBar,
        //       createEventRequestWidget,
        //       createEventPaymentWidget,
        //       createTeamRequestWidget,
        //       createTeamPaymentWidget,
        // dateTimePicker,
        //       TextField(
        // controller: priceController,
        // decoration: new InputDecoration.collapsed(hintText: 'Price'),
        //       ),
        //       TextField(
        // controller: awayteamController,
        // decoration: new InputDecoration.collapsed(hintText: 'Away'),
        //       ),
        //       TextField(
        // controller: isPickupController,
        // decoration: new InputDecoration.collapsed(hintText: 'Pickup'),
        //       ),
        //       TextField(
        // controller: surfaceController,
        // decoration: new InputDecoration.collapsed(hintText: 'Surface'),
        //       ),
        //       TextField(
        // controller: fieldSizeController,
        // decoration: new InputDecoration.collapsed(hintText: 'Field Size'),
        //       ),
        //       TextField(
        // controller: privateController,
        // decoration: new InputDecoration.collapsed(hintText: 'Private'),
        //       ),
        //       TextField(
        // controller: imageController,
        // decoration: new InputDecoration.collapsed(hintText: 'Images'),
        //       ),

        //     GestureDetector(
        // onTap: () {
        //   createPickupGame();
        // },
        // child: Text("Create")),
        //     GestureDetector(
        // onTap: () {
        //   goBack();
        // },
        // child: Text("Back to Home")),
      ]),
        ),
      ),
    );
  }
}
