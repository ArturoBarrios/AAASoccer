import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soccermadeeasy/components/Dialogues/animated_dialogue.dart';
import 'package:soccermadeeasy/models/home_page_model.dart';

import 'amplifyconfiguration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'commands/base_command.dart';
import 'commands/user_command.dart';
import 'commands/player_command.dart';
import 'commands/event_command.dart';
import 'models/app_model.dart';
import 'models/chat_page_model.dart';
import 'models/user_model.dart';
import 'models/events_model.dart';
import 'models/payment_model.dart';
import 'models/requests_model.dart';
import 'models/requests_page_model.dart';
import 'models/friends_page_model.dart';
import 'models/games_model.dart';
import 'services/user_service.dart';
import 'services/fauna_db_services.dart';
import 'services/geolocation_services.dart';
import 'services/twilio_services.dart';
import 'services/amplify_auth_service.dart' as AmplifyAuth;
import 'views/home.dart';

import 'commands/base_command.dart' as Commands;
import 'components/Loading/loading_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import '../components/bottom_nav.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:twilio_flutter/twilio_flutter.dart'; 
// import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_stripe/flutter_stripe.dart'; 
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../views/onboarding.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  print("environment: ");
  print(dotenv.env['ENVIRONMENT']);

    await initHiveForFlutter();
    final HttpLink httpLink = HttpLink(
      'https://neat-sunfish-45.hasura.app/v1/graphql',
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer fnAEwyiZocACT1B4JJ2YkT2yPqdbIBgQz55x7a-0',
    );

    final Link link = authLink.concat(httpLink);
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );
    print("graphQL client: ");
    print(client);

  Location location = new Location();
  //this sometimes works and sometimes doesn't. Figure it out!
  // _locationData = await location.getLocation();
  // print("locationData: "+_locationData.latitude.toString() + _locationData.longitude.toString());

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  print("_serviceEnabled: "+_serviceEnabled.toString());
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      
    }
  }

  _permissionGranted = await location.hasPermission();
  print("permissionGranted: "+_permissionGranted.toString());
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      
    }
  }   


  

  //Remove this method to stop OneSignal Debugging 
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("aeb22176-60a9-4077-b161-69381a79fa94");

  // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
  });
     
      print("set publishable key: "+dotenv.env['STRIPE_PUBLISHABLE_KEY']!);
      Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
      Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
      Stripe.urlScheme = 'flutterstripe';
      await Stripe.instance.applySettings();
    // try{
    //   await Adapty().activate();
    // } on AdaptyError catch (AdaptyError) {}
  runApp(MyApp(client: client));


}

class MyApp extends StatefulWidget {
  final ValueNotifier<GraphQLClient> client;

  const MyApp({Key? key, required this.client }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final amplifyAuthService = AmplifyAuthService();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final birthdateController = TextEditingController();
  final genderController = TextEditingController();
  final addressController = TextEditingController();
  final confirmSignInValueController = TextEditingController();

  late TabController _tabController;



  @override
  void initState() {
    super.initState();

    print("initState");
    configureApp();
  }

  void configureApp() async {
    /////////////////////////addback in when shortcode is ready
    Map<String, dynamic> configureAmplifyResp = await configureAmplify();
    // print("configureAmplifyResp: ");
    // print(configureAmplifyResp);
     
    //  if (configureAmplifyResp['message'] == "isSignedIn") {
      // emailController.text = configureAmplifyResp['email'];      
      await startLoadToHomeTransition();   
    // }    
  }

  Future configureGraphQL() async{
    print("configureGraphQL");
    await initHiveForFlutter();
    final HttpLink httpLink = HttpLink(
      'https://neat-sunfish-45.hasura.app/v1/graphql',
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer xqxOjEQssWDUtt1ULO24E4wSsbuMBWpdVDSPk5R5UCFrJGsdpx3y5H2XV1t5ONdF',
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
    // AppModel().faunaClient = client;


  }

  Future <Map<String, dynamic>> configureAmplify() async {    
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
    Map<String, dynamic> otherConfigurationsResp = {"success": true, "message": "successfully configured other shit"};
    AppModel().amplifyConfigured = true;
    Commands.BaseCommand().setIsSigned(true);
    await Commands.BaseCommand().setupInitialAppConfigs();
 //camera
    
    // Get a specific camera from the list of available cameras.
    // final firstCamera = cameras.first;
    return otherConfigurationsResp;
    
  }



  void signOut(AuthenticatorState state) async {
    try {
      await Amplify.Auth.signOut(options: SignOutOptions(globalSignOut: true));
      //base_command set initial app models to reflect signout
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  void signIn(AuthenticatorState state) async {
    try {
      SignInResult signInRes = await AmplifyAuth.AmplifyAuthService.signIn(
          emailController, passwordController);
      print("signInRes: " + signInRes.nextStep!.signInStep);
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

  void signUp(AuthenticatorState state) async {
    try {
      SignUpResult signUpRes = await AmplifyAuth.AmplifyAuthService.signUp(
          emailController,
          passwordController,
          usernameController,
          phoneController,
          birthdateController,
          genderController,
          addressController);
      print("signedUpRes nextStep: ");
      print(signUpRes.nextStep);
      print("signUpRes toString()");
      print(signUpRes.toString());
      String signUpStep = signUpRes.nextStep.signUpStep;
      AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(signUpStep, state);
      
      // await BaseCommand().setupInitialAppModels(emailController.text.trim());
      // await UserCommand()
      //     .updateUserStatus(emailController.text.trim(), "SignedUp");
      Map<String, dynamic> userInput = {
        "email": emailController.text.trim(),
        "username": usernameController.text.trim(),
        "phone": phoneController.text.trim(),
        "birthdate": birthdateController.text.trim(),
        "gender": genderController.text.trim(),
        "address": addressController.text.trim(),
        "status": "SignedUp"
      };      
      Map<String, dynamic> locationInput = {"latitude": 0, "longitude": 0};      
      Map<String, dynamic> createPlayerResp = await PlayerCommand().createPlayer(userInput, {}, locationInput, false);
      print("createPlayerResp: ");
      print(createPlayerResp);
      
      AppModel().currentUser = createPlayerResp['data'];
      print("AppModel().currentUser: " + AppModel().currentUser.toString());
        
      await startLoadToHomeTransition();
    } on AuthException catch (e) {
      print("signUpError");
      print(e);
      AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(e.message, state);
    }
  }

  //assumes email's been set in AppModel
  //assumes user's been created in FaunaDB
  //assumes you're signed in/up
  Future<void> startLoadToHomeTransition() async {
    print("startLoadToHomeTransition");
    await TwilioServices().configureTwilio();    
    Map<String, dynamic> otherConfigurationResp = await otherConfigurations();
    if(otherConfigurationResp['success']){
      /////////////////////////addback in when shortcode is ready
      await BaseCommand().setupInitialAppModels('a@a.com');      
      // await BaseCommand().setupInitialAppModels(emailController.text.trim());      
      BaseCommand().initialConditionsMet();
      print("initialConditionsMett");
    }    
    else{
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
      print("confirmSignInmain.dart: " + signInStep);
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
    return 
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c) => AppModel()),
          ChangeNotifierProvider(create: (c) => UserModel()),
          ChangeNotifierProvider(create: (c) => EventsModel()),
          ChangeNotifierProvider(create: (c) => GamesModel()),
          ChangeNotifierProvider(create: (c) => RequestsModel()),
          ChangeNotifierProvider(create: (c) => RequestsPageModel()),
          ChangeNotifierProvider(create: (c) => FriendsPageModel()),
          ChangeNotifierProvider(create: (c) => ChatPageModel()),
          ChangeNotifierProvider(create: (c) => HomePageModel()),
          ChangeNotifierProvider(create: (c) => PaymentModel()),
          Provider(create: (c) => FaunaDBServices()),          
          Provider(create: (c) => GeoLocationServices()),
          
        ],
        child: Builder(builder: (context) {
          Commands.init(context);

          return MaterialApp(
            title: 'hi', 
            home: Builder(builder: (BuildContext context){
              return AppScaffold();
            })
          );
          /////////////////////////addback in when shortcode is ready
          /////////////////////////remove back
          // Save a context our Commands can use to access provided Models and Services
          // return authenticated user, create or update user in model
          // return Authenticator(
          //     authenticatorBuilder:
          //         (BuildContext context, AuthenticatorState state) {
          //       const padding =
          //           EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16);
          //       switch (state.currentStep) {
          //         case AuthenticatorStep.signIn:
          //           return Scaffold(
          //             body: Padding(
          //               padding: padding,
          //               child: SingleChildScrollView(
          //                 child: Column(
          //                   children: [
          //                     //todo
          //                     //create switch to switch between login and signup
          //                     //onpress function that creates creates/updates cognito user
          //                     TextField(
          //                       controller: emailController,
          //                       decoration: new InputDecoration.collapsed(
          //                           hintText: 'Email'),
          //                     ),
          //                     TextField(
          //                       controller: phoneController,
          //                       decoration: new InputDecoration.collapsed(
          //                           hintText: 'Phone'),
          //                     ),
          //                     TextField(
          //                       controller: passwordController,
          //                       decoration: new InputDecoration.collapsed(
          //                           hintText: 'Password'),
          //                     ),

          //                     ElevatedButton(
          //                       style: ElevatedButton.styleFrom(
          //                         primary: Colors.blue, // background
          //                         onPrimary: Colors.white, // foreground
          //                       ),
          //                       //emailController, passwordController
          //                       onPressed: () {
          //                         signIn(state);
          //                       },
          //                       child: Text('Sign In'),
          //                     )
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             // custom button to take the user to sign up
          //             persistentFooterButtons: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   const Text('Don\'t have an account?'),
          //                   TextButton(
          //                     onPressed: () => state.changeStep(
          //                       AuthenticatorStep.signUp,
          //                     ),
          //                     child: const Text('Sign Up'),
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           );
          //         case AuthenticatorStep.signUp:
          //           return Scaffold(
          //             body: Padding(
          //               padding: padding,
          //               child: SingleChildScrollView(
          //                 child: Column(
          //                   children: [
          //                     // app logo
          //                     const Center(child: FlutterLogo(size: 100)),
          //                     // prebuilt sign up form from amplify_authenticator package

          //                     TextField(
          //                       controller: emailController,
          //                       decoration: new InputDecoration.collapsed(
          //                           hintText: 'Email'),
          //                     ),

          //                     TextField(
          //                       controller: usernameController,
          //                       decoration: new InputDecoration.collapsed(
          //                           hintText: 'Username'),
          //                     ),
          //                     TextField(
          //                       controller: phoneController,
          //                       decoration: new InputDecoration.collapsed(
          //                           hintText: 'Phone'),
          //                     ),
          //                     TextField(
          //                       controller: passwordController,
          //                       decoration: new InputDecoration.collapsed(
          //                           hintText: 'Password'),
          //                     ),
          //                     TextField(
          //                       controller: birthdateController,
          //                       decoration: new InputDecoration.collapsed(
          //                           hintText: 'Birthdate'),
          //                     ),
          //                     TextField(
          //                       controller: genderController,
          //                       decoration: new InputDecoration.collapsed(
          //                           hintText: 'Gender'),
          //                     ),
          //                     TextField(
          //                       controller: addressController,
          //                       decoration: new InputDecoration.collapsed(
          //                           hintText: 'Address'),
          //                     ),

          //                     ElevatedButton(
          //                       style: ElevatedButton.styleFrom(
          //                         primary: Colors.blue, // background
          //                         onPrimary: Colors.white, // foreground
          //                       ),
          //                       //emailController, passwordController, usernameController, phoneController
          //                       onPressed: () {
          //                         signUp(state);
          //                       },
          //                       child: Text('Sign Up'),
          //                     )
          //                     // SignUpForm.custom(
          //                     //   fields: [
          //                     //     SignUpFormField.username(),
          //                     //     SignUpFormField.email(required: true),
          //                     //     SignUpFormField.phoneNumber(),
          //                     //     SignUpFormField.password(),

          //                     //   ],

          //                     // ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             // custom button to take the user to sign in
          //             persistentFooterButtons: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   const Text('Already have an account?'),
          //                   TextButton(
          //                     onPressed: () => state.changeStep(
          //                       AuthenticatorStep.signIn,
          //                     ),
          //                     child: const Text('Sign In'),
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           );
          //         case AuthenticatorStep.confirmSignUp:
          //           return Scaffold(
          //             body: Padding(
          //               padding: padding,
          //               child: SingleChildScrollView(
          //                 child: Column(
          //                   children: [
          //                     // app logo
          //                     const Center(child: FlutterLogo(size: 100)),
          //                     // prebuilt sign up form from amplify_authenticator package

          //                     TextField(
          //                       controller: confirmSignInValueController,
          //                       decoration: new InputDecoration.collapsed(
          //                           hintText: 'Confirmation Code'),
          //                     ),

          //                     ElevatedButton(
          //                       style: ElevatedButton.styleFrom(
          //                         primary: Colors.blue, // background
          //                         onPrimary: Colors.white, // foreground
          //                       ),
          //                       //emailController, passwordController, usernameController, phoneController
          //                       onPressed: () {
          //                         confirmSignIn(state);
          //                       },
          //                       child: Text('Confirm'),
          //                     )
          //                     // SignUpForm.custom(
          //                     //   fields: [
          //                     //     SignUpFormField.username(),
          //                     //     SignUpFormField.email(required: true),
          //                     //     SignUpFormField.phoneNumber(),
          //                     //     SignUpFormField.password(),

          //                     //   ],

          //                     // ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             // custom button to take the user to sign in
          //             persistentFooterButtons: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   const Text('Already have an account?'),
          //                   TextButton(
          //                     onPressed: () => state.changeStep(
          //                       AuthenticatorStep.signIn,
          //                     ),
          //                     child: const Text('Sign In'),
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           );
          //         default:
          //           // returning null defaults to the prebuilt authenticator for all other steps
          //           return null;
          //       }
          //     },
          //     child: 
              
          //     MaterialApp(
          //         builder: Authenticator.builder(), home: AppScaffold()));
        }),
      );
  }
}

class AppScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Bind to AppModel.currentUser
    Map<String, dynamic> currentUser =
        context.select<AppModel, Map<String, dynamic>>((value) => value.currentUser);

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
      body: initialConditionsMet == false ? 
        Container(
            height: double.infinity,
            width: double.infinity,
            child:Align(
              alignment: Alignment.center,
              child: 
              // BottomNav()//for times when user deleted in cognito but still signed into app
              LoadingScreen(currentDotColor: Colors.white, defaultDotColor: Colors.black, numDots: 10)
            )
          ) 
          : Home(),
      // body: currentUser != "" ?  Home() : LoginPage(),
    );
  }
}
