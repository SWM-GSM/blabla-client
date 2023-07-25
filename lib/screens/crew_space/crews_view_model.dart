import 'package:blabla/models/crew.dart';
import 'package:blabla/models/report.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';

class CrewsViewModel with ChangeNotifier {
  final api = API();
  List<CrewSimple> _myCrewList = [];
  late int _crewId;
  List<Report> _reportList = [];

  List<CrewSimple> get myCrewList => _myCrewList;
  List<Report> get reportList => _reportList;
  
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

  Future<void> initCrew(int input) async {
    await Future.wait([
      setCrewId(input),
      getReports(),
    ]);
  }

  Future<void> setCrewId(int input) async {
    _crewId = input;
    notifyListeners();
  }

  Future<void> getReports() async {
    _reportList = await api.getReports(_crewId);
    notifyListeners();
  }
}