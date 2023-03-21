import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagesCommand extends BaseCommand {
  Future<Map<String, dynamic>> getImages() async {
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

  Future<Map<String, dynamic>> getImage() async{
     print("getImage()");
    Map<String, dynamic> getImageResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };

    try {      
      final uri = Uri.parse("http://localhost:3000/images");

      final getSignedUrlResponse = await http.get(uri);
      print("response: " + json.decode(getSignedUrlResponse.body).toString());

      getImageResponse['success'] = true;
      return getImageResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return getImageResponse;
    }

  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      // setState(() => this.image = imageTemp);
      print("imageTemp: " + imageTemp.toString());
      //convert to Stream
      var bytes = imageTemp.readAsBytesSync();
      String img64 = base64Encode(bytes);
      print("img64: " + img64);
      String filename = imageTemp.path;
      print("filename: " + filename);

      var request = http.MultipartRequest(
          'POST',          
          Uri.parse('http://localhost:3000/uploadImage'));
      http.MultipartFile file =
          await http.MultipartFile.fromPath('image', filename);
      request.files.add(file);
      print("request: " + request.files.toString());
      http.StreamedResponse res = await request.send();
      var response = await http.Response.fromStream(res);
      print("upload iamge res: " + json.decode(response.body).toString());
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
