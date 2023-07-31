import 'package:blabla/models/crew.dart';
import 'package:blabla/models/report.dart';
import 'package:blabla/models/schedule.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';

class CrewsViewModel with ChangeNotifier {
  final api = API();
  
  List<CrewSimple> _myCrewList = [];
  List<CrewSimple> get myCrewList => _myCrewList;

  /* 개별 크루 스페이스 */
  late int _crewId;
  late String _crewName;
  List<Report> _reportList = [];
  late ReportDetail _report; 
  late ScheduleSimple _upcomingSchedule;

  String get crewName => _crewName;
  List<Report> get reportList => _reportList;
  ReportDetail get report => _report;
  ScheduleSimple get upcomingSchedule => _upcomingSchedule;
  
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

  Future<void> initCrew(int crewId, String crewName) async {
    setCrewId(crewId);
    setCrewName(crewName);
    await Future.wait([
      getReports(),
      getUpcomingSchedule(),
    ]);
  }

  void setCrewId(int input) {
    _crewId = input;
    notifyListeners();
  }

  void setCrewName(String input) {
    _crewName = input;
    notifyListeners();
  }

  Future<void> getReports() async {
    _reportList = await api.getReports(_crewId);
    notifyListeners();
  }

  Future<void> getUpcomingSchedule() async {
    _upcomingSchedule = await api.getUpcomingSchedule(_crewId);
    notifyListeners();
  }

  Future<void> setReport(int reportId) async {
    _report = await api.getDetailReport(_crewId, reportId);
    notifyListeners();
  }
}