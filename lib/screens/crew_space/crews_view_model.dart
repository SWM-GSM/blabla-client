import 'package:blabla/models/crew.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';

class CrewsViewModel with ChangeNotifier {
  final api = API();
  List<CrewSimple> _myCrewList = [];

  List<CrewSimple> get myCrewList => _myCrewList;
  
  CrewsViewModel() {
    init();
  }

  void init() async {
    await getMyCrews();
  }


  Future<void> getMyCrews() async {
    _myCrewList = await api.getMyCrews();
    notifyListeners();
  }
}