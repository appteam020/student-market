import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterProvider with ChangeNotifier{
  String name="nada";

String get getName => name;

  void setName(String newName) {
    name = newName;
    notifyListeners();
  }

 

   
  
}