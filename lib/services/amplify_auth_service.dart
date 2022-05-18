import '../amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';


class AmplifyAuthService {

  static void changeAuthenticatorStep(String nextStep, AuthenticatorState state) {
      print("changeAuthenticatorStep");
      if(nextStep.contains("An account with the given email already exists.")||nextStep.contains("DONE")){
        print("An account with the given email already exists.");
        state.changeStep(AuthenticatorStep.signIn);
      }
      else if(nextStep.contains("User is not confirmed")){
        print("User is not confirmed");
        state.changeStep(AuthenticatorStep.confirmSignUp);
      }
      else if(nextStep.contains("User does not exist")){
        print("User does not exist");
        state.changeStep(AuthenticatorStep.signUp);
      }
      else if(nextStep.contains("CONFIRM_SIGN_UP_STEP")){
        print("CONFIRM_SIGN_UP_STEP");
        state.changeStep(AuthenticatorStep.confirmSignUp);
      }
      else if(nextStep.contains("DONE")){
        print("DONE");
        state.changeStep(AuthenticatorStep.onboarding);
      }
      

    

  }

  static Future<void> configureAmplify() async {
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

  static Future<SignInResult> signIn(
      emailController, passwordController) async {
    SignInResult res = await Amplify.Auth.signIn(
      username: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    return res;
  }

  static Future<SignUpResult> signUp(emailController, passwordController,
      usernameController, phoneController) async {
    Map<CognitoUserAttributeKey, String> userAttributes = {
      CognitoUserAttributeKey.name: usernameController.text.trim(),
      CognitoUserAttributeKey.email: emailController.text.trim(),
      CognitoUserAttributeKey.preferredUsername: emailController.text.trim(),
      // Note: phone_number requires country code
      CognitoUserAttributeKey.phoneNumber: '+1' + phoneController.text.trim(),
    };
    SignUpResult res = await Amplify.Auth.signUp(
        username: emailController.text.trim(),
        password: passwordController.text.trim(),
        options: CognitoSignUpOptions(userAttributes: userAttributes));

    return res;
  }

  static Future<SignUpResult> confirmSignUp(String confirmValue, String email) async {
    print("confirmSignIn");
    SignUpResult res = await Amplify.Auth.confirmSignUp(
        username: email,
        confirmationCode: confirmValue);

    return res;
  }
}
