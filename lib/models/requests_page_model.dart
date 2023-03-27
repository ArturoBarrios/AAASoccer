import 'dart:ffi';

import 'package:flutter/foundation.dart';
import '../strings.dart';
import 'package:soccermadeeasy/svg_widgets.dart';
import '../constants.dart';

import '../views/game/create.dart';
import '../views/league/create.dart';
import '../views/tournament/create.dart';
import '../views/training/create.dart';
import '../views/tryout/create.dart';
import '../views/team/create/create.dart';


class RequestsPageModel extends ChangeNotifier {

  String _selectedKey = "SENT";
  String get selectedKey => _selectedKey;
  set selectedKey(String selectedKey){
    _selectedKey = selectedKey;
    notifyListeners();
  }  

  bool _initialConditionsMet = true;
  bool get initialConditionsMet => _initialConditionsMet;  
  set initialConditionsMet(bool initialConditionsMet){
    _initialConditionsMet = initialConditionsMet;
    notifyListeners();
  }  
  

  List _selectedObjects = [];
  List get selectedObjects => _selectedObjects;
  set selectedObjects(List selectedObjects){
    print("set selected objects!");
    _selectedObjects = selectedObjects;
    notifyListeners();
  }  

}