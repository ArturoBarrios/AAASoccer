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
import 'package:soccermadeeasy/views/splash_screen.dart';

import 'package:soccermadeeasy/utils.dart';
import 'package:soccermadeeasy/widgets/intl_phone_number_filed.dart';
import 'commands/base_command.dart';
import 'commands/player_command.dart';
import 'models/pageModels/app_model.dart';
import 'models/pageModels/chat_page_model.dart';
import 'models/pageModels/event_page_model.dart';
import 'models/pageModels/team_page_model.dart';
import 'models/user_model.dart';
import 'models/events_model.dart';
import 'models/componentModels/payment_model.dart';
import 'models/requests_model.dart';
import 'models/pageModels/requests_page_model.dart';
import 'services/fauna_db_services.dart';
import 'services/geolocation_services.dart';
import 'services/amplify_auth_service.dart' as AmplifyAuth;
import 'views/home.dart';
import 'commands/base_command.dart' as Commands;
import 'components/Loading/loading_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await diInit();
  print("environment: ");
  print(dotenv.env['ENVIRONMENT']);

  dynamic createFaunaClientResp = await FaunaDBServices().createFaunaClient();
  ValueNotifier<GraphQLClient> client = createFaunaClientResp['client'];
  await NetworkServices().enableLocationService();
  await OneSignalService().configureOneSignal();
  await StripeServices().configureStripeService();
  print("===============================================");

  runApp(MyApp(client: client));
}

class MyApp extends StatefulWidget {
  final ValueNotifier<GraphQLClient> client;

  const MyApp({Key? key, required this.client}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final amplifyAuthService = AmplifyAuthService();
  final formKey = GlobalKey<FormState>();
  final navigatorKey = GlobalKey<NavigatorState>();
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
  final genderController = TextEditingController();
  final addressController = TextEditingController();
  final confirmSignInValueController = TextEditingController();

  @override
  void initState() {
    super.initState();

    print("initState");
    configureApp();
  }

  Future<void> configureApp() async {
    Map<String, dynamic> configureAmplifyResp = await configureAmplify();
    print("configureAmplifyResp: ");
    print(configureAmplifyResp);

    if (configureAmplifyResp['message'] == "isSignedIn") {
      emailController.text = configureAmplifyResp['email'];
      await startLoadToHomeTransition();
    }
  }

  Future configureGraphQL() async {
    print("configureGraphQL");
    await initHiveForFlutter();
    final HttpLink httpLink = HttpLink(
      'https://neat-sunfish-45.hasura.app/v1/graphql',
    );

    final AuthLink authLink = AuthLink(
      getToken: () async =>
          'Bearer xqxOjEQssWDUtt1ULO24E4wSsbuMBWpdVDSPk5R5UCFrJGsdpx3y5H2XV1t5ONdF',
    );

    final Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    print("graphQL clientt: ");
    print(client);
    BaseCommand().setupFaunaClient(client);
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
        emailController,
        passwordController,
      );
      print("signInRes: ${signInRes.nextStep!.signInStep}");
      String signInStep = signInRes.nextStep!.signInStep;
      AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(signInStep, state);
      //should probably make sure you're actually signed in
      //assumes you are atm
      UserModel().userEmail = emailController.text.trim();
      await startLoadToHomeTransition();

      setState(() {});
    } on AuthException catch (e) {
      print("SigninException: ");
      print(e);
      AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(e.message, state);
    }
  }

  Future<void> signUp(AuthenticatorState state) async {
    try {
      Map<String, dynamic> userInput = {
        "email": emailController.text.trim(),
        "username": usernameController.text.trim(),
        "phone": phoneNumber!.phoneNumber,
        "birthdate": birthdateController.text.trim(),
        "gender": genderController.text.trim(),
        "address": addressController.text.trim(),
        "status": "SignedUp"
      };
      //check unique attributes
      bool uniquenessUserAttributesCheckResponse =
          await BaseCommand().uniquenessUserAttributesCheck(userInput);
      if (uniquenessUserAttributesCheckResponse) {
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

        String signUpStep = signUpRes.nextStep.signUpStep;
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

        AppModel().currentUser = createPlayerResp['data'];
        print("AppModel().currentUser: ${AppModel().currentUser}");

        await startLoadToHomeTransition();
      } else {
        print("createUserAttributesCheck failed");
      }
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
      await BaseCommand().setupUser(emailController.text.trim());
      BaseCommand().initialUserConditionsMet();

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
      String signInStep = confirmSignInRes.nextStep.signUpStep;
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

  @override
  Widget build(BuildContext _) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => AppModel()),
        ChangeNotifierProvider(create: (c) => UserModel()),
        ChangeNotifierProvider(create: (c) => EventsModel()),        
        ChangeNotifierProvider(create: (c) => EventPageModel()),
        ChangeNotifierProvider(create: (c) => TeamPageModel()),        
        ChangeNotifierProvider(create: (c) => RequestsPageModel()),        
        ChangeNotifierProvider(create: (c) => ChatPageModel()),
        ChangeNotifierProvider(create: (c) => HomePageModel()),
        ChangeNotifierProvider(create: (c) => PaymentModel()),
        Provider(create: (c) => FaunaDBServices()),
        Provider(create: (c) => GeoLocationServices()),
      ],
      child: Builder(
        builder: (context) {
          Commands.init(context);
          bool userConditionsMet = context
              .select<AppModel, bool>((value) => value.userConditionsMet);
          return Authenticator(
            authenticatorBuilder:
                (BuildContext context, AuthenticatorState state) {
              const padding =
                  EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16);
              switch (state.currentStep) {
                case AuthenticatorStep.signIn:
                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Welcome Back",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 50),
                              TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              IntlPhoneNumberFiled(
                                controller: phoneController,
                                initialValue: phoneNumber?.phoneNumber,
                                onInputChanged: (ph) {
                                  phoneNumber = ph;
                                },
                                labelText: "Phone",
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue, // background color
                                  onPrimary: Colors.white, // foreground color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                ),
                                onPressed: () {
                                  signIn(state);
                                },
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(fontSize: 20),
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
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () => continueAsGuest(state),
                                    child: const Text(
                                      'Continue as Guest',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                case AuthenticatorStep.signUp:
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      title: const Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    body: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
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
                                hintText: 'Email',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: usernameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Username',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            IntlPhoneNumberFiled(
                              controller: phoneController,
                              initialValue: phoneNumber?.phoneNumber,
                              onInputChanged: (ph) {
                                phoneNumber = ph;
                              },
                              labelText: "Phone",
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
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
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
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
                                hintText: 'Birthdate',
                                helperText: "mm-dd-yyyy",
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: genderController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Gender',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue, // background color
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
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have an account?'),
                                TextButton(
                                  onPressed: () => state
                                      .changeStep(AuthenticatorStep.signIn),
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () => continueAsGuest(state),
                                  child: const Text(
                                    'Continue as Guest',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
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
              home: userConditionsMet
                  ? AppScaffold(client: widget.client)
                  : SplashScreen(),
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
  const AppScaffold({Key? key, required this.client}) : super(key: key);

  final dynamic client;

  //assumes email's been set in AppModel
  //assumes user's been created in FaunaDB
  //assumes you're signed in/up

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
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  initState() {
    print("AppScaffoldState main.dart");
    super.initState();
    widget.loadPlayerDetails();
  }

  @override
  Widget build(BuildContext context) {
    // Bind to AppModel.currentUser
    Map<String, dynamic> currentUser = context
        .select<AppModel, Map<String, dynamic>>((value) => value.currentUser);

    bool isSignedIn =
        context.select<AppModel, bool>((value) => value.isSignedIn);

    bool initialConditionsMet =
        context.select<AppModel, bool>((value) => value.initialConditionsMet);

    bool isDialogueViewOpened = context
        .select<HomePageModel, bool>((value) => value.isDialogueViewOpened);
    print("isSignedINnnnn: ");
    print(isSignedIn);
    // Return the current view, based on the currentUser value:
    return Scaffold(

        //replace first condition with loading screen
        body: initialConditionsMet == false ? SplashScreen() : Home());
  }
}
