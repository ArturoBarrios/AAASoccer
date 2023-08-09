import 'package:soccermadeeasy/constants.dart';

import '../graphql/mutations/chat.dart';
import '../graphql/mutations/events.dart';
import '../graphql/mutations/users.dart';
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
  Future<Map<String, dynamic>> deleteImageFromDatabase(
      dynamic imageInput) async {
    print("deleteImageFromDatabase()");
    Map<String, dynamic> deleteImageResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      //delete image from database
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': ImageMutations().deleteImage(imageInput),
        }),
      );

      return deleteImageResp;
    } catch (e) {
      print("getImages() error: " + e.toString());
      return deleteImageResp;
    }
  }

  Future<Map<String, dynamic>> deleteImageFromS3(dynamic imageInput) async {
    print("deleteImage()");
    Map<String, dynamic> deleteImageFromS3Resp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      //delete image from database
      final uri = Uri.https(
          "us-central1-soccer-app-a9060.cloudfunctions.net", '/getImages');

      final getSignedUrlResponse = await http.get(uri);
      print("response: " + json.decode(getSignedUrlResponse.body).toString());

      deleteImageFromS3Resp['success'] = true;

      return deleteImageFromS3Resp;
    } catch (e) {
      print("getImages() error: " + e.toString());
      return deleteImageFromS3Resp;
    }
  }

  Map<String, dynamic> allImagesFromUser(dynamic currentUser) {
    print("imagesFromMyUser");
    Map<String, dynamic> imagesFromMyUserResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    dynamic currentUser = appModel.currentUser;
    List<dynamic> userImages = currentUser['images']['data'];
    imagesFromMyUserResponse['data'] = userImages;
    imagesFromMyUserResponse['success'] = true;

    return imagesFromMyUserResponse;
  }

  Future<Map<String, dynamic>> setUserProfileImage() async {
    print("getUserProfileImage()");
    Map<String, dynamic> getUserProfileImageResp = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      String profileImageUrl = "";

      Map<String, dynamic> getImageResp =
          await getImage(appModel.currentUser['mainImageKey']);
      print("getImageResp: " + getImageResp.toString());
      if (getImageResp['success']) {
        profileImageUrl = getImageResp['data']['signedUrl'];
        //set presigned cloudfront image url
        userModel.profileImageUrl = profileImageUrl;
        print("profileImageUrl: " + profileImageUrl.toString());
        getUserProfileImageResp['success'] = true;
        getUserProfileImageResp['message'] = "Profile Image Set";
        getUserProfileImageResp['data'] = profileImageUrl;
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

      dynamic updatedImage =
          jsonDecode(response.body)['data']['partialUpdateImage'];
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

  Future<Map<String, dynamic>> getImage(String? key) async {
    print("getImage()");
    Map<String, dynamic> getImageResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      final uri = Uri.parse("http://localhost:3000/images?key=$key");

      final getSignedUrlResponse = await http.get(uri);
      print("response: " + json.decode(getSignedUrlResponse.body).toString());

      getImageResponse['success'] = true;
      getImageResponse['data'] = {
        'signedUrl': json.decode(getSignedUrlResponse.body)['signedUrl'],
      };

      return getImageResponse;
    } catch (e) {
      print('Mutation failed: $e');
      return getImageResponse;
    }
  }

  Future<Map<String, dynamic>> getImageUrl(dynamic imageInput) async {
    print("getImageUrl");
    Map<String, dynamic> getUserProfileImageResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      Map<String, dynamic> getImageResp =
          await ImagesCommand().getImage(imageInput['key']);
      print("getImageResp: " + getImageResp.toString());
      if (getImageResp['success']) {
        dynamic data = getImageResp['data'];
        getUserProfileImageResponse['success'] = true;
        getUserProfileImageResponse['message'] = "Successfully found user";
        getUserProfileImageResponse['data'] = data['signedUrl'];
      }

      return getUserProfileImageResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return getUserProfileImageResponse;
    }
  }

  void addImageToUser(dynamic imageToAdd) {
    appModel.currentUser['images']['data'].add(imageToAdd);
  }

  void setChatImage(dynamic chat) {
    print("setChatImage()");
    print("chat: " + chat.toString());
    for (int i = 0; i < chatPageModel.chats.length; i++) {
      dynamic chatCopy = chatPageModel.chats[i];
      if (chatCopy['_id'] == chat['_id']) {
        print("in ifffff");
        chatCopy['mainImageKey'] = chat['key'];
        chatPageModel.chats[i] = chatCopy;
      }
    }
  }

  void setEventImage(dynamic event) {
    print("setEventImage()");
    print("event: " + event.toString());
    appModel.userEventDetails['mainEvent'] = event;
  }

  Future<Map<String, dynamic>> addImageToUserProfile(
      dynamic userInput, dynamic imageAdded) async {
    print("addImageToProfile");
    print("imageAdded: " + imageAdded.toString());
    Map<String, dynamic> addImageToProfileResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      Map<String, dynamic> getImageResp = await getImage(imageAdded['key']);
      print("getImageResp: " + getImageResp.toString());
      userInput['mainImageKey'] = imageAdded['key'];
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': UserMutations().updateUserProfileImage(userInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        Map<String, dynamic> user =
            jsonDecode(response.body)['data']['updateUser'];
        appModel.currentUser['mainImageKey'] = imageAdded['key'];
        addImageToProfileResponse["success"] = true;
        addImageToProfileResponse["message"] = "Image Added";
        addImageToProfileResponse["data"] = user;
      }

      return addImageToProfileResponse;
    } catch (e) {
      print("addImageToProfile error: " + e.toString());
      return addImageToProfileResponse;
    }
  }

  Future<Map<String, dynamic>> addImageToChat(
      dynamic chatInput, dynamic imageAdded) async {
    print("addImageToChat");
    print("imageAdded: " + imageAdded.toString());
    Map<String, dynamic> addImageToProfileResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      Map<String, dynamic> getImageResp = await getImage(imageAdded['key']);
      print("getImageResp: " + getImageResp.toString());
      chatInput['mainImageKey'] = imageAdded['key'];
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': ChatMutations().updateChatImage(chatInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        Map<String, dynamic> user =
            jsonDecode(response.body)['data']['updateChat'];
        appModel.currentUser['mainImageKey'] = imageAdded['key'];
        addImageToProfileResponse["success"] = true;
        addImageToProfileResponse["message"] = "Image Added";
        addImageToProfileResponse["data"] = user;
      }

      return addImageToProfileResponse;
    } catch (e) {
      print("addImageToProfile error: " + e.toString());
      return addImageToProfileResponse;
    }
  }

  Future<Map<String, dynamic>> addImageToEvent(
      dynamic eventInput, dynamic imageAdded) async {
    print("addImageToEvent");
    print("imageAdded: " + imageAdded.toString());
    Map<String, dynamic> addImageToProfileResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      Map<String, dynamic> getImageResp = await getImage(imageAdded['key']);
      print("getImageResp: " + getImageResp.toString());
      eventInput['mainImageKey'] = imageAdded['key'];
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + dotenv.env['FAUNADBSECRET'].toString(),
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': EventMutations().updateEventImage(eventInput),
        }),
      );

      print("response body: ");
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        Map<String, dynamic> updatedEvent =
            jsonDecode(response.body)['data']['updateEvent'];
        addImageToProfileResponse["success"] = true;
        addImageToProfileResponse["message"] = "Image Added";
        addImageToProfileResponse["data"] = updatedEvent;
      }

      return addImageToProfileResponse;
    } catch (e) {
      print("addImageToProfile error: " + e.toString());
      return addImageToProfileResponse;
    }
  }

  Future<Map<String, dynamic>> storeImageInDatabaseForChat(
      Map<String, dynamic> imageInput) async {
    print("storeImageInDatabaseForChat()");
    Map<String, dynamic> getImageResponse = {
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
          'query': ImageMutations().createChatImage(imageInput),
        }),
      );

      print("response: " + json.decode(response.body).toString());
      dynamic createImage = json.decode(response.body)['data']['createImage'];
      getImageResponse['success'] = true;
      getImageResponse['data'] = createImage;

      // appModel.currentUser['images']['data'].add(
      //     json.decode(response.body)['data']['createImage']);

      return getImageResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return getImageResponse;
    }
  }

  Future<Map<String, dynamic>> storeImageInDatabaseForUser(
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
          'query': ImageMutations().createUserImage(imageInput),
        }),
      );

      print("response: " + json.decode(response.body).toString());
      dynamic createImage = json.decode(response.body)['data']['createImage'];
      getImageResponse['success'] = true;
      getImageResponse['data'] = createImage;

      // appModel.currentUser['images']['data'].add(
      //     json.decode(response.body)['data']['createImage']);

      return getImageResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return getImageResponse;
    }
  }

  Future<Map<String, dynamic>> storeImageInDatabaseForEvent(
      Map<String, dynamic> imageInput) async {
    print("storeImageInDatabaseForEvent()");
    Map<String, dynamic> getImageResponse = {
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
          'query': ImageMutations().createEventImage(imageInput),
        }),
      );

      print("response: " + json.decode(response.body).toString());
      dynamic createImage = json.decode(response.body)['data']['createImage'];

      getImageResponse['success'] = true;
      getImageResponse['data'] = createImage;

      return getImageResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return getImageResponse;
    }
  }

  Future<Map<String, dynamic>> storeImageInDatabaseForTeam(
      Map<String, dynamic> imageInput) async {
    print("storeImageInDatabaseForTeam()");
    Map<String, dynamic> getImageResponse = {
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
          'query': ImageMutations().createTeamImage(imageInput),
        }),
      );

      print("response: " + json.decode(response.body).toString());
      dynamic createImage = json.decode(response.body)['data']['createImage'];

      getImageResponse['success'] = true;
      getImageResponse['data'] = createImage;

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
          dynamic partialUpdateImageResp =
              await partialUpdateImage(partialImageInput);
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
  Future<Map<String, dynamic>> pickImage(
      bool storeAsProfile, String imageChoiceChosen) async {
    print("pickImage()");
    Map<String, dynamic> pickImageResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      var image = null;
      if (imageChoiceChosen == Constants.PHONEGALLERY) {
        image = await ImagePicker().pickImage(source: ImageSource.gallery);
      } else if (imageChoiceChosen == Constants.CAMERA) {
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
