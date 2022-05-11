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
import 'views/home_page.dart';
import 'views/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  late TabController _tabController;
  @override
  void initState() {
    print("test");
    super.initState();
    _configureAmplify();
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

  

  Future<String> signIn() async {
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      setState(() {
        print("is signed in!");
        // isSignedIn = res.isSignedIn;
      });
      } on AuthException catch (e) {
        print("AuthException: "+e.message);
      }

      return "res";
  }

  Future<String> signUp() async {
    try {
      Map<CognitoUserAttributeKey, String> userAttributes = {
        CognitoUserAttributeKey.name: usernameController.text.trim(),
        CognitoUserAttributeKey.email: emailController.text.trim(),
        CognitoUserAttributeKey.preferredUsername: emailController.text.trim(),
        // Note: phone_number requires country code
        CognitoUserAttributeKey.phoneNumber: '+1'+phoneController.text.trim(),
      };
      SignUpResult res = await Amplify.Auth.signUp(
        username: emailController.text.trim(),
        password: passwordController.text.trim(),
        options: CognitoSignUpOptions(
          userAttributes: userAttributes
        )
      );
      setState(() {
        print("signed up!");
      });
    } on AuthException catch (e) {
      print(e.message);
      print(e);
    }
    return "string";
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
                                    hintText: 'Email'
                                  ),
                                ),
                                TextField(
                                  controller: phoneController,
                                  decoration: new InputDecoration.collapsed(
                                    hintText: 'Phone'
                                  ),
                                ),
                                TextField(
                                  controller: passwordController,
                                  decoration: new InputDecoration.collapsed(
                                    hintText: 'Password'
                                  ),
                                ),


                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue, // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  onPressed: () { signIn(); },
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
                                    hintText: 'Email'
                                  ),
                                  
                                ),
                               
                                TextField(
                                  controller: usernameController,
                                  decoration: new InputDecoration.collapsed(
                                    hintText: 'Username'
                                  ),
                                ),
                                TextField(
                                  controller: phoneController,
                                  decoration: new InputDecoration.collapsed(
                                    hintText: 'Phone'
                                  ),
                                ),
                                 TextField(
                                  controller: passwordController,
                                  decoration: new InputDecoration.collapsed(
                                    hintText: 'Password'
                                  ),
                                ),

                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue, // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  onPressed: () { signUp(); },
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
