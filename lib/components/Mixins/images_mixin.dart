import 'dart:convert';

import 'package:collection/collection.dart';
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
  List<Map<String, dynamic>> imageChoices = [
    {Constants.CAMERA: "Take a Picture"},
    {Constants.PHONEGALLERY: "Choose from Phone Gallery"},
    {Constants.APPGALLERY: "Choose from App Images"},
  ];

  void chooseImage(    
    dynamic objectFor,
    String imageFor,    
    Map<int, dynamic> indexes,
    List<dynamic> primaryList,
    List<dynamic> secondaryList,
    Function chooseImageCallback,
  ) {
    print("chooseImage");    
    print("indexes: $indexes");
    print("primaryList: $primaryList");
    print("secondaryList: $secondaryList");
    indexes.forEach((mainIndex, secondaryIndexes) async {
      final imageChoiceChosen = imageChoices[mainIndex].keys.first;
      print("imageChoiceChosen: $imageChoiceChosen");
      //choose from phone gallery||//take a picture
      if (imageChoiceChosen == Constants.PHONEGALLERY ||
          imageChoiceChosen == Constants.CAMERA) {
        pickImage(objectFor, imageFor,imageChoiceChosen, chooseImageCallback);
      }
      //choose from app images
      else {}
    });
  }

  Future<dynamic> loadEventMainImage(dynamic userEventDetails) async {
    String? imageKey = userEventDetails['mainEvent']['mainImageKey'];
    String imageUrl = "";
    dynamic objectImageInput = {
      "imageUrl": "",
      "containerType": Constants.IMAGEBANNER,
      "mainEvent": null,
      "isMine": userEventDetails['isMine']
    };

    if (imageKey != null) {
      dynamic imageInput = {"key": imageKey};
      print("imageKey: $imageKey");
      Map<String, dynamic> getImageUrlResp =
          await ImagesCommand().getImageUrl(imageInput);
      print("getImageUrlRespppp: $getImageUrlResp");
      if (getImageUrlResp['success']) {
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

  void pickImage(
    // dynamic objectDetails,
    dynamic objectFor,
    String imageFor,
    String imageChoiceChosen,
    Function chooseImageCallback,
  ) async {
    Map<String, dynamic> pickImageResp =
        await ImagesCommand().pickImage(true, imageChoiceChosen);
    print("pickImageResp: $pickImageResp");
    dynamic data = pickImageResp['data'];
    print("data: $data");
    String key = data['key'];
    print("keyyyyyy: $key");
    String s3bucket = data['Bucket'];
    Map<String, dynamic> imageInput = {
      "isMainImage": true,
      "key": key,
      "public": true,
      "s3bucket": s3bucket
    };
    print("imageInput: $imageInput");
    if (imageFor == Constants.CHAT) {
      print("for chat");      
      print("imageInput: $imageInput");
      dynamic storeImageInDatabaseForUserResp =
          await ImagesCommand().storeImageInDatabaseForChat(imageInput);
      if (storeImageInDatabaseForUserResp['success']) {
        dynamic storedImage = storeImageInDatabaseForUserResp['data'];
        chooseImageCallback(storedImage);
      }
    }
    if (imageFor == Constants.USER) {
      // await ImagesCommand().removeProfileTagFromImage();
      dynamic storeImageInDatabaseForUserResp =
          await ImagesCommand().storeImageInDatabaseForUser(imageInput);
      if (storeImageInDatabaseForUserResp['success']) {
        dynamic storedImage = storeImageInDatabaseForUserResp['data'];
        chooseImageCallback(storedImage);
      }
    } else if (imageFor == Constants.TEAM) {      
      imageInput['team_id'] = objectFor['_id'];
      //get current User
      dynamic currentUser = await UserCommand().getAppModelUser();
      imageInput['user_id'] = currentUser['_id'];
      dynamic storeImageInDatabaseForUserResp =
          await ImagesCommand().storeImageInDatabaseForTeam(imageInput);
      dynamic storedImage = storeImageInDatabaseForUserResp['data'];
      chooseImageCallback(storedImage);
    } else if (imageFor == Constants.EVENT) {    
      print("for eventtt: "+objectFor.toString());  
      imageInput['event_id'] = objectFor['_id'];
      //get current User
      dynamic currentUser = await UserCommand().getAppModelUser();
      imageInput['user_id'] = currentUser['_id'];
      dynamic storeImageInDatabaseForUserResp =
          await ImagesCommand().storeImageInDatabaseForEvent(imageInput);
      dynamic storedImage = storeImageInDatabaseForUserResp['data'];
      chooseImageCallback(storedImage);
    }

    //place image as profile picture

    //testing out getting image from cloudfront
    // await ImagesCommand().getImage();
    //add image to user profile
  }

  Future<void> deleteImage(String key, {bool isProfileImage = false}) async {
    print("deleteImage");
    final deletedFromBucket = await ImagesCommand().deleteImageFromBucket(key);
    if (deletedFromBucket) {
      dynamic currentUser = UserCommand().getAppModelUser();

      Map<String, dynamic> allImagesFromUserResp =
          ImagesCommand().allImagesFromUser(currentUser);
      print("allImagesFromUserResp: $allImagesFromUserResp");
      final images = allImagesFromUserResp['data'] as List<dynamic>;
      final image = images.firstWhereOrNull((e) => e['key'] == key);
      print("image: $image");
      if (image != null) {
        final deletedFromDatabase =
            await ImagesCommand().deleteImageFromDatabase(image);
        if (deletedFromDatabase['success'] && isProfileImage) {
          Map<String, dynamic> partialUserInput = {
            'user': {
              '_id': currentUser['_id'],
              'dataToUpdate': """
          {
            mainImageKey: null
          }
          """,
            },
          };

          // await UserCommand().partialUpdateUser(partialUserInput);
        }
      }
    }
  }
}
