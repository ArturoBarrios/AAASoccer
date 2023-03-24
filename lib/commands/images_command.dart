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
      print("response: " + json.decode(getSignedUrlResponse.body)['signedUrl'].toString());

      getImageResponse['success'] = true;
      getImageResponse['signedUrl'] = json.decode(getSignedUrlResponse.body)['signedUrl'];
      return getImageResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return getImageResponse;
    }

  }

  Future<Map<String, dynamic>> storeImageInDatabase(Map<String, dynamic> imageInput) async{
    print("storeImage()");
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
            'query':
                ImageMutations().createImage(imageInput),
          }),
        );
      

      
      getImageResponse['success'] = true;
      return getImageResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return getImageResponse;
    }
  }

  //Image Picker
  Future<Map<String, dynamic>> pickImage(bool storeAsProfile) async {
      print("pickImage()");
      Map<String, dynamic> pickImageResponse = {
        "success": false,
        "message": "Default Error",
        "data": null
      };
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
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
          'POST',          
          Uri.parse('http://localhost:3000/uploadImage'));
      http.MultipartFile file =
          await http.MultipartFile.fromPath('image', filename);
      request.files.add(file);
      print("request: " + request.files.toString());
      http.StreamedResponse res = await request.send();
      var response = await http.Response.fromStream(res);
      print("upload iamge res: " + json.decode(response.body).toString());
      


      pickImageResponse['success'] = true;
      pickImageResponse['data'] = json.decode(response.body);
      

      return pickImageResponse;

    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return pickImageResponse;
    }
  }
}
