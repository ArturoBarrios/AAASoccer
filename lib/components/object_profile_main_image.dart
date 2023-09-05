import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccermadeeasy/constants.dart';

import '../commands/images_command.dart';
import '../commands/user_command.dart';
import '../models/user_model.dart';
import 'Dialogues/animated_dialogu.dart';
import 'Mixins/images_mixin.dart';
import 'app_images_gallery.dart';

class ObjectProfileMainImage extends StatefulWidget with ImagesMixin {
  final dynamic objectImageInput;
  dynamic primaryColor = const Color(0xff4338CA);

  ObjectProfileMainImage({Key? key, required this.objectImageInput})
      : super(key: key);

  @override
  State<ObjectProfileMainImage> createState() => _ObjectProfileMainImageState();
}

class _ObjectProfileMainImageState extends State<ObjectProfileMainImage> {
  Future<void> addImageToProfile(dynamic imageAdded) async {
    //do something
    //get the user
    print('imageAdded');
    print(imageAdded.runtimeType);
    print(imageAdded.toString());
    dynamic user = UserCommand().getAppModelUser();
    dynamic addImageToUserProfileResp =
        await ImagesCommand().addImageToUserProfile(user, imageAdded);
    if (addImageToUserProfileResp['success']) {
      Map<String, dynamic> setUserProfileImageResp =
          await ImagesCommand().setUserProfileImage();
    }
  }

  Future<void> addImageToChat(dynamic imageAdded) async {
    //do something
    //get the user
    print("addImageToChat");
    dynamic addImageTochatResp = await ImagesCommand()
        .addImageToChat(widget.objectImageInput['chat'], imageAdded);
    if (addImageTochatResp['success']) {
      dynamic updatedChat = addImageTochatResp['data'];
      ImagesCommand().setChatImage(updatedChat);
    }
  }

  Future<void> addImageToEvent(dynamic imageAdded) async {
    //do something
    //get the user
    print("addImageToEvent");
    dynamic addImageTochatResp = await ImagesCommand()
        .addImageToEvent(widget.objectImageInput['mainEvent'], imageAdded);
    if (addImageTochatResp['success']) {
      dynamic updatedEvent = addImageTochatResp['data'];
      ImagesCommand().setEventImage(updatedEvent);
    }
  }

  Container returnProfileImageContainer(String imageUrl) {
    print("returnProfileImageContainer: $imageUrl");
    return Container(
      child: GestureDetector(
        onTap: () async {
          List<dynamic> primaryList =
              widget.imageChoices.map((choice) => choice.values.first).toList();

          List<dynamic> secondaryList = [];
          Map<int, dynamic>? result = await showDialog(
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
          if (result != null && result.isNotEmpty) {
            if (result.entries.first.key == 2) {
              dynamic currentUser = UserCommand().getAppModelUser();
              Map<String, dynamic> allImagesFromUserResp =
                  ImagesCommand().allImagesFromUser(currentUser);
              var imagesData = allImagesFromUserResp['data'] as List;
              var imagesUrls =
                  imagesData.map((e) => e['signedUrl'] as String).toList();
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AppImagesGallery(
                    imagesUrls: imagesUrls,
                  ),
                  fullscreenDialog: true,
                ),
              );
              if (result != null) {
                var selectedIndex = result as int;
                var imageToadd = imagesData[selectedIndex];
                addImageToProfile(imageToadd);
              }
            } else {
              widget.chooseImage(
                null,//null because we already have access to user
                Constants.USER,
                result,
                primaryList,
                secondaryList,
                addImageToProfile,
              );
            }
          }
        },
        child: Hero(
          tag: "profile",
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                  child: Container(
                height: 190.0,
                width: 190.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(102.5),
                    color: widget.primaryColor.withOpacity(0.05)),
              )),
              Container(
                  child: Container(
                height: 170.0,
                width: 170.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(102.5),
                  gradient: RadialGradient(stops: const [
                    0.01,
                    0.5
                  ], colors: [
                    Colors.white,
                    widget.primaryColor.withOpacity(0.1)
                  ]),
                ),
              )),
              Container(
                  child: Container(
                height: 150.0,
                width: 150.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(102.5),
                    color: widget.primaryColor.withOpacity(0.4)),
              )),
              Container(
                child: Container(
                    height: 132.0,
                    width: 132.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(102.5),
                        color: widget.primaryColor.withOpacity(0.5))),
              ),
              Container(
                child: Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(62.5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl.toString() != ''
                          ? imageUrl.toString()
                          : "https://gravatar.com/avatar/f33c768ea4c84ac3662a4e2646362f14?s=400&d=robohash&r=x"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget returnChatImageContainer(String? imageUrl) {
    return GestureDetector(
      onTap: () async {
        List<dynamic> primaryList =
            widget.imageChoices.map((choice) => choice.values.first).toList();

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
          widget.chooseImage(
              widget.objectImageInput['chat'],
              Constants.CHAT,
              result,
              primaryList,
              secondaryList,
              addImageToChat);
        }
      },
      child: Hero(
        tag: "profile",
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(62.5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl.toString() != '' &&
                            imageUrl != null
                        ? imageUrl.toString()
                        : "https://gravatar.com/avatar/f33c768ea4c84ac3662a4e2646362f14?s=400&d=robohash&r=x"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container returnEventImageContainer(String? imageUrl) {
    print("returnEventImageContainer() imageurl: $imageUrl");
    print("widget.objectImageInput: ${widget.objectImageInput}");
    return Container(
      child: GestureDetector(
        onTap: () async {
          if (widget.objectImageInput['isMine']) {
            List<dynamic> primaryList = widget.imageChoices
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
              widget.chooseImage(
                widget.objectImageInput['mainEvent'],
                Constants.EVENT,                
               result, primaryList, secondaryList, addImageToEvent);
            }
          }
        },
        child: Stack(
          children: [
            // Full Width Image or Gradient
            imageUrl != ""
                ? Container(
                    width: double.infinity,
                    height: 200.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl.toString()),
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 200.0,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue,
                          Colors.red,
                        ],
                      ),
                    ),
                  ),
            // Title and Back Button
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: const Text(
                "Some Title",
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  loadInitialData() {
    print("loadInitialData");
    setState(() {
      // String imageUrl = widget.objectImageInput['imageUrl'];
    });
  }

  @override
  void initState() {
    super.initState();
    print("initState() ObjectProfileMainImage");
    print("widget.objectImageInput.toString() ${widget.objectImageInput}");
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    String profileImageUrl =
        context.select<UserModel, String>((value) => value.profileImageUrl);

    print(widget.objectImageInput);

    print(
        "widget.objectImageInput['containerType']: ${widget.objectImageInput['containerType']}");
    if (widget.objectImageInput['containerType'] ==
        Constants.PROFILEIMAGECIRCLE.toString()) {
      return returnProfileImageContainer(profileImageUrl);
    } else if (widget.objectImageInput['containerType'] ==
        Constants.CHATIMAGECIRCLE.toString()) {
      return returnChatImageContainer(widget.objectImageInput['imageUrl']);
    } else if (widget.objectImageInput['containerType'] ==
        Constants.IMAGEBANNER.toString()) {
      return returnEventImageContainer(widget.objectImageInput['imageUrl']);
    } else {
      return const Text("Nothing to show here");
    }
  }
}
