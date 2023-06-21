import 'package:flutter/material.dart';

import '../../components/headers.dart';
import '../commands/images_command.dart';
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
    images = widget.details['mainEvent']['images']['data'];
    widget.details['for'] = Constants.EVENT;
  } else if (widget.details['team'] != null) {
    widget.details['for'] = Constants.TEAM;
    images = widget.details['team']['images']['data'];
  } else {
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
        ? Text("Loading...")
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
                            items: primaryList,
                            singleSelect: true,
                            secondaryItems: secondaryList);
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
                  height: 500, // specify the height as per your requirement
                  child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      print("images[index]['signedUrl']: " +
                          images[index]['signedUrl'].toString());
                      return GestureDetector(
                        onTap: () {
                          // getImage();
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
