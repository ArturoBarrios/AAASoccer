import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/views/request/view.dart';

import '../../commands/event_command.dart';
import '../../commands/images_command.dart';
import '../../commands/player_command.dart';
import '../../commands/team_command.dart';
import '../../commands/user_command.dart';
import '../../constants.dart';

mixin ImagesMixin {

  dynamic imageChoices = [
      {Constants.CAMERA : "Take a Picture"},
      {Constants.PHONEGALLERY: "Choose from Phone Gallery"},
      {Constants.APPGALLERY:"Choose from App Images"},
    ];

  void chooseImage(dynamic objectDetails,Map<int, dynamic> indexes,      
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
        pickImage(objectDetails, imageChoiceChosen);
      }            
      //choose from app images
      else{
        

      }

      
    });


    }

    void pickImage(dynamic objectDetails, String imageChoiceChosen ) async {
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

      if(objectDetails['for'] == Constants.USER){
        await ImagesCommand().removeProfileTagFromImage();
        await ImagesCommand().storeImageInDatabase(imageInput);
        await ImagesCommand().getAndSetUserProfileImage();
      }
      
      
      //place image as profile picture

      //testing out getting image from cloudfront
      // await ImagesCommand().getImage();
      //add image to user profile    
    }

  
}
