import 'package:flutter/widgets.dart';

class BottomBarProvider with ChangeNotifier{
  int _index = 0;

  int get index => _index;
  
  set navPageIndex(int value){
    _index = value;
    notifyListeners();
  }
}