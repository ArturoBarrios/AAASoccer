import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccermadeeasy/constants.dart';

import '../commands/images_command.dart';
import '../commands/user_command.dart';
import '../models/user_model.dart';
import 'Dialogues/animated_dialogu.dart';
import 'Mixins/images_mixin.dart';
import '../../constants.dart';

class ObjectProfileMainImage extends StatefulWidget with ImagesMixin {
  final dynamic objectImageInput;
  dynamic primaryColor = Color(0xff4338CA);

  ObjectProfileMainImage({required this.objectImageInput});

  @override
  _ObjectProfileMainImageState createState() => _ObjectProfileMainImageState();
}

class _ObjectProfileMainImageState extends State<ObjectProfileMainImage> {
  

  Future<void> addImageToProfile(dynamic imageAdded) async{
    //do something
    //get the user
    dynamic user = UserCommand().getAppModelUser();
    dynamic addImageToUserProfileResp = await ImagesCommand().addImageToUserProfile(user ,imageAdded);
    if(addImageToUserProfileResp['success']){      
      Map<String,dynamic> setUserProfileImageResp = await ImagesCommand().setUserProfileImage();

    }

  }
  
  Future<void> addImageToChat(dynamic imageAdded) async{
    //do something
    //get the user    
    print("addImageToChat");
    dynamic addImageTochatResp = await ImagesCommand().addImageToChat(widget.objectImageInput['chat'] ,imageAdded);
    if(addImageTochatResp['success']){    
      dynamic updatedChat = addImageTochatResp['data'];  
      ImagesCommand().setChatImage(updatedChat);

    }

  }
  
  Future<void> addImageToEvent(dynamic imageAdded) async{
    //do something
    //get the user    
    print("addImageToEvent");
    dynamic addImageTochatResp = await ImagesCommand().addImageToEvent(widget.objectImageInput['mainEvent'] ,imageAdded);
    if(addImageTochatResp['success']){    
      dynamic updatedEvent = addImageTochatResp['data'];  
      // ImagesCommand().setEventImage(updatedChat);

    }

  }

  Container returnProfileImageContainer(String imageUrl){
    return Container(
      child: GestureDetector(
        onTap: () async {
          List<dynamic> primaryList =
              widget.imageChoices.map((choice) => choice.values.first).toList();

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
            widget.chooseImage({"for": Constants.USER},result, primaryList, secondaryList, addImageToProfile);

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
                  gradient: RadialGradient(stops:[0.01,0.5],colors: [Colors.white, widget.primaryColor.withOpacity(0.1)]),
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
                      image: NetworkImage(imageUrl.toString()),
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

  Container returnChatImageContainer(String imageUrl){
    return Container(
      child: GestureDetector(
        onTap: () async {
          List<dynamic> primaryList =
              widget.imageChoices.map((choice) => choice.values.first).toList();

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
            widget.chooseImage({"for": Constants.CHAT, "chat": widget.objectImageInput['chat']},result, primaryList, secondaryList, addImageToChat);
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
                      image: NetworkImage(imageUrl.toString()),
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
  
  Container returnEventImageContainer(String imageUrl){
  print("imageurl: " + imageUrl.toString());
  return Container(
    child: GestureDetector(
      onTap: () async {
         List<dynamic> primaryList =
              widget.imageChoices.map((choice) => choice.values.first).toList();

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
            widget.chooseImage({"for": Constants.EVENT, "chat": widget.objectImageInput['mainEvent']},result, primaryList, secondaryList, addImageToEvent);
          }
      },
      child: Stack(
        children: [
          // Full Width Image or Gradient
          imageUrl != null
            ? Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl),
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
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
            title: Text(
              "Some Title",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
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


  loadInitialData(){
    print("loadInitialData");
    setState(() {
      // String imageUrl = widget.objectImageInput['imageUrl'];
    });
  }  

  @override
  void initState() {
    super.initState();
    print("ObjectProfileMainImage");
    loadInitialData();
    
  }

  @override
  Widget build(BuildContext context) {
    String profileImageUrl = context
        .select<UserModel, String>((value) => value.profileImageUrl);
    print("widget.objectImageInput['containerType']: " + widget.objectImageInput['containerType'].toString());
    if (widget.objectImageInput['containerType'] == Constants.PROFILEIMAGECIRCLE.toString())
      return returnProfileImageContainer(profileImageUrl);
    else if (widget.objectImageInput['containerType'] == Constants.CHATIMAGECIRCLE.toString())
      return returnChatImageContainer(widget.objectImageInput['imageUrl']);
    else if (widget.objectImageInput['containerType'] == Constants.CHATIMAGEBANNER.toString())
      return returnEventImageContainer(widget.objectImageInput['imageUrl']);
    else
      return Text("Nothing to show here");
  }
}
