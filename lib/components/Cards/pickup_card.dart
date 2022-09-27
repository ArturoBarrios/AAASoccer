import 'package:flutter/material.dart';
//components
import '../Buttons/basic_elevated_button.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:soccermadeeasy/svg_widgets.dart';

class PickupCard extends StatefulWidget {
  const PickupCard({Key? key}) : super(key: key);

  @override
  State<PickupCard> createState() => _PickupCard();
}

class _PickupCard extends State<PickupCard> {
  bool visible = false;
  final String title = "Pickup";
  final String body = "Some description";
  void onMoreTap() {

  }

  final String subInfoTitle = "subInfoTitle";
  final String subInfoText = "subInfoText";
  // final Widget subIcon = SVGWidgets().getSoccerBallSVGImagePath();;
  @override
  Widget build(BuildContext context) {    
    
    return Container(
      padding: EdgeInsets.all(25.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: Offset(0, 10),
              blurRadius: 0,
              spreadRadius: 0,
            )
          ],
          gradient: RadialGradient(
            colors: [Colors.orangeAccent, Colors.orange],
            focal: Alignment.topCenter,
            radius: .85,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: 75,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  gradient: LinearGradient(
                      colors: [Colors.white, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: GestureDetector(
                  onTap: onMoreTap,
                  child: Center(
                      child: Text(
                    "More",
                    style: TextStyle(color: Colors.orange),
                  )),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            body,
            style:
                TextStyle(color: Colors.white.withOpacity(.75), fontSize: 14),
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // subIcon,
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subInfoTitle),
                      Text(
                        subInfoText,
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
    // Container(
    //   height: 150,
    //   width: MediaQuery.of(context).size.width * 1,
    //   child: Card(
    //     color: Colors.red,
    //     child: Row(children: const <Widget> [
    //       Text("test"),
    //       Align(
    //         alignment: Alignment.bottomCenter,
    //         child: 
            
    //           BasicElevatedButton())

    //     ]),
        
    // ));
  }
}


// new GestureDetector(
    //     onTap: (){
    //       print("Container clicked");
    //     },
    //     child: new Container(
    //       width: 500.0,
    //       padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
    //       color: Colors.green,
    //       child: new Column(
    //           children: [
    //             new Text("Ableitungen"),
    //           ]
    //       ),
    //     )
    // );


