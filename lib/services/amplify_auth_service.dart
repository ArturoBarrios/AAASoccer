import 'package:soccermadeeasy/commands/base_command.dart';
import 'package:soccermadeeasy/models/pageModels/app_model.dart';

import '../amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import '../commands/user_command.dart';
import '../models/user_model.dart';

class AmplifyAuthService {
  static Future<Map<String, dynamic>> deleteUser() async {
    print("deleteUser");
    Map<String, dynamic> deleteUserResponse = {
      "success": 0,
      "message": "Something went wrong with deleting User",
      "data": null      
    };
    try {
      await Amplify.Auth.deleteUser;            
      deleteUserResponse["success"] = 1;
      deleteUserResponse["message"] = "Amplify User Deleted";
    } catch (e) {
      print(e.toString());
    }

    return deleteUserResponse;
  }

  static Future<Map<String, dynamic>> fetchUserAuthSession() async {
    print("fetchUserAuthSession");
    Map<String, dynamic> fetchUserAuthResponse = {
      "success": 0,
      "message": "Something went wrong with fetching User",
      "data": null      
    };
    try {
      AuthSession authSessionRes = await Amplify.Auth.fetchAuthSession();
      print("authSessionRes: " + authSessionRes.isSignedIn.toString());
      fetchUserAuthResponse["data"] = authSessionRes;
      fetchUserAuthResponse["success"] = 1;
      fetchUserAuthResponse["message"] = "Fetched User";
    } catch (e) {
      print(e.toString());
    }

    return fetchUserAuthResponse;
  }

  static void skipVerifyUser(AuthenticatorState state) {
    state.skipVerifyUser();
  }

  static void changeAuthenticatorStep(
      String nextStep, AuthenticatorState state) {
    print("changeAuthenticatorStep");
    print(nextStep);
    if (nextStep.contains("An account with the given email already exists.")) {
      print("An account with the given email already exists.");
      state.changeStep(AuthenticatorStep.signIn);
    } else if (nextStep.contains("User is not confirmed")) {
      print("User is not confirmed");
      state.changeStep(AuthenticatorStep.confirmSignUp);
    } else if (nextStep.contains("User does not exist")) {
      print("User does not exist");
      state.changeStep(AuthenticatorStep.signUp);
    } else if (nextStep.contains("CONFIRM_SIGN_UP_STEP")) {
      print("CONFIRM_SIGN_UP_STEP");
      state.changeStep(AuthenticatorStep.confirmSignUp);
    } else if (nextStep.contains("DONE")) {
      print("DONE");
      state.skipVerifyUser();
    } else {
      print("else");
      // state.changeStep(AuthenticatorStep.)
    }
  }

  static Future<Map<String, dynamic>> configureAmplify() async {
    print("configureAmplify");
    Map<String, dynamic> configureAmplifyResp = {
      "success": false,
      "message": "Default Error"
    };
    /////////////////////////addback in when shortcode is ready

    await Amplify.addPlugin(AmplifyAuthCognito());

    try {
      // Add the following line to add Auth plugin to your app.

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
      print("amplify configured");
      Map<String, dynamic> authSessionRes = await fetchUserAuthSession();

      if (authSessionRes["data"].isSignedIn) {
        print("isSignedIn!!!!");
        List<AuthUserAttribute> userAttributes =
            await Amplify.Auth.fetchUserAttributes();
        int indexOfEmail =
            userAttributes.indexWhere((f) => f.userAttributeKey.key == "email");

        print("indexOfEmail: ");
        print(indexOfEmail);
        String email = userAttributes[indexOfEmail].value;
        print("email");
        print(email);
        UserModel().userEmail = email;
        print("authSessionRes: $authSessionRes");
        print("amplify configured end of function!");
        configureAmplifyResp["success"] = true;
        configureAmplifyResp["message"] = "isSignedIn";
        configureAmplifyResp["data"] = authSessionRes["data"];
        configureAmplifyResp["email"] = email;
      }
      AppModel().amplifyConfigured = true;
    } on Exception catch (e) {
      print('An error occurred configuring Amplify: $e');
    }

    return configureAmplifyResp;
  }

  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut(
          options: const SignOutOptions(globalSignOut: true));
      //base_command set initial app models to reflect signout
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  static Future<SignInResult> signIn(String email, String password) async {
    SignInResult res = await Amplify.Auth.signIn(
      username: email,
      password: password,
    );

    print("signIn res: $res");

    //

    return res;
  }

  static Future<SignUpResult> signUp(
    emailController,
    passwordController,
    usernameController,
    phoneController,
    birthdateController,
    genderController,
    addressController,
  ) async {
    Map<CognitoUserAttributeKey, String> userAttributes = {
      CognitoUserAttributeKey.name: usernameController.text.trim(),
      CognitoUserAttributeKey.email: emailController.text.trim(),
      CognitoUserAttributeKey.preferredUsername: usernameController.text.trim(),
      // Note: phone_number requires country code
      CognitoUserAttributeKey.phoneNumber: phoneController,
      CognitoUserAttributeKey.birthdate: birthdateController.text.trim(),
      CognitoUserAttributeKey.gender: genderController.text.trim(),
      CognitoUserAttributeKey.address: addressController.text.trim()
    };
    SignUpResult res = await Amplify.Auth.signUp(
      username: emailController.text.trim(),
      password: passwordController.text.trim(),
      options: CognitoSignUpOptions(userAttributes: userAttributes),
    );

    return res;
  }

  static Future<SignUpResult> confirmSignUp(
      String confirmValue, String email) async {
    print("confirmSignIn");
    SignUpResult res = await Amplify.Auth.confirmSignUp(
        username: email, confirmationCode: confirmValue);

    return res;
  }
}
