
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  TapbarselectedBool _valueselected = new TapbarselectedBool(true,false,false);
  TapbarselectedBool get selectedValue => _valueselected;
  void chageModel(TapbarselectedBool s) {
    _valueselected =s;
    notifyListeners();
  }

}

class TapbarselectedBool {
  final bool Traditional;
  final bool Sides;
  final bool Beverage;
  TapbarselectedBool(this.Traditional,this.Sides,this.Beverage);

}