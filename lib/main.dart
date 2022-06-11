import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:soccermadeeasy/models/home_page_model.dart';

import 'amplifyconfiguration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'commands/base_command.dart';
import 'commands/user_command.dart';
import 'models/app_model.dart';
import 'models/user_model.dart';
import 'services/user_service.dart';
import 'services/amplify_auth_service.dart' as AmplifyAuth;
import 'views/home_page_temporary.dart';
import 'views/home.dart';

import 'views/login_page.dart';
import 'commands/base_command.dart' as Commands;


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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

  
  bool isSignedIn = false;
  late TabController _tabController;



  @override
  void initState() {
    print("initState");
    super.initState();
    // setupListeners();
    configureAmplify();
    
    
  }


void configureAmplify() async{
  AmplifyAuth.AmplifyAuthService.configureAmplify();
  setState(() {
    AppModel().amplifyConfigured = true;
    
  });
}
void testFunction(){
setState(() {
    AppModel().amplifyConfigured = true;
  });
}

void setupListeners(){
    // AppModel().amplifyConfigured.addListener(() => print("niceeeee"));
  


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
      // signInRes.isSignedIn;

      // setState(() async {
        print("signInRes: " +signInRes.nextStep!.signInStep);
        String signInStep = signInRes.nextStep!.signInStep;
        AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(signInStep, state);
        signInRes.nextStep!.signInStep;
        Map<String, dynamic> setUpResp = await BaseCommand().setupInitialAppModels(emailController.text.trim());
        UserCommand().updateUserLogin(emailController.text.trim());
        
        
      // });
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
      // setState(() async {
        print("signedUpRes nextStep: ");
        print(signUpRes.nextStep);
        print("signUpRes toString()");
        print(signUpRes.toString());
        String signUpStep = signUpRes.nextStep.signUpStep;
        AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(signUpStep, state);
        await BaseCommand().setupInitialAppModels(emailController.text.trim());
        await UserCommand().updateUserStatus(emailController.text.trim(), "SignedUp");
      // });
       Map<String, dynamic>userInput = {"email": emailController.text.trim(), "username": usernameController.text.trim(), "phone": phoneController.text.trim(), "birthdate": birthdateController.text.trim(), "gender": genderController.text.trim(), "address": addressController.text.trim(), "status": "SignedUp"};
      Future <Map<String, dynamic>> createUserResp = UserCommand().createUser(userInput);
      print("createUserResp: ");
      print(createUserResp);
    } on AuthException catch (e) {
      print("signUpError");
      print(e);
      AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(e.message, state);
    }
  }

  void confirmSignIn(AuthenticatorState state) async {
    try {
      SignUpResult confirmSignInRes =
          await AmplifyAuth.AmplifyAuthService.confirmSignUp(
              confirmSignInValueController.text.trim(), emailController.text.trim());
      // setState(() async {
        print(confirmSignInRes.toString());
        String signInStep = confirmSignInRes.nextStep.signUpStep;
        AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(signInStep, state);
        print("confirmSignInmain.dart: "+ signInStep);
        final result = await Amplify.Auth.fetchAuthSession();
        print("fetchAuthSession: ");
        print(result);
        final user = await Amplify.Auth.getCurrentUser();
        print("getCurrentUser: ");
        print(user);
        await UserCommand().updateUserStatus(emailController.text.trim(), "confirmed");
        
      // });
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
        ChangeNotifierProvider(create: (c) => HomePageModel()),
        Provider(create: (c) => UserService()),
      ],
      child: Builder(builder: (context) {
        Commands.init(context);
        // Save a context our Commands can use to access provided Models and Services
        

        return
          MaterialApp(home: AppScaffold());
            //return authenticated user, create or update user in model
            // Authenticator(
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
            //                     // app logo
            //                     const Center(child: FlutterLogo(size: 100)),
            //                     // prebuilt sign in form from amplify_authenticator package
            //                     //  SignInFormField.username()
            //                     SignInForm.custom(
            //                       fields: [
            //                         SignInFormField.username(),
            //                         SignInFormField.password(),
            //                       ],
            //                     ),
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
            //     child: MaterialApp(
            //         builder: Authenticator.builder(), home: AppScaffold()));
      }),
    );
  }
}

class AppScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Bind to AppModel.currentUser
    String currentUser =
        context.select<AppModel, String>((value) => value.currentUser);

    // Return the current view, based on the currentUser value:
    return Scaffold(
      body: currentUser != "" ?  Home() : LoginPage(),
    );
  }
}
