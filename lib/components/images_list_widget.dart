import 'package:flutter/material.dart';

import '../../components/headers.dart';
import '../commands/images_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import 'Dialogues/animated_dialogu.dart';
import 'Mixins/images_mixin.dart';

class ImagesListWidget extends StatefulWidget with ImagesMixin {
  ImagesListWidget({Key? key, required this.details}) : super(key: key);

  final dynamic details;

  @override
  _ImagesListWidgetState createState() => _ImagesListWidgetState();
}

class _ImagesListWidgetState extends State<ImagesListWidget> {
  bool _isLoading = true;
  List<dynamic> images = [];
  List imageOptions = [
    Constants.IMAGEDELETE.toString(),
    Constants.IMAGEREPLACE.toString(),    
    
  ];

  void getImage() async {
    print("getImage");
    // Map<String, dynamic> imageResp = await ImagesCommand().getImages();
  }

  void goBack() {
    Navigator.pop(context);
  }

  Future<void> loadInitialData() async {
  print("loadInitialData ImagesListWidget");
  
  if (widget.details['mainEvent'] != null) {    
    print("images in mainEvent");
    images = widget.details['mainEvent']['images']['data'];    
    widget.details['for'] = Constants.EVENT;

  } else if (widget.details['team'] != null) {    
    print("images in team");
    widget.details['for'] = Constants.TEAM;
    images = widget.details['team']['images']['data'];

  } else {    
    print("images in user");
    dynamic currentUser = UserCommand().getAppModelUser();
    Map<String,dynamic> allImagesFromUserResp = ImagesCommand().allImagesFromUser(currentUser);
    images = allImagesFromUserResp['data'];
    widget.details['for'] = Constants.USER;

  } 
  
  print("images: " + images.toString());

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

  addImage(dynamic image) async {
    print("addImage");
    print("image: " + image.toString());
    Map<String, dynamic> getImageResp = await ImagesCommand().getImage(image['key']);
    if(getImageResp['success']){
      print("getImageResp: " + getImageResp.toString());
      String signedUrl = getImageResp['data']['signedUrl'];
      setState(() {
        image['signedUrl'] = signedUrl;
        images.add(image);     
         
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

    imageOptions.removeAt(imageOptions.length-1);

  }

  removeImage() {}

  @override
  void initState() {
    super.initState();
    print("initState");
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    print("build()");
    return _isLoading
        ? Text("Loading Images...")
        : Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    List<dynamic> primaryList = widget.imageChoices
                        .map((choice) => choice.values.first)
                        .toList();

                    List<dynamic> secondaryList = [];
                    Map<int, dynamic> result = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AnimatedDialog(
                            details: {"title": "Image Options"},
                            items: primaryList,
                            singleSelect: true,
                            secondaryItems: secondaryList,
                            goToFunctions: []);
                      },
                    );
                    if (result.isNotEmpty) {
                      print("result: " + result.toString());
                      widget.chooseImage(widget.details, result, primaryList,
                          secondaryList, addImage);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Add Image',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 300, // specify the height as per your requirement
                  child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      print("images[index]" +
                          images[index].toString());
                      return GestureDetector(
                        onTap: () async {
                          
                          if(images[index]['event'] != null){
                            imageOptions.add(Constants.VIEWEVENT);                            
                          }
                          else if(images[index]['team'] != null){
                            imageOptions.add(Constants.VIEWTEAM);
                          }
                          else{
                            imageOptions.add(Constants.VIEWUSER);
                          }
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
                    else{
                      setState(() {
                        imageOptions.removeAt(imageOptions.length-1);
                        
                      });
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
                ),
              ],
            ),
          );
  }
}
