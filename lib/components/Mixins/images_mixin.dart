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
        List<dynamic> secondaryList, Function chooseImageCallback){
      print("chooseImage");
      print("objectDetails: " + objectDetails.toString());
      print("indexes: " + indexes.toString());
      print("primaryList: " + primaryList.toString());
      print("secondaryList: " + secondaryList.toString());
      indexes.forEach((mainIndex, secondaryIndexes) async {
        dynamic imageChoiceChosen = imageChoices[mainIndex].keys.first;
        print("imageChoiceChosen: " + imageChoiceChosen.toString());
        //choose from phone gallery||//take a picture
        if(imageChoiceChosen==Constants.PHONEGALLERY||imageChoiceChosen == Constants.CAMERA){
          pickImage(objectDetails, imageChoiceChosen, chooseImageCallback);
        }            
        //choose from app images
        else{
          

        }

      
    });


    }

    Future<dynamic> loadEventMainImage(dynamic userEventDetails) async{
      String imageKey = userEventDetails['mainEvent']['mainImageKey'];
      String imageUrl = "";
      dynamic objectImageInput = {
        "imageUrl": "",
        "containerType": Constants.IMAGEBANNER,
        "mainEvent": null,
        "isMine": userEventDetails['isMine']
      };

    if(imageKey != null){
      dynamic imageInput = {
          "key": imageKey      
        };
      print("imageKey: $imageKey");
      Map<String,dynamic> getImageUrlResp = await ImagesCommand().getImageUrl(imageInput);
      print("getImageUrlRespppp: $getImageUrlResp");
      if(getImageUrlResp['success']){
        imageUrl = getImageUrlResp['data'];
        userEventDetails['mainEvent']['mainImageUrl'] = imageUrl;
      
      objectImageInput = {
        "imageUrl": imageUrl,
        "containerType": Constants.IMAGEBANNER,
        "mainEvent": userEventDetails['mainEvent'],
        "isMine": userEventDetails['isMine'],

      };
      }
    }
    return objectImageInput;
    }

    

    void pickImage(dynamic objectDetails, String imageChoiceChosen, 
        Function chooseImageCallback) async {
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
      print("imageInput: " + imageInput.toString());
      if(objectDetails['for'] == Constants.CHAT){      
        print("for chat");  
        imageInput['chat_id'] = objectDetails['chat']['_id'];
        print("imageInput: " + imageInput.toString());
        dynamic storeImageInDatabaseForUserResp = await ImagesCommand().storeImageInDatabaseForChat(imageInput);
        if(storeImageInDatabaseForUserResp['success']){
          dynamic storedImage = storeImageInDatabaseForUserResp['data'];        
          chooseImageCallback(storedImage);

        }
      }
      if(objectDetails['for'] == Constants.USER){
        // await ImagesCommand().removeProfileTagFromImage();
        dynamic storeImageInDatabaseForUserResp = await ImagesCommand().storeImageInDatabaseForUser(imageInput);
        if(storeImageInDatabaseForUserResp['success']){
          dynamic storedImage = storeImageInDatabaseForUserResp['data'];        
          chooseImageCallback(storedImage);

        }
      }
      else if(objectDetails['for'] == Constants.TEAM){
        print("objectDetails['team']['_id']: " + objectDetails['team']['_id'].toString());
        imageInput['team_id'] = objectDetails['team']['_id'];
        //get current User
        dynamic currentUser = await UserCommand().getAppModelUser();
        imageInput['user_id'] = currentUser['_id'];
        dynamic storeImageInDatabaseForUserResp = await ImagesCommand().storeImageInDatabaseForTeam(imageInput);
        dynamic storedImage = storeImageInDatabaseForUserResp['data'];
        chooseImageCallback(storedImage);

      }
      else if(objectDetails['for'] == Constants.EVENT){
        print("else if for event: "+ objectDetails.toString().toString());
        imageInput['event_id'] = objectDetails['mainEvent']['_id'];
        //get current User
        dynamic currentUser = await UserCommand().getAppModelUser();
        imageInput['user_id'] = currentUser['_id'];
        dynamic storeImageInDatabaseForUserResp = await ImagesCommand().storeImageInDatabaseForEvent(imageInput);
        dynamic storedImage = storeImageInDatabaseForUserResp['data'];
        chooseImageCallback(storedImage);
      }
      
      
      //place image as profile picture

      //testing out getting image from cloudfront
      // await ImagesCommand().getImage();
      //add image to user profile    
    }

  
}
