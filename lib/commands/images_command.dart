import 'package:soccermadeeasy/constants.dart';

import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../graphql/mutations/images.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImagesCommand extends BaseCommand {
  Future<Map<String, dynamic>> getAndSetUserProfileImage() async {
    print("getUserProfileImage()");
    Map<String, dynamic> getUserProfileImageResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      String profileImageUrl = "";
      String key = "";
      print("appModel.currentUser['images']['data]: " +
          appModel.currentUser['images'].toString());
      appModel.currentUser['images']['data'].forEach((image) {
        if (image['isMainImage']) {
          print("isMainImage: " + image.toString());
          key = image['key'];
        }
      });
      if (key != "") {
        Map<String, dynamic> getImageResp = await getImage(key);
        print("getImageResp: " + getImageResp.toString());
        if (getImageResp['success']) {
          profileImageUrl = getImageResp['data']['signedUrl'];
          //set presigned cloudfront image url
          userModel.profileImageUrl = profileImageUrl;
          print("profileImageUrl: " + profileImageUrl.toString());
        }
      }
      return getUserProfileImageResp;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return getUserProfileImageResp;
    }
  }

  Future<Map<String, dynamic>> partialUpdateImage(
      dynamic processedImageInput) async {
    print("partialUpdateImage");
    print("processedImageInput: " + processedImageInput.toString());
    Map<String, dynamic> partialUpdateImageResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': ImageMutations().partialImageUpdate(processedImageInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));
      partialUpdateImageResponse["success"] = true;

      dynamic updatedImage = jsonDecode(response.body)['data']['partialUpdateImage'];
      //update appModel.currentUser images
      int index = 0;
      appModel.currentUser['images']['data'].forEach((image) {
        if (image['key'] == processedImageInput['key']) {
          image['isMainImage'] = processedImageInput['isMainImage'];
          appModel.currentUser['images']['data'][index] = updatedImage;
        }
        index++;
      });
      
      partialUpdateImageResponse["message"] = "Image Updated";
      partialUpdateImageResponse["data"] = updatedImage;          

      return partialUpdateImageResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return partialUpdateImageResponse;
    }
  }

  Future<Map<String, dynamic>> getImages(String key) async {
    print("getImages()");
    Map<String, dynamic> getImageResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      final uri = Uri.https(
          "us-central1-soccer-app-a9060.cloudfunctions.net", '/getImages');

      final getSignedUrlResponse = await http.get(uri);
      print("response: " + json.decode(getSignedUrlResponse.body).toString());

      getImageResponse['success'] = true;

      return getImageResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return getImageResponse;
    }
  }

  Future<Map<String, dynamic>> getImage(String key) async {
    print("getImage()");
    Map<String, dynamic> getImageResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      final uri = Uri.parse("http://localhost:3000/images?key=" + key);

      final getSignedUrlResponse = await http.get(uri);
      print("response: " + json.decode(getSignedUrlResponse.body).toString());

      getImageResponse['success'] = true;
      getImageResponse['data'] = {
        'signedUrl': json.decode(getSignedUrlResponse.body)['signedUrl'],
      };

      return getImageResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return getImageResponse;
    }
  }

  

  Future<Map<String, dynamic>> storeImageInDatabase(
      Map<String, dynamic> imageInput) async {
    print("storeImage()");
    Map<String, dynamic> getImageResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      imageInput['user_id'] = appModel.currentUser['_id'];
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': ImageMutations().createImage(imageInput),
        }),
      );

      print("response: " + json.decode(response.body).toString());

      getImageResponse['success'] = true;
      getImageResponse['data'] = {
        'image': json.decode(response.body)['data']['createImage'],
      };
      appModel.currentUser['images']['data'].add(
          json.decode(response.body)['data']['createImage']);
      


      return getImageResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return getImageResponse;
    }
  }

  //if someone adds new profile image,
  //remove profile image but keep image
  //in database
  Future<Map<String, dynamic>> removeProfileTagFromImage() async {
    print("removeProfileTagFromImage()");
    Map<String, dynamic> removeProfileTagFromImageResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      appModel.currentUser['images']['data'].forEach((image) async {
        if (image['isMainImage']) {
          print("set isMainImage to false for image: " + image.toString());
          Map<String, dynamic> partialImageInput = {
            'image': {
              '_id': image['_id'],
              'dataToUpdate': """
                isMainImage: false 
              """
            },
          };
          dynamic partialUpdateImageResp = await partialUpdateImage(partialImageInput);
          print("partialUpdateImageResp: " + partialUpdateImageResp.toString());
          removeProfileTagFromImageResp['success'] = true;
        }
      });
      return removeProfileTagFromImageResp;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return removeProfileTagFromImageResp;
    }
  }

  //Image Picker
  Future<Map<String, dynamic>> pickImage(bool storeAsProfile, String imageChoiceChosen) async {
    print("pickImage()");
    Map<String, dynamic> pickImageResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {

      var image = null;
      if(imageChoiceChosen == Constants.PHONEGALLERY){
        image = await ImagePicker().pickImage(source: ImageSource.gallery);
      }
      else if(imageChoiceChosen == Constants.CAMERA){
        image = await ImagePicker().pickImage(source: ImageSource.camera);
      }
      

      if (image == null) return pickImageResponse;
      final imageTemp = File(image.path);
      print("imageTemp: " + imageTemp.toString());
      //convert to Stream
      var bytes = imageTemp.readAsBytesSync();
      String img64 = base64Encode(bytes);
      print("img64: " + img64);
      String filename = imageTemp.path;
      print("filename: " + filename);
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://localhost:3000/uploadImage'));
      http.MultipartFile file =
          await http.MultipartFile.fromPath('image', filename);
      request.files.add(file);
      print("request: " + request.files.toString());
      http.StreamedResponse res = await request.send();
      var response = await http.Response.fromStream(res);
      print("upload iamge res: " + json.decode(response.body).toString());

      pickImageResponse['success'] = true;
      pickImageResponse['data'] = json.decode(response.body)['data'];

      return pickImageResponse;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return pickImageResponse;
    }
  }
}
