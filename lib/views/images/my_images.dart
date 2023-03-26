import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../components/profile.dart';
import '../../components/payment_screen.dart';
import '../../commands/location_command.dart';
import '../../components/card_form_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../components/headers.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import '../../commands/images_command.dart';

class MyImagesView extends StatefulWidget {
  const MyImagesView({Key? key})
      : super(key: key);

  

  @override
  _MyImagesViewState createState() => _MyImagesViewState();
}

class _MyImagesViewState extends State<MyImagesView> {
  bool _isLoading = true;
  

 void getImage() async{
  print("getImage");
  // Map<String, dynamic> imageResp = await ImagesCommand().getImages();
 }

  void goBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    print("initState");        
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    print("build()");    
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green[700],
        ),
        home: Scaffold(
          appBar: Headers().getBackHeader(context),
          body: _isLoading
              ? Text("Loading...")
              : Center(
                  child: Column(children: [
                    GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child:
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.amber[600],
                      width: MediaQuery.of(context).size.width -
                          (MediaQuery.of(context).size.width *
                              .1), //10% padding
                      height: 200.0,
                      child:Text("my images")
                              )),
                  
                ])),
        ));
  }
}

