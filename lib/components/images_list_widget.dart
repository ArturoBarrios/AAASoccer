import 'package:flutter/material.dart';
import '../commands/images_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import 'Dialogues/animated_dialogu.dart';
import 'Mixins/images_mixin.dart';

class ImagesListWidget extends StatefulWidget {
  ImagesListWidget({
    Key? key,
    required this.details,
  }) : super(key: key);

  dynamic details;

  @override
  State<ImagesListWidget> createState() => _ImagesListWidgetState();
}

class _ImagesListWidgetState extends State<ImagesListWidget> with ImagesMixin {
  bool _isLoading = true;
  List<dynamic> images = [];
  Map<dynamic, dynamic> details = {};
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

    if (details['mainEvent'] != null) {
      print("images in mainEvent");
      images = details['mainEvent']['images']['data'];
      details['for'] = Constants.EVENT;
    } else if (details['team'] != null) {
      print("images in team");
      details['for'] = Constants.TEAM;
      images = details['team']['images']['data'];
    } else {
      print("images in user");
      dynamic currentUser = UserCommand().getAppModelUser();
      Map<String, dynamic> allImagesFromUserResp =
          ImagesCommand().allImagesFromUser(currentUser);
      images = allImagesFromUserResp['data'];
      details['for'] = Constants.USER;
    }

    print("images: $images");

    for (var i = 0; i < images.length; i++) {
      String key = images[i]['key'];
      Map<String, dynamic> getImageResp = await ImagesCommand().getImage(key);
      if (getImageResp['success']) {
        print("getImageResp: $getImageResp");
        images[i]['signedUrl'] = getImageResp['data']['signedUrl'];
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  addImage(dynamic image) async {
    print("addImage");
    print("image: $image");
    Map<String, dynamic> getImageResp =
        await ImagesCommand().getImage(image['key']);
    if (getImageResp['success']) {
      print("getImageResp: $getImageResp");
      String signedUrl = getImageResp['data']['signedUrl'];
      setState(() {
        image['signedUrl'] = signedUrl;
        images.add(image);
      });
    }
  }

  imageOptionSelect(
    Map<int, dynamic> indexes,
    List<dynamic> primaryList,
    List<dynamic> secondaryList,
    String signedUrl,
  ) {
    print("imageOptionSelect");
    print("indexes: $indexes");
    print("primaryList: $primaryList");
    print("secondaryList: $secondaryList");
    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic optionChosen = primaryList[mainIndex];
      print("optionChosen: $optionChosen");
      if (optionChosen == Constants.IMAGEDELETE) {
        final key = Uri.parse(signedUrl).pathSegments.last;
        deleteImage(key);
      } else if (optionChosen == Constants.IMAGEREPLACE) {}
    });

    imageOptions.removeAt(imageOptions.length - 1);
  }

  removeImage() {}

  @override
  void initState() {
    super.initState();
    print("initState");

    widget.details.forEach((key, value) {
      details[key] = value;
    });
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    print("build()");
    return _isLoading
        ? const Text("Loading Images...")
        : Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    List<dynamic> primaryList = imageChoices
                        .map((choice) => choice.values.first)
                        .toList();

                    List<dynamic> secondaryList = [];
                    Map<int, dynamic> result = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AnimatedDialog(
                            details: const {"title": "Image Options"},
                            items: primaryList,
                            singleSelect: true,
                            secondaryItems: secondaryList,
                            goToFunctions: const []);
                      },
                    );
                    if (result.isNotEmpty) {
                      print("result: $result");
                      chooseImage(
                        details,
                        result,
                        primaryList,
                        secondaryList,
                        addImage,
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
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
                SizedBox(
                  height: 300, // specify the height as per your requirement
                  child: GridView.builder(
                    itemCount: images.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      print("images[index]${images[index]}");
                      return GestureDetector(
                        onTap: () async {
                          if (images[index]['event'] != null) {
                            if (!imageOptions.contains(Constants.VIEWEVENT)) {
                              imageOptions.add(Constants.VIEWEVENT);
                            }
                          } else if (images[index]['team'] != null) {
                            if (!imageOptions.contains(Constants.VIEWTEAM)) {
                              imageOptions.add(Constants.VIEWTEAM);
                            }
                          } else {
                            if (!imageOptions.contains(Constants.VIEWUSER)) {
                              imageOptions.add(Constants.VIEWUSER);
                            }
                          }
                          List<dynamic> primaryList = imageOptions;
                          List<dynamic> secondaryList = [];
                          Map<int, dynamic>? result = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AnimatedDialog(
                                  details: const {"title": "Image Options"},
                                  items: primaryList,
                                  singleSelect: false,
                                  secondaryItems: secondaryList,
                                  goToFunctions: const []);
                            },
                          );
                          if (result?.isNotEmpty == true) {
                            print("result: $result");
                            imageOptionSelect(
                              result!,
                              primaryList,
                              secondaryList,
                              images[index]['signedUrl'].toString(),
                            );
                          } else {
                            setState(() {
                              imageOptions.removeAt(imageOptions.length - 1);
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
