import 'package:flutter/material.dart';

import '../../commands/images_command.dart';
import '../../commands/user_command.dart';
import '../../components/Dialogues/animated_dialogu.dart';
import '../../components/Mixins/images_mixin.dart';
import '../../components/headers.dart';
import '../../constants.dart';

class ImagesView extends StatefulWidget with ImagesMixin {
  ImagesView({Key? key})
      : super(key: key);



  @override
  _ImagesViewState createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> {
  bool _isLoading = true;
  List<dynamic> images = [];
  List imageOptions = [
    Constants.IMAGEDELETE.toString(),
    Constants.IMAGEREPLACE.toString(),    
  ];


  void getImage() async{
    print("getImage");
    for (var i = 0; i < images.length; i++) {
    String key = images[i]['key'];
    Map<String, dynamic> getImageResp = await ImagesCommand().getImage(key);
    if(getImageResp['success']){
      print("getImageResp: " + getImageResp.toString());
      images[i]['signedUrl'] = getImageResp['data']['signedUrl'];
    }
  }
  }

  void goBack() {
    Navigator.pop(context);
  }

  

  Future<void> loadInitialData() async {
    dynamic currentUser = UserCommand().getAppModelUser();
    Map<String,dynamic> allImagesFromUserResp = ImagesCommand().allImagesFromUser(currentUser);
    if(allImagesFromUserResp['success']){
      print("allImagesFromUserResp: " + allImagesFromUserResp.toString());
      images = allImagesFromUserResp['data'];
       for (var i = 0; i < images.length; i++) {
        String key = images[i]['key'];
        Map<String, dynamic> getImageResp = await ImagesCommand().getImage(key);
        if(getImageResp['success']){
          print("getImageResp: " + getImageResp.toString());
          images[i]['signedUrl'] = getImageResp['data']['signedUrl'];
        }
      }
      setState(() {
        _isLoading = false;
      });
    
    }    
       

  }

  imageOptionSelect(Map<int, dynamic> indexes,      
        List<dynamic> primaryList,
        List<dynamic> secondaryList){
    print("imageOptionSelect");
    print("indexes: " + indexes.toString());
    print("primaryList: " + primaryList.toString());
    print("secondaryList: " + secondaryList.toString());
    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic optionChosen = primaryList[mainIndex];
      print("optionChosen: " + optionChosen.toString());
      if(optionChosen == Constants.IMAGEDELETE){
        List<dynamic> imageInput = [];
        ImagesCommand().deleteImageFromDatabase(imageInput);
        ImagesCommand().deleteImageFromS3(imageInput);

      }
      else if(optionChosen == Constants.IMAGEREPLACE){


      }


    });

  }

  @override
  void initState() {
    super.initState();
    print("initState");
    loadInitialData();        
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    print("build()");
    return Scaffold(
      appBar: Headers().getBackHeader(context, "Images"),
      body: _isLoading
          ? Text("Loading...")
          : GridView.builder(
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    List<dynamic> primaryList = imageOptions;
                    List<dynamic> secondaryList = [];
                    Map<int, dynamic> result = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AnimatedDialog(
                            details: {"title": "Image Options"},
                            items: primaryList,
                            singleSelect: false,
                            secondaryItems: secondaryList,
                            goToFunctions: []);
                      },
                    );
                    if (result.isNotEmpty) {
                      print("result: " + result.toString());                      
                      imageOptionSelect(result, primaryList, secondaryList);
                      
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.amber[600],
                      image: DecorationImage(
                        image: NetworkImage(images[index]['signedUrl']
                                  .toString()), // Update this URL with your image url
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
