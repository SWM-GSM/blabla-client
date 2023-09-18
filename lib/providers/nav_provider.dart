import 'package:flutter/material.dart';

class NavProvider with ChangeNotifier {
  int _curIdx = 1;
  int get curIdx => _curIdx;
  
  void changeIdx(int idx) {
    _curIdx = idx;
    notifyListeners();
  }
}