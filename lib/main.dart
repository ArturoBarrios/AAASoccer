import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'amplifyconfiguration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'commands/base_command.dart' as Commands;
import 'models/app_model.dart';
import 'models/user_model.dart';
import 'services/user_service.dart';
import 'services/amplify_auth_service.dart' as AmplifyAuth;
import 'views/home_page.dart';
import 'views/login_page.dart';

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
  final confirmSignInValueController = TextEditingController();
  bool isSignedIn = false;
  late TabController _tabController;

  @override
  void initState() {
    print("test");
    super.initState();
    AmplifyAuth.AmplifyAuthService.configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      // Add the following line to add Auth plugin to your app.
      await Amplify.addPlugin(AmplifyAuthCognito());

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
      print("amplify configured!");
    } on Exception catch (e) {
      print('An error occurred configuring Amplify: $e');
    }
  }

  void signOut(AuthenticatorState state) async {
    try {
      await Amplify.Auth.signOut(options: SignOutOptions(globalSignOut: true));
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  void signIn(AuthenticatorState state) async {
    try {
      SignInResult signInRes = await AmplifyAuth.AmplifyAuthService.signIn(
          emailController, passwordController);
      // signInRes.isSignedIn;

      setState(() {
        print("signInRes: " +signInRes.nextStep!.signInStep);
        String signInStep = signInRes.nextStep!.signInStep;
AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(signInStep, state);
        signInRes.nextStep!.signInStep;
      });
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
          phoneController);
      setState(() {
        print("signedUpRes: "+signUpRes.nextStep.signUpStep);
        String signUpStep = signUpRes.nextStep.signUpStep;
        AmplifyAuth.AmplifyAuthService.changeAuthenticatorStep(signUpStep, state);
        if(signUpRes.isSignUpComplete){
          
        }
        
      });
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
      setState(() async {
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
        // state.changeStep(AuthenticatorStep.)
      });
    } on AuthException catch (e) {
      print("confirmSignInError");
      print(e);
    }
  }

  @override
  Widget build(BuildContext _) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => AppModel()),
        ChangeNotifierProvider(create: (c) => UserModel()),
        Provider(create: (c) => UserService()),
      ],
      child: Builder(builder: (context) {
        // Save a context our Commands can use to access provided Models and Services
        Commands.init(context);
        return
            //return authenticated user, create or update user in model
            Authenticator(
                authenticatorBuilder:
                    (BuildContext context, AuthenticatorState state) {
                  const padding =
                      EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16);
                  switch (state.currentStep) {
                    case AuthenticatorStep.signIn:
                      return Scaffold(
                        body: Padding(
                          padding: padding,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // app logo
                                const Center(child: FlutterLogo(size: 100)),
                                // prebuilt sign in form from amplify_authenticator package
                                //  SignInFormField.username()
                                SignInForm.custom(
                                  fields: [
                                    SignInFormField.username(),
                                    SignInFormField.password(),
                                  ],
                                ),
                                //todo
                                //create switch to switch between login and signup
                                //onpress function that creates creates/updates cognito user
                                TextField(
                                  controller: emailController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Email'),
                                ),
                                TextField(
                                  controller: phoneController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Phone'),
                                ),
                                TextField(
                                  controller: passwordController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Password'),
                                ),

                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue, // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  //emailController, passwordController
                                  onPressed: () {
                                    signIn(state);
                                  },
                                  child: Text('Sign In'),
                                )
                              ],
                            ),
                          ),
                        ),
                        // custom button to take the user to sign up
                        persistentFooterButtons: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                onPressed: () => state.changeStep(
                                  AuthenticatorStep.signUp,
                                ),
                                child: const Text('Sign Up'),
                              ),
                            ],
                          ),
                        ],
                      );
                    case AuthenticatorStep.signUp:
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
                                  controller: emailController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Email'),
                                ),

                                TextField(
                                  controller: usernameController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Username'),
                                ),
                                TextField(
                                  controller: phoneController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Phone'),
                                ),
                                TextField(
                                  controller: passwordController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Password'),
                                ),

                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue, // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  //emailController, passwordController, usernameController, phoneController
                                  onPressed: () {
                                    signUp(state);
                                  },
                                  child: Text('Sign Up'),
                                )
                                // SignUpForm.custom(
                                //   fields: [
                                //     SignUpFormField.username(),
                                //     SignUpFormField.email(required: true),
                                //     SignUpFormField.phoneNumber(),
                                //     SignUpFormField.password(),

                                //   ],

                                // ),
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
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Confirmation Code'),
                                ),

                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue, // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  //emailController, passwordController, usernameController, phoneController
                                  onPressed: () {
                                    confirmSignIn(state);
                                  },
                                  child: Text('Confirm'),
                                )
                                // SignUpForm.custom(
                                //   fields: [
                                //     SignUpFormField.username(),
                                //     SignUpFormField.email(required: true),
                                //     SignUpFormField.phoneNumber(),
                                //     SignUpFormField.password(),

                                //   ],

                                // ),
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
                    builder: Authenticator.builder(), home: AppScaffold()));
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
      body: currentUser != "" ? HomePage() : LoginPage(),
    );
  }
}
