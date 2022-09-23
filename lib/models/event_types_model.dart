import '../strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:soccermadeeasy/svg_widgets.dart';

class EventTypesModel extends ChangeNotifier{
  // EventTypesModel(this._name, this._description, this.svgImage, this._enabled);
  

 List _enabledEvents = [
    {      
      "key": 0,
      "enabled": true,
      "name": StringConstants.PICKUPGAMESTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
     {
      "key": 1,
      "enabled": false,
      "name": StringConstants.TOURNAMENTSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    {
      "key": 2,
      "enabled": false,
      "name": StringConstants.LEAGUESTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    {      
      "key": 3,
      "enabled": false,
      "name": StringConstants.TEAMSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
    {
      "key": 4,
      "enabled": false,
      "name": StringConstants.TRYOUTSTITLE,
      "description": "",
      "image": SVGWidgets().getSoccerBallSVGImage(),
    },
  ];
  //traverse enabledEvents
  List get enabledEvents => _enabledEvents;

  void toggleEvent(int index){
    _enabledEvents[index]['enabled'] = !_enabledEvents[index]['enabled'];
    notifyListeners();
  }

  set enabledEvents(List enabledEvents){
    _enabledEvents = enabledEvents;    
    notifyListeners();
  }


}