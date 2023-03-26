import 'dart:ui';
import '../commands/base_command.dart';
import '../models/user_model.dart';
import 'package:flutter/material.dart';
import '../commands/images_command.dart';
import 'package:provider/provider.dart';


// Change color here
const primaryColor = Color(0xff4338CA);
// // // // // // // // // // // // // // //
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();

  
}

class _ProfileState extends State<Profile> {
    String profileImageUrl = "";
    
    // void getProfileImage() {
    //   print("profileImage()");
    //   // profileImageUrl = BaseCommand().getProfileUrl();
    //   print("profileImage: " + profileImageUrl);
    // }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getProfileImage();
  }


  @override
  Widget build(BuildContext context) {
    String profileImageUrl = context.
      select<UserModel, String>((value) => value.profileImageUrl);


    void pickImage() async {
      Map<String, dynamic> pickImageResp = await ImagesCommand().pickImage(true);  
      print("pickImageResp: " + pickImageResp.toString());
      dynamic data = pickImageResp['data'];
      print("data: " + data.toString());
      String key = data['key'];
      print("keyyyyyy: " + key.toString());
      String s3bucket = data['Bucket'];
      Map<String, dynamic> imageInput = {
        "isMainImage": true,
        "key": key,  
        "public": true,  
        "s3bucket": s3bucket    
      };

      await ImagesCommand().removeProfileTagFromImage();
      await ImagesCommand().storeImageInDatabase(imageInput);
      await ImagesCommand().getAndSetUserProfileImage();
      
      
      //place image as profile picture

      //testing out getting image from cloudfront
      // await ImagesCommand().getImage();
      //add image to user profile    
    }

    return  Scaffold(
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              new Align(alignment: Alignment.centerLeft,
               child: 
            IconButton(icon: const Icon(Icons.arrow_back),
            tooltip: 'Go back',
            onPressed: () {
              Navigator.pop(context);             
            },
          )),                
        // new Align(alignment: Alignment.centerLeft, child: new Text("left")),
                GestureDetector(
                  onTap: () {
                    pickImage();                    
                  },
                  child: 
                
                Hero(
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
                                color: primaryColor.withOpacity(0.05)),
                        )),
                      
                    Container(
                        child: Container(
                            height: 170.0,
                            width: 170.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(102.5),
                                gradient: RadialGradient(stops:[0.01,0.5],colors: [Colors.white,primaryColor.withOpacity(0.1)]),
                        )),
                      ),
                    Container(
                        child: Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(102.5),
                                color: primaryColor
                                    .withOpacity(0.4))),
                      ),
                      Container(
                        child: Container(
                            height: 132.0,
                            width: 132.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(102.5),
                                color: primaryColor
                                    .withOpacity(0.5))),
                      ),
                    
                    
                                       Container(
                        child: Container(
                          height: 125.0,
                          width: 125.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(62.5),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(profileImageUrl))),
                        ),
                      ),
                    
                  ],
                ),)),
                SizedBox(height: 25.0),
                Text(
                  'Roboh Dash',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Durham, NH',
                  style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '34',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            'Friends',
                            style: TextStyle(
                                fontFamily: 'Montserrat', color: Colors.grey),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '310',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            'Stars',
                            style: TextStyle(
                                fontFamily: 'Montserrat', color: Colors.grey),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '10',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            "Level",
                            style: TextStyle(
                                fontFamily: 'Montserrat', color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                ),              
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.table_chart),onPressed: (){},),
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),

                InfoDetailListTile(
                    name:"Excellent Perfomance", value:"Top 1%", tooltip: "Today", date: "02/23/2019"),
               InfoDetailListTile(
                    name:"Amazing value!", value:"😂", tooltip:"Today", date: "02/22/2019"),
                     InfoDetailListTile(
                    name:"Runner-up of Voting Cup",value: "#3", tooltip: "Yesterday", date: "02/22/2019"),
                    InfoDetailListTile(
                    name:"Victory is super close", value:"🔥", tooltip: "Yesterday",date: "02/22/2019"),
                    Container(  
                      margin: EdgeInsets.all(25),  
                      child: ElevatedButton(
                  onPressed: () {
                    BaseCommand().signOut();
                  },
                  // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                  style: ElevatedButton.styleFrom(
                      elevation: 12.0,
                      textStyle: const TextStyle(color: Colors.white)),
                  child: const Text('Sign Out'),
                ),
                    ),  
                   
              ],
            )
          ],
        ),
    );
  }
}

class InfoDetailListTile extends StatelessWidget {
  final String name;
   final String value;
    final String tooltip;
     final String date;

  const InfoDetailListTile({required this.name, required this.value, required this.tooltip, required this.date,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 15.0),
              ),
              SizedBox(height: 7.0),
              Row(
                children: <Widget>[
                  Text(
                    tooltip,
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  ),
                  SizedBox(width: 4.0),
                  Icon(
                    Icons.timer,
                    size: 4.0,
                    color: Colors.black,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  )
                ],
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                value,
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontFamily: 'Montserrat',
                    fontSize: 20.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}
 