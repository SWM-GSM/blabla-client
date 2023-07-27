import 'package:flutter/material.dart';

enum HistoryFilter {
  all("earth", "전체"),
  crew("team", "크루"),
  personal("people", "개인");

  const HistoryFilter(this.icon, this.name);
  final String icon;
  final String name;
}

class ReportViewModel with ChangeNotifier {
  HistoryFilter filter = HistoryFilter.all;
  
  ReportViewModel() {

  }

  void setHistoryFilter(HistoryFilter input) {
    filter = input;
    notifyListeners();
  }
}