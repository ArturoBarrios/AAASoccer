import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:soccermadeeasy/data/services/twilio/twilio_service.dart';
import 'package:soccermadeeasy/di/di_init.dart';
import 'package:soccermadeeasy/models/pageModels/home_page_model.dart';
import 'package:soccermadeeasy/services/network_services.dart';
import 'package:soccermadeeasy/services/onesignal_service.dart';
import 'package:soccermadeeasy/services/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/strings.dart';
import 'package:soccermadeeasy/styles/colors.dart';
import 'package:soccermadeeasy/views/onboarding/onboarding_view.dart';
import 'package:soccermadeeasy/views/splash_screen.dart';

import 'package:soccermadeeasy/utils.dart';
import 'package:soccermadeeasy/widgets/intl_phone_number_filed.dart';
import 'commands/base_command.dart';
import 'commands/player_command.dart';
import 'components/Validator.dart';
import 'components/custom_textfield.dart';
import 'components/headers.dart';
import 'components/logo_text.dart';
import 'components/models/button_model.dart';
import 'models/enums/GenderType.dart';
import 'models/pageModels/app_model.dart';
import 'models/pageModels/chat_page_model.dart';
import 'models/pageModels/events_page_model.dart';
import 'models/pageModels/event_page_model.dart';
import 'models/pageModels/group_page_model.dart';
import 'models/pageModels/profile_page_model.dart';
import 'models/pageModels/team_page_model.dart';
import 'models/user_model.dart';
import 'models/events_model.dart';
import 'models/componentModels/payment_model.dart';
import 'models/requests_model.dart';
import 'models/pageModels/requests_page_model.dart';
import 'services/geolocation_services.dart';
import 'services/amplify_auth_service.dart' as AmplifyAuth;
import 'views/home.dart';
import 'commands/base_command.dart' as Commands;
import 'components/Loading/loading_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  Locale locale = Locale('en');
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await diInit();
  print("environment: ");
  print(dotenv.env['ENVIRONMENT']);

    
  await NetworkServices().enableLocationService();
  await OneSignalService().configureOneSignal();
  await StripeServices().configureStripeService();
  print("===============================================");  
  

  runApp(MyApp());
}

class MyApp extends StatefulWidget {  

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final amplifyAuthService = AmplifyAuthService();
  final formKey = GlobalKey<FormState>();
  final navigatorKey = GlobalKey<NavigatorState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  PhoneNumber? phoneNumber;
  final birthdateController = TextEditingController();
  final birthdateFormatter = MaskTextInputFormatter(
    mask: 'mm-dd-yyyy',
    filter: {
      "m": RegExp(r'[0-9]'),
      "d": RegExp(r'[0-9]'),
      "y": RegExp(r'[0-9]'),
    },
    type: MaskAutoCompletionType.lazy,
  );

  DateTime birthdayTime = DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
  String birthdateTimestamp = DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day).millisecondsSinceEpoch.toString();


  final genderController = TextEditingController();  
  List<String> get genderOptions => GenderType.values.map((e) => e.name).toList();
  String? selectedGender;
  final addressController = TextEditingController();
  final confirmSignInValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("genderOptions: $genderOptions");

    print("initState");
    configureApp();
  }

  Future<void> configureApp() async {
    Map<String, dynamic> configureAmplifyResp = await configureAmplify();
    print("configureAmplifyResp: ");
    print(configureAmplifyResp);

    if (configureAmplifyResp['message'] == "isSignedIn") {
      emailController.text = configureAmplifyResp['email'];
      BaseCommand().setLoggedIn(true);
      await startLoadToHomeTransition();
    }
  }

  
  Future<Map<String, dynamic>> configureAmplify() async {
    Map<String, dynamic> configureAmplify =
        await AmplifyAuth.AmplifyAuthService.configureAmplify();
    setState(() {
      if (configureAmplify['success']) {
        print("configured amplify!");
        print(configureAmplify);
      }
    });
    return configureAmplify;
  }

//handle location here???
  Future<Map<String, dynamic>> otherConfigurations() async {
    print("otherConfigurations");
    Map<String, dynamic> otherConfigurationsResp = {
      "success": true,
      "message": "successfully configured other shit"
    };
    AppModel().amplifyConfigured = true;
    Commands.BaseCommand().setIsSigned(true);

    return otherConfigurationsResp;
  }

  void continueAsGuest(AuthenticatorState state) async {
    print("continueAsGuest");
    BaseCommand().setIsGuest(true);
    AmplifyAuth.AmplifyAuthService.skipVerifyUser(state);
    await startLoadToHomeTransition();
  }

  void signOut(AuthenticatorState state) async {
    try {
      await Amplify.Auth.signOut(
          options: const SignOutOptions(globalSignOut: true));
      //base_command set initial app models to reflect signout
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> signIn(AuthenticatorState state) async {
    try {
      SignInResult signInRes = await AmplifyAuth.AmplifyAuthService.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      print("signInRes: ${signInRes.nextStep!.signInStep}");
      
      String signInStep = signInRes.nextStep!.signInStep.name;
      AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(signInStep, state);
      //should probably make sure you're actually signed in
      //assumes you are atm
      UserModel().userEmail = emailController.text.trim();
      await startLoadToHomeTransition();
      BaseCommand().setLoggedIn(true);

      setState(() {});
    } on AuthException catch (e) {
      print("SigninException: ");
      print(e);
      AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(e.message, state);
    }
  }

  Future<void> signUp(AuthenticatorState state) async {
    try {
      print("signUp");
      Map<String, dynamic> userInput = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "username": usernameController.text.trim(),
        "phone": phoneNumber!.phoneNumber,
        "birthdate": birthdateController.text.trim(),
        "gender": genderController.text.trim(),
        "address": addressController.text.trim(),
        "status": "SignedUp"
      };
      //check unique attributes
      // bool uniquenessUserAttributesCheckResponse =
      //     await BaseCommand().uniquenessUserAttributesCheck(userInput);
      // if (uniquenessUserAttributesCheckResponse) {
        SignUpResult signUpRes = await AmplifyAuth.AmplifyAuthService.signUp(
          emailController,
          passwordController,
          usernameController,
          phoneNumber!.phoneNumber,
          birthdateController,
          genderController,
          addressController,
        );

        print("signedUpRes nextStep: ");
        print(signUpRes.nextStep);
        print("signUpRes toString()");
        print(signUpRes.toString());
        print(signUpRes.nextStep.signUpStep);
        print(signUpRes.nextStep.additionalInfo);
        print(signUpRes.nextStep.codeDeliveryDetails?.attributeName);
        print(signUpRes.nextStep.codeDeliveryDetails?.deliveryMedium);
        print(signUpRes.nextStep.codeDeliveryDetails?.destination);

        String signUpStep = signUpRes.nextStep.signUpStep.name;
        AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(
          signUpStep,
          state,
        );
        Map<String, dynamic> locationInput = {
          "latitude": 0,
          "longitude": 0,
        };
        Map<String, dynamic> createPlayerResp =
            await PlayerCommand().createPlayer(
          userInput,
          {},
          locationInput,
          false,
        );
        print("createPlayerResp: ");
        print(createPlayerResp);

        // appModel.currentUser = createPlayerResp['user'];
        // print("AppModel().currentUser: ${AppModel().currentUser}");

        await startLoadToHomeTransition();
      // } 
      // else {
      //   print("createUserAttributesCheck failed");
      // }
    } on AuthException catch (e) {
      print("signUpError");
      print(e);
      AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(e.message, state);
    }
  }

  Future<void> startLoadToHomeTransition() async {
    print("startLoadToHomeTransition");
    // await TwilioServices().configureTwilio();
    Map<String, dynamic> otherConfigurationResp = await otherConfigurations();
    if (otherConfigurationResp['success']) {
      ///////////////////////// add back in when shortcode is ready
      // print("resppp: " + resp.toString());
      // if (resp['success']) {
      Map<String,dynamic> setupUserResp = await BaseCommand().setupUser(emailController.text.trim());
      print("setupUserResp: "+setupUserResp.toString());
      if(setupUserResp['success']){
        dynamic user = setupUserResp['data'];
        BaseCommand().setOnboarded(user['onboarded']);
          
        BaseCommand().initialUserConditionsMet();          
      }

      print("initialConditionsMett");
      // } else {
      //   print("try again....");

      // }
    } else {
      print("error in startLoadToHomeTransition");
    }
  }

  void confirmSignIn(AuthenticatorState state) async {
    try {
      SignUpResult confirmSignInRes =
          await AmplifyAuth.AmplifyAuthService.confirmSignUp(
              confirmSignInValueController.text.trim(),
              emailController.text.trim());

      print(confirmSignInRes.toString());
      String signInStep = confirmSignInRes.nextStep.signUpStep.name;
      AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(signInStep, state);
      print("confirmSignInmain.dart: $signInStep");
      final result = await Amplify.Auth.fetchAuthSession();
      print("fetchAuthSession: ");
      print(result);
      final user = await Amplify.Auth.getCurrentUser();
      print("getCurrentUser: ");
      print(user);
    } on AuthException catch (e) {
      print("confirmSignInError");
      print(e);
    }
  }

  void testMethod() async {
    print("testFuncdtion");
    final result = await Amplify.Auth.fetchAuthSession();
    print("fetchAuthSession result");
    print(result);
  }

   void setBirthdayTime(DateTime time) {
    birthdayTime = time;
    birthdateTimestamp = time.millisecondsSinceEpoch.toString();
    birthdateController.text = '${time.day}/${time.month}/${time.year} '
        ' ${time.hour}:${time.minute}';    
  }

  

  @override
  Widget build(BuildContext _) {
    print("build main.dart");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => AppModel()),
        ChangeNotifierProvider(create: (c) => UserModel()),
        ChangeNotifierProvider(create: (c) => EventsModel()),
        ChangeNotifierProvider(create: (c) => EventPageModel()),
        ChangeNotifierProvider(create: (c) => TeamPageModel()),
        ChangeNotifierProvider(create: (c) => GroupPageModel()),
        ChangeNotifierProvider(create: (c) => ProfilePageModel()),
        ChangeNotifierProvider(create: (c) => RequestsModel()),
        ChangeNotifierProvider(create: (c) => RequestsPageModel()),
        ChangeNotifierProvider(create: (c) => ChatPageModel()),
        ChangeNotifierProvider(create: (c) => HomePageModel()),
        ChangeNotifierProvider(create: (c) => PaymentModel()),
        ChangeNotifierProvider(create: (c) => EventsPageModel()),        
        Provider(create: (c) => GeoLocationServices()),
      ],
      child: Builder(
        builder: (context) {
          Commands.init(context);
          bool userConditionsMet = context
              .select<AppModel, bool>((value) => value.userConditionsMet);
          bool loggedIn = context
              .select<AppModel, bool>((value) => value.loggedIn);
          bool onboarded = context
              .select<AppModel, bool>((value) => value.onboarded);

              print("userConditionsMet: "+userConditionsMet.toString());
              print("onboarded: "+onboarded.toString());
          
          return Authenticator(
            authenticatorBuilder:
                (BuildContext context, AuthenticatorState state) {
              const padding =
                  EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 16);
              switch (state.currentStep) {
                case AuthenticatorStep.signIn:
                  return Scaffold(
                    backgroundColor: AppColors.tsnWhite,
                    appBar: Headers(
              playerStepperButton: ButtonModel(
                prefixIconData: Icons.play_circle_fill_rounded,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const OnboardingView();
                    },
                  ));
                },
              ),
              filterButton: ButtonModel(
                prefixIconData: false
                    ? Icons.filter_alt_off
                    : Icons.filter_alt,
                onTap: () => {}
              ),
            ).getMainHeader(context),
                    body: Padding(
                      padding: const EdgeInsets.all(20),
                      child: 
                         SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
        children: [
          
             Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child:                             
                              TextField(
                                controller: emailController,
                                style: TextStyle(color: AppColors.fieldTextInsideDarkFill,),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: AppColors.fieldLabelTextInsideDarkFill,),
                                  filled: true,
                                  fillColor: AppColors.fieldFillDark,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              )))]),
                              const SizedBox(height: 20),
                              Row(
        children: [
             Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child:
                              IntlPhoneNumberFiled(
                                controller: phoneController,
                                initialValue: phoneNumber?.phoneNumber,
                                onInputChanged: (ph) {
                                  phoneNumber = ph;
                                },
                                labelText: "Phone",
                              )))]),
                              const SizedBox(height: 20),
                              Row(
        children: [
             Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child:
                              TextField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                style: TextStyle(color: AppColors.fieldTextInsideDarkFill,),
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: AppColors.fieldLabelTextInsideDarkFill,),
                                  filled: true,
                                  fillColor: AppColors.fieldFillDark,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              )))]),
                              const SizedBox(height: 50),

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.submitFillButton, // background color
                                  onPrimary: Colors.white, // foreground color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                ),
                                onPressed: () async {
                                  await signIn(state);
                                },
                                
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 20, color: AppColors.tsnWhite),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Don\'t have an account?'),
                                  TextButton(
                                    onPressed: () => state
                                        .changeStep(AuthenticatorStep.signUp),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(color: AppColors.linkColor),
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     TextButton(
                              //       onPressed: () => continueAsGuest(state),
                              //       child: const Text(
                              //         'Continue as Guest',
                              //         style: TextStyle(color: AppColors.linkColor),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      
                    ),
                  );

                case AuthenticatorStep.signUp:
                  return Scaffold(
                    appBar: Headers(
              playerStepperButton: ButtonModel(
                prefixIconData: Icons.play_circle_fill_rounded,
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute<void>(
                  //   builder: (BuildContext context) {
                  //     return const OnboardingView();
                  //   },
                  // ));
                },
              ),
              filterButton: ButtonModel(
                prefixIconData: false
                    ? Icons.filter_alt_off
                    : Icons.filter_alt,
                onTap: () => {}
              ),
            ).getMainHeader(context),
                    backgroundColor: AppColors.tsnWhite,
                    body: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child:
                            TextFormField(
                              style: TextStyle(color: AppColors.fieldTextInsideDarkFill,),
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,                              
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                if (!value.isValidEmail) {
                                  return "Please enter a valid Email";
                                }
                                return null;
                              },
                              
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: AppColors.fieldLabelTextInsideDarkFill,),                                                                                                
                                hintText: 'Email',
                                filled: true,                                
                                fillColor: AppColors.fieldFillDark,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,                                  
                                ),
                              ),
                            ),
        ))]),
                            const SizedBox(height: 20),
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
      const SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextFormField(
                style: TextStyle(color: AppColors.fieldTextInsideDarkFill,),
                controller: usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: AppColors.fieldLabelTextInsideDarkFill,),                                                                                                
                  hintText: 'Username',
                  filled: true,
                  fillColor: AppColors.fieldFillDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          )]),
        
                            const SizedBox(height: 20),
                            Row(
        children: [
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


            Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child:
          //     CustomTextFormField(
          //   label: StringConstants.endDateTimeLabel,
          //   hintText: StringConstants.endDateTimeHint,
          //   controller: birthdateController,
          //   keyboardType: TextInputType.datetime,
          //   isSuffixIcon: true,
          //   validator: (value) => Validators.validateRequired(
          //       value!, StringConstants.endDateTimeErrorValue),
          //   suffixIcon: IconButton(
          //       onPressed: () {
          //         DatePicker.showDateTimePicker(context,
          //             showTitleActions: true,
          //             onChanged: (date) {}, onConfirm: (date) {
          //           // setEndTime(date);
          //         }, currentTime: birthdayTime
          //         // !startTimeSet ? rightNow : startTime
          //         );
          //       },
          //       icon: const Icon(Icons.calendar_today_outlined)),
          //   onPressed: () {
          //     DatePicker.showDateTimePicker(context,
          //         showTitleActions: true,
          //         onChanged: (date) {}, onConfirm: (date) {
          //       setBirthdayTime(date);
          //     }, currentTime: birthdayTime
          //     );
          //   },
          // ),
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
                            )
                            )),

            ]),
                            
                            const SizedBox(height: 20),
                            Row(
        children: [
             Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child:
                            IntlPhoneNumberFiled(
                              controller: phoneController,
                              initialValue: phoneNumber?.phoneNumber,
                              onInputChanged: (ph) {
                                phoneNumber = ph;
                              },
                              labelText: "Phone",
                              ),
            ))]),
                            const SizedBox(height: 20),
                            Row(
        children: [
             Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child:
                            TextFormField(
                              style: TextStyle(color: AppColors.fieldTextInsideDarkFill,),
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Password',
                                filled: true,
                                hintStyle: TextStyle(color: AppColors.fieldLabelTextInsideDarkFill,),                                                                                                
                                fillColor: AppColors.fieldFillDark,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            )))]),
                            

                            const SizedBox(height: 50),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.submitFillButton, // background color
                                onPrimary: Colors.white, // foreground color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  signUp(state);
                                }
                              },
                              child: const Text(
                                
                                'Sign Up',
                                style: TextStyle(fontSize: 20, 
                                  color: AppColors.tsnWhite),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have an account?',
                                  style: TextStyle(color: AppColors.tsnBlack)
                                  ),
                                TextButton(
                                  onPressed: () => state
                                      .changeStep(AuthenticatorStep.signIn),
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(color: AppColors.linkColor),
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     TextButton(
                            //       onPressed: () => continueAsGuest(state),
                            //       child: const Text(
                            //         'Continue as Guest',
                            //         style: TextStyle(color: AppColors.linkColor),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );

                case AuthenticatorStep.confirmSignUp:
                  return Scaffold(
                    body: Padding(
                      padding: padding,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // app logo
                            const Center(child: FlutterLogo(size: 100)),
                            // prebuilt sign up form from amplify_authenticator package

                            TextField(
                              controller: confirmSignInValueController,
                              decoration: const InputDecoration.collapsed(
                                  hintText: 'Confirmation Code'),
                            ),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue, // background
                                onPrimary: Colors.white, // foreground
                              ),
                              onPressed: () {
                                confirmSignIn(state);
                              },
                              child: const Text('Confirm'),
                            )
                          ],
                        ),
                      ),
                    ),
                    // custom button to take the user to sign in
                    persistentFooterButtons: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                            onPressed: () => state.changeStep(
                              AuthenticatorStep.signIn,
                            ),
                            child: const Text('Sign In'),
                          ),
                        ],
                      ),
                    ],
                  );
                default:
                  // returning null defaults to the prebuilt authenticator for all other steps
                  return null;
              }
            },
            child: MaterialApp(
              navigatorKey: navigatorKey,
              builder: Authenticator.builder(),
              home: userConditionsMet && onboarded
                  ? AppScaffold() :
                     (userConditionsMet && loggedIn && !onboarded) ?        
                      OnboardingView() : SplashScreen(),
              routes: {
                // When navigating to the "/" route, build the HomeScreen widget.
                '/home': (context) => Home(),
                // When navigating to the "/details" route, build the DetailsScreen widget.
                // '/details': (context) => DetailsScreen(),
                // Add more routes as needed.
              },
            ),
          );
        },
      ),
    );
  }
}

class AppScaffold extends StatefulWidget {
  const AppScaffold({Key? key}) : super(key: key);

  

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  initState() {
    print("AppScaffoldState main.dart");
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
      //  loadPlayerDetails();
    // });
  }

  Future<void> loadPlayerDetails() async {
    print("loadPlayerDetails");
    // await TwilioServices().configureTwilio();

    ///////////////////////// add back in when shortcode is ready
    // print("resppp: " + resp.toString());
    // if (resp['success']) {
    await BaseCommand().setupInitialAppModels();
    BaseCommand().initialConditionsMet();

    print("initialConditionsMett");
    // } else {
    //   print("try again....");

    // }
  }

  @override
  Widget build(BuildContext context) {
    // bool initialConditionsMet =
    //     context.select<AppModel, bool>((value) => value.initialConditionsMet);
// print("initialConditionsMetttttt: "+ initialConditionsMet.toString());
    // Return the current view, based on the currentUser value:
    return Scaffold(

        //replace first condition with loading screen
        body:  const Home());
  }
}
