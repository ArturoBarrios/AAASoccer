import 'dart:ffi';

import 'package:flutter/foundation.dart';
import '../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';


class RequestsModel extends ChangeNotifier {
    
  List _eventRequests = [];
  List get eventRequests => _eventRequests;
  set eventRequests(List eventRequests) {
    _eventRequests = eventRequests;
    notifyListeners();
  }
 
  List _teamRequests = [];
  List get teamRequests => _teamRequests;
  set teamRequests(List teamRequests) {
    _teamRequests = teamRequests;
    notifyListeners();
  }
  
  List _friendRequests = [];
  List get friendRequests => _friendRequests;
  set friendRequests(List friendRequests) {
    _friendRequests = friendRequests;
    notifyListeners();
  }
  
}