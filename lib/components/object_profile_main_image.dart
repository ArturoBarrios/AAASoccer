import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccermadeeasy/constants.dart';

import '../commands/images_command.dart';
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
  

  addImageToProfile(dynamic imageAdded){
    //do something

  }

  Container returnImageContainer(String imageUrl){
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
                  items: primaryList,
                  singleSelect: true,
                  secondaryItems: secondaryList);
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

  loadInitialData(){
    print("loadInitialData");
    setState(() {
      // String imageUrl = widget.objectImageInput['imageUrl'];
    });
  }  

  @override
  void initState() {
    super.initState();
    loadInitialData();
    
  }

  @override
  Widget build(BuildContext context) {
    String profileImageUrl = context
        .select<UserModel, String>((value) => value.profileImageUrl);
    print("widget.objectImageInput['containerType']: " + widget.objectImageInput['containerType'].toString());
    if (widget.objectImageInput['containerType'] == Constants.IMAGECIRCLE.toString())
      return returnImageContainer(profileImageUrl);
    else
      return Text("Nothing to show here");
  }
}
