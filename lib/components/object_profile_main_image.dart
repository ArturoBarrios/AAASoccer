import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccermadeeasy/constants.dart';

import '../commands/images_command.dart';
import '../models/user_model.dart';
import 'Dialogues/animated_dialogu.dart';
import 'Mixins/images_mixin.dart';
import '../../constants.dart';

class ObjectProfileMainImage extends StatefulWidget {
  final dynamic objectImageInput;
  dynamic primaryColor = Color(0xff4338CA);

  ObjectProfileMainImage({required this.objectImageInput});

  @override
  _ObjectProfileMainImageState createState() => _ObjectProfileMainImageState();
}

class _ObjectProfileMainImageState extends State<ObjectProfileMainImage> {
  dynamic imageChoices = [
      {Constants.CAMERA : "Take a Picture"},
      {Constants.PHONEGALLERY: "Choose from Phone Gallery"},
      {Constants.APPGALLERY:"Choose from App Images"},
    ];

    String imageUrl = "";

  void chooseImage(Map<int, dynamic> indexes,      
        List<dynamic> primaryList,
        List<dynamic> secondaryList){
      print("chooseImage");
      print("indexes: " + indexes.toString());
      print("primaryList: " + primaryList.toString());
      print("secondaryList: " + secondaryList.toString());
      indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic imageChoiceChosen = imageChoices[mainIndex].keys.first;
      print("imageChoiceChosen: " + imageChoiceChosen.toString());
      //choose from phone gallery||//take a picture
      if(imageChoiceChosen==Constants.PHONEGALLERY||imageChoiceChosen == Constants.CAMERA){
        pickImage(imageChoiceChosen);
      }            
      //choose from app images
      else{
        

      }

      
    });


    }

    void pickImage(String imageChoiceChosen ) async {
      Map<String, dynamic> pickImageResp = await ImagesCommand().pickImage(true, imageChoiceChosen);  
      print("pickImageResp: " + pickImageResp.toString());
      dynamic data = pickImageResp['data'];
      print("data: " + data.toString());
      String key = data['key'];
      print("keyyyyyy: " + key.toString());
      String s3bucket = data['Bucket'];
      Map<String, dynamic> imageInput = {
        "isMainImage": true,
        "key": key,  
        "public": true,  
        "s3bucket": s3bucket    
      };

      imageUrl = key;

      await ImagesCommand().removeProfileTagFromImage();
      await ImagesCommand().storeImageInDatabase(imageInput);
      await ImagesCommand().getAndSetUserProfileImage();
      
      
      //place image as profile picture

      //testing out getting image from cloudfront
      // await ImagesCommand().getImage();
      //add image to user profile    
    }



  Container returnImageContainer(String imageUrl){
    return Container(
      child: GestureDetector(
        onTap: () async {
          List<dynamic> primaryList =
              imageChoices.map((choice) => choice.values.first).toList();

          List<dynamic> secondaryList = [];
          Map<int, dynamic> result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AnimatedDialog(
                  items: primaryList,
                  singleSelect: true,
                  secondaryItems: secondaryList);
            },
          );
          if (result.isNotEmpty) {
            print("result: " + result.toString());
            chooseImage(result, primaryList, secondaryList);
          }
        },
        child: Hero(
          tag: "profile",
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                  child: Container(
                height: 190.0,
                width: 190.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(102.5),
                    color: widget.primaryColor.withOpacity(0.05)),
              )),
              Container(
                  child: Container(
                height: 170.0,
                width: 170.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(102.5),
                  gradient: RadialGradient(stops:[0.01,0.5],colors: [Colors.white, widget.primaryColor.withOpacity(0.1)]),
                ),
              )),
              Container(
                  child: Container(
                height: 150.0,
                width: 150.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(102.5),
                    color: widget.primaryColor.withOpacity(0.4)),
              )),
              Container(
                child: Container(
                    height: 132.0,
                    width: 132.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(102.5),
                        color: widget.primaryColor.withOpacity(0.5))),
              ),
              Container(
                child: Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(62.5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl.toString()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loadInitialData(){
    print("loadInitialData");
    setState(() {
      // String imageUrl = widget.objectImageInput['imageUrl'];
    });
  }  

  @override
  void initState() {
    super.initState();
    loadInitialData();
    
  }

  @override
  Widget build(BuildContext context) {
    String profileImageUrl = context
        .select<UserModel, String>((value) => value.profileImageUrl);
    print("widget.objectImageInput['containerType']: " + widget.objectImageInput['containerType'].toString());
    if (widget.objectImageInput['containerType'] == Constants.IMAGECIRCLE.toString())
      return returnImageContainer(profileImageUrl);
    else
      return Text("Nothing to show here");
  }
}
