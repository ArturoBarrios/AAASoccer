How to run:

**flutter --version**
Flutter 3.7.8 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 90c64ed42b (4 months ago) • 2023-03-21 11:27:08 -0500
Engine • revision 9aa7816315
Tools • Dart 2.19.5 • DevTools 2.20.1

**amplify -v**
11.0.3

develop is latest

copy .env.copy into new .env(copy content I sent you in private message)

```plaintext
flutter pub get

amplify pull --appId d3j6ze5fxredf0 --envName staging //choose AWS access keys
accessKeyId: AKIA2H3HBZX7DOYJVAHH
secretAccessKey: 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
choose us-east-1
Select the authentication method you want to use: AWS access keys
? accessKeyId: ********************
? secretAccessKey: ****************************************
? region: us-east-1
? Which app are you working on? d3j6ze5fxredf0
Backend environment 'staging' found. Initializing...
? Choose your default editor: Visual Studio Code
? Choose the type of app that you're building flutter
Please tell us about your project
? Where do you want to store your configuration file? ./lib/
? Do you plan on modifying this backend? Yes

flutter run --no-sound-null-safety
```