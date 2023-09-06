import 'package:blabla/models/history.dart';
import 'package:blabla/services/apis/api.dart';
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
  final api = API();

  HistoryFilter _filter = HistoryFilter.all;
  List<History> _histories = [];

  HistoryFilter get filter => _filter;
  List<History> get histories => _histories;
  
  // Map<HistoryFilter, List<History>> _filteredHistories = {};
  // Map<HistoryFilter, List<History>> get filteredHistories => _filteredHistories;

  ReportViewModel() {
    getHistories();
  }

  void getHistories() async {
    _histories = [...await api.getHistory()];
    notifyListeners();
  }

  void makeHistories() async {
    
  }

  void setHistoryFilter(HistoryFilter input) {
    _filter = input;
    notifyListeners();
  }
}
