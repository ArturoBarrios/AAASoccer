import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:soccermadeeasy/views/game/view.dart';
import '../../commands/base_command.dart';
import '../../commands/location_command.dart';
import '../../commands/user_command.dart';
import '../../components/Validator.dart';
import '../../components/image_selection_widget.dart';
import '../../components/create_event_payment.dart';
import '../../components/create_event_request.dart';
import '../../components/create_team_payment.dart';
import '../../components/create_team_request.dart';
import '../../components/custom_stepper.dart';
import '../../components/custom_textfield.dart';
import '../../components/date_time_picker.dart';
import '../../components/headers.dart';
import '../../components/location_search_bar.dart';
import '../../commands/game_command.dart';
import '../../commands/event_command.dart';
import '../../components/models/button_model.dart';
import '../../components/models/custom_stepper_model.dart';
import '../../constants.dart';
import '../../models/enums/AmenityType.dart';
import '../../models/enums/EventType.dart';
import '../../strings.dart';
import '../../styles/colors.dart';
import '../splash_screen.dart';

class GameCreate extends StatefulWidget {
  const GameCreate({Key? key}) : super(key: key);

  @override
  State<GameCreate> createState() => _GameCreateState();
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

  Position currentPosition = Position(
    longitude: 0,
    latitude: 0,
    timestamp: null,
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  List<dynamic> fieldLocations = [];
  dynamic selectedFieldLocation = null;
  
  List<String> selectedHostAmenities = [];
  List<String> selectedFieldAmenities = [];

  final Map<String, dynamic> locationInput = {
    "name": "",
    "latitude": 0,
    "longitude": 0,
  };
  CreateEventRequest createEventRequestWidget = CreateEventRequest();
  CreateEventPayment createEventPaymentWidget = CreateEventPayment();
  CreateTeamPayment createTeamPaymentWidget = CreateTeamPayment();
  CreateTeamRequest createTeamRequestWidget = CreateTeamRequest();
  DateTimePicker dateTimePicker = DateTimePicker();
  late LocationSearchBar locationSearchBar;

  bool isLoading = true;

  @override
  initState() {
    locationSearchBar = LocationSearchBar(
      onCoordinatesChange: (coordinates, address) {
        locationInput['address'] = address;
        locationInput['latitude'] = coordinates.latitude;
        locationInput['longitude'] = coordinates.longitude;
      },
    );
    super.initState();
    loadInitialData();
  }

  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final numberOfTeamsController = TextEditingController();
  final numberOfRoundsPerTeamController = TextEditingController();
  final numberOfTeamsPerGroupController = TextEditingController();
  final roundOfXController = TextEditingController();
  final knockoutRoundsController = TextEditingController();
final teamPriceController = TextEditingController();
  final capacityController = TextEditingController();

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
    try {
      String parsedSelectedHostAmenities = BaseCommand().formatStringForGraphQL(selectedHostAmenities);
      String parsedSelectedFieldAmenities = BaseCommand().formatStringForGraphQL(selectedFieldAmenities);
      print("priceee: ${priceController.text}");
      double priceDouble = double.parse(priceController.text.toString());
      Map<String, dynamic> eventInput = {
        "name": nameController.text.toString(),
        "capacity": capacityController.text.toString(),
        'isMainEvent': true,
        'price': priceDouble,
        'startTime': startTimestamp,
        'endTime': endTimestamp,
        'withRequest': false,//createEventRequestWidget.withRequest.value,
        'withPayment': priceDouble==0 ? false : true, //createEventPaymentWidget.withPayment.value,
        'withTeamPayment': false,
        'withTeamRequest': false,
        'roles': "{PLAYER, ORGANIZER}",
        'createdAt': dateTimePicker.rightNow.millisecondsSinceEpoch.toString(),
        'type': EventType.GAME,
        'hostAmenities': parsedSelectedHostAmenities.toString(),
        'fieldAmenities': parsedSelectedFieldAmenities.toString(),
      };
      dynamic pickupData = {
        "pickup": true,
      };
      print("locationInputCheaheck: $locationInput");

      Map<String, dynamic> createPickupGameResp =
          await GameCommand().createGame(pickupData, eventInput, locationInput);
      print("createPickupGameResp: $createPickupGameResp");

      print(createPickupGameResp['data']);
      if (createPickupGameResp['success']) {
        Map<String, dynamic> createdEvent = createPickupGameResp['data'];
        await EventCommand()
            .updateViewModelsWithEvent(createdEvent, true);

        
          // Navigator.pop(
          //   context,
          // );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => PickupView(
          //       game: createdGame['event'],
          //     ),
          //   ),
          // );
        
      }
    } on ApiException catch (_) {}
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

  int activeStep = 0;

  void changeStepValue(final int value) {
    setState(() {
      if (!value.isNegative) {
        activeStep = value;
      }
    });
  }

  Future<void> onTapCreate() async {
    await createPickupGame();
    goBack();
  }

  void loadInitialData() async{
    print("loadInitialDataaaaa");
    currentPosition = BaseCommand().getAppModelCurrentPosition();
    dynamic getFieldLocationsNearbyInput = {
      "latitude": currentPosition.latitude,
      "longitude": currentPosition.longitude,
      "radius": 1000,
    };
    Map<String,dynamic> getFieldLocationsNearbyResp = await LocationCommand().getFieldLocationsNearby(getFieldLocationsNearbyInput);
    if(getFieldLocationsNearbyResp['success']){
      fieldLocations = getFieldLocationsNearbyResp['data'];
      print("fieldLocations: $fieldLocations");
      setState(() {
        isLoading = false;
      });


    }

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
                  }, currentTime: !startTimeSet ? rightNow : startTime);
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
                  }, currentTime: !startTimeSet ? rightNow : startTime);
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
          CustomTextFormField(
            label: StringConstants.capacityLabel,
            hintText: StringConstants.capacityHint,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: false,
            ),
            controller: capacityController,
            validator: (value) => Validators.validateRequired(
              value!,
              StringConstants.capacityErrorValue,
            ),
          ),
        ],
      ),
      CustomStepperModel(
        widgets: [
          
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0,
                            0, 0),
              child:
                       
//  locationSearchBar,
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
          value: selectedFieldLocation,
          style: TextStyle(color: AppColors.tsnAlmostBlack),
          decoration: InputDecoration.collapsed(hintText: ''),
          items: [
            DropdownMenuItem(
              value: null,
              child: Text(
                'Field Location',
                style: TextStyle(color: AppColors.tsnGrey),
              ),
            ),
            ...fieldLocations.map((dynamic fieldLocation) {
              print("fieldLocationnnnnnn: "+ fieldLocation.toString());
              return DropdownMenuItem(
                key: Key(fieldLocation['location']['_id'].toString()),
                value: fieldLocation['location']['name'].toString()+fieldLocation['location']['_id'].toString(),
                child: Text(
                  fieldLocation['location']['name'].toString(),
                  style: TextStyle(color: AppColors.tsnWhite),
                ),
              );
            }).toList(),
          ],
          onChanged: (String? newValue) {
            setState(() {
              selectedFieldLocation = newValue;
            });
            // genderController.text = newValue ?? '';
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
        ),
         
          createEventRequestWidget,
          createEventPaymentWidget,
          createTeamRequestWidget,
          createTeamPaymentWidget,
        ],
      ),
      CustomStepperModel(
        widgets: [
          ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 300, // You can adjust this height
      ),
      child: ImageSelectionWidget(
        viewMode: false,
        selectionList: Constants.hostAmenities,
        onSelectionChanged: (newSelection) {
          setState(() {
            selectedHostAmenities = newSelection;
          });
        },
      ),
    ),
          ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 300, // You can adjust this height
      ),
      child: ImageSelectionWidget(
        viewMode: false,
        selectionList: Constants.fieldAmenities,
        onSelectionChanged: (newSelection) {
          setState(() {
            selectedFieldAmenities = newSelection;
          });
        },
      ),
    ),
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
      appBar: Headers(
              playerStepperButton: ButtonModel(
                prefixIconData: Icons.play_circle_fill_rounded,
                onTap: () {},
              ),
            ).getMainHeader(context),
      body: 
      isLoading ? SplashScreen() : 
      
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: CustomStepper(
          formKey: _formKey,
          title: (activeStep == (stepperList.length - 1))
              ? 'Complete'
              : 'Create Game',
          stepperModel: stepperList,
          activeStep: activeStep,
          cancelButton: ButtonModel(
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
