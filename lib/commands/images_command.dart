import 'dart:developer';

import 'package:path_provider/path_provider.dart';
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
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': ImageMutations().deleteImage(imageInput),
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        deleteImageResp['success'] = true;
        deleteImageResp['message'] = 'Image deleted';

        return deleteImageResp;
      }
      return deleteImageResp;
    } catch (e) {
      print("getImages() error: $e");
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
        "us-central1-soccer-app-a9060.cloudfunctions.net",
        '/getImages',
      );

      final getSignedUrlResponse = await http.get(uri);
      print("response: ${json.decode(getSignedUrlResponse.body)}");

      deleteImageFromS3Resp['success'] = true;

      return deleteImageFromS3Resp;
    } catch (e) {
      print("getImages() error: $e");
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
      print("getImageResp: $getImageResp");
      if (getImageResp['success']) {
        profileImageUrl = getImageResp['data']['signedUrl'];
        //set presigned cloudfront image url
        userModel.profileImageUrl = profileImageUrl;
        print("profileImageUrl: $profileImageUrl");
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
    print("processedImageInput: $processedImageInput");
    Map<String, dynamic> partialUpdateImageResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
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
      print("response: ${json.decode(getSignedUrlResponse.body)}");

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

    if (key == null) {
      return getImageResponse;
    }
    try {
      final uri = Uri.parse("http://localhost:3000/images?key=$key");

      final getSignedUrlResponse = await http.get(uri);
      print("response: ${json.decode(getSignedUrlResponse.body)}");

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

  Future<Map<String, dynamic>> getImagesList(List<String> keys) async {
    print("getImages()");

    Map<String, dynamic> getImageResponse = {
      "success": false,
      "message": "Default Error",
      "data": []
    };

    if (keys.isEmpty) {
      return getImageResponse;
    }

    try {
      final uri =
          Uri.parse("http://localhost:3000/imagesList?keys=${keys.join(',')}");

      final getSignedUrlResponse = await http.get(uri);
      print("response: ${json.decode(getSignedUrlResponse.body)}");

      getImageResponse['success'] = true;
      getImageResponse['data'] =
          json.decode(getSignedUrlResponse.body)['signedUrls'];

      return getImageResponse;
    } catch (e) {
      print('Request failed: $e');
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
      print("getImageResp: $getImageResp");
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
    print("chat: $chat");
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
    print("event: $event");
    appModel.userEventDetails['mainEvent'] = event;
  }

  Future<Map<String, dynamic>> addImageToUserProfile(
      dynamic userInput, dynamic imageAdded) async {
    print("addImageToProfile");
    print("imageAdded: $imageAdded");
    Map<String, dynamic> addImageToProfileResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      Map<String, dynamic> getImageResp = await getImage(imageAdded['key']);
      print("getImageResp: $getImageResp");
      userInput['mainImageKey'] = imageAdded['key'];
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
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
      print("addImageToProfile error: $e");
      return addImageToProfileResponse;
    }
  }

  Future<Map<String, dynamic>> addImageToChat(
      dynamic chatInput, dynamic imageAdded) async {
    print("addImageToChat");
    print("imageAdded: $imageAdded");
    Map<String, dynamic> addImageToProfileResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      Map<String, dynamic> getImageResp = await getImage(imageAdded['key']);
      print("getImageResp: $getImageResp");
      chatInput['mainImageKey'] = imageAdded['key'];
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
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
      print("addImageToProfile error: $e");
      return addImageToProfileResponse;
    }
  }

  Future<Map<String, dynamic>> addImageToEvent(
      dynamic eventInput, dynamic imageAdded) async {
    print("addImageToEvent");
    print("imageAdded: $imageAdded");
    Map<String, dynamic> addImageToProfileResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      Map<String, dynamic> getImageResp = await getImage(imageAdded['key']);
      print("getImageResp: $getImageResp");
      eventInput['mainImageKey'] = imageAdded['key'];
      http.Response response = await http.post(
        Uri.parse('https://graphql.fauna.com/graphql'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
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
      print("addImageToProfile error: $e");
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
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': ImageMutations().createChatImage(imageInput),
        }),
      );

      print("response: ${json.decode(response.body)}");
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
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': ImageMutations().createUserImage(imageInput),
        }),
      );

      log("response: ${json.decode(response.body)}");
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

  Future<bool> deleteImageFromBucket(String key) async {
    print("deleteImageFromBucket()");
    print("key: $key");
    http.Response response = await http.delete(
      // Uri.parse('http://localhost:3000/deleteImage?key=$key'),
      Uri.parse("http://localhost:3000/deleteImage?key=$key"),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'key': key,
      }),
    );
    print(response.body);
    print(response.statusCode.toString());
    return response.statusCode >= 200 && response.statusCode <= 299;
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
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': ImageMutations().createEventImage(imageInput),
        }),
      );

      print("response: ${json.decode(response.body)}");
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
          'Authorization': 'Bearer ${dotenv.env['FAUNADBSECRET']}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'query': ImageMutations().createTeamImage(imageInput),
        }),
      );

      print("response: ${json.decode(response.body)}");
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
          print("set isMainImage to false for image: $image");
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
          print("partialUpdateImageResp: $partialUpdateImageResp");
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
      print("imageTemp: $imageTemp");
      //convert to Stream
      var bytes = imageTemp.readAsBytesSync();
      String img64 = base64Encode(bytes);
      print("img64: $img64");
      String filename = imageTemp.path;
      print("filename: $filename");
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:3000/uploadImage'),
      );
      http.MultipartFile file =
          await http.MultipartFile.fromPath('image', filename);
      request.files.add(file);
      print("request: ${request.files}");
      http.StreamedResponse res = await request.send();
      var response = await http.Response.fromStream(res);
      print("upload iamge res: ${json.decode(response.body)}");

      pickImageResponse['success'] = true;
      pickImageResponse['data'] = json.decode(response.body)['data'];

      return pickImageResponse;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return pickImageResponse;
    }
  }

  //Image pick from device. Returns image path.
  Future<String?> pickImageFromDevice(String imageChoiceChosen) async {
    try {
      XFile? image;
      if (imageChoiceChosen == Constants.PHONEGALLERY) {
        image = await ImagePicker().pickImage(source: ImageSource.gallery);
      } else if (imageChoiceChosen == Constants.CAMERA) {
        image = await ImagePicker().pickImage(source: ImageSource.camera);
      }

      if (image == null) return '';

      return image.path;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');

      return '';
    }
  }

  //Image upload with given image path.
  Future<Map<String, dynamic>> uploadImage(String? imagePath) async {
    print("pickImage()");
    Map<String, dynamic> pickImageResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      if (imagePath == null) return pickImageResponse;
      final imageTemp = File(imagePath);
      String filename = imageTemp.path;
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://localhost:3000/uploadImage'));

      http.MultipartFile file =
          await http.MultipartFile.fromPath('image', filename);
      request.files.add(file);
      http.StreamedResponse res = await request.send();
      var response = await http.Response.fromStream(res);

      pickImageResponse['success'] = true;
      pickImageResponse['data'] = json.decode(response.body)['data'];

      return pickImageResponse;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return pickImageResponse;
    }
  }

  //Download image with given image url.
  Future<String?> downloadImage(String? imageUrl) async {
    try {
      if (imageUrl == null) return null;

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/image.png';
      final file = File(filePath);

      http.Response response = await http.get(
        Uri.parse(imageUrl),
      );
      final writer = file.openSync(mode: FileMode.write);
      writer.writeFromSync(response.bodyBytes);

      return filePath;
    } on PlatformException catch (e) {
      print('Failed to download image: $e');

      return '';
    }
  }
}
