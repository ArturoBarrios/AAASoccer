import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class FirebaseServices {  
  // Determine the current position of the device.
  //
  // When the location services are not enabled or permissions
  // are denied the `Future` will return an error.
  void initializeFirebaseAnalytics() async {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    

  }

  Future<void> initializeFirebase() async{
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  }

  

  

  
}
