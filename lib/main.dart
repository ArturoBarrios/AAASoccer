import 'package:amplify_flutter/amplify_flutter.dart';
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
  const MyApp({Key? key}): super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
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
        return MaterialApp(home: AppScaffold());
      }),
    );
  }
}

class AppScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Bind to AppModel.currentUser
    String currentUser = context.select<AppModel, String>((value) => value.currentUser);
    
    // Return the current view, based on the currentUser value:
    return Scaffold(
      body: currentUser != "" ? HomePage() : LoginPage(),
    );
  }
}