import 'package:blabla/models/crew.dart';
import 'package:blabla/models/report.dart';
import 'package:blabla/models/schedule.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class CrewsViewModel with ChangeNotifier {
  final api = API();

  List<CrewSimple> _myCrewList = [];
  List<CrewSimple> get myCrewList => _myCrewList;

  /* 개별 크루 스페이스 */
  late int _crewId;
  late String _crewName;
  List<Report> _reportList = [];
  late ReportDetail _report;
  late ScheduleSimple? _upcomingSchedule;
  List<Schedule> _schedules = [];
  Map<DateTime, List<Schedule>> _schedulesForCalendar = {};
  DateTime _selectedDate = DateTime.now();

  String get crewName => _crewName;
  List<Report> get reportList => _reportList;
  ReportDetail get report => _report;
  ScheduleSimple? get upcomingSchedule => _upcomingSchedule;
  Map<DateTime, List<Schedule>> get schedulesForCalendar =>
      _schedulesForCalendar;
  DateTime get selectedDate => _selectedDate;
  List<Schedule>? get selectedDateSchedules => schedulesForCalendar[
      DateTime(selectedDate.year, selectedDate.month, selectedDate.day)];

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
      getSchedules(),
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

  Future<void> getSchedules() async {
    _schedules = await api.getSchedules(_crewId);
    _schedulesForCalendar = {};
    for (var e in _schedules) {
      if (_schedulesForCalendar[DateTime(
              e.meetingTime.year, e.meetingTime.month, e.meetingTime.day)] ==
          null) {
        _schedulesForCalendar[DateTime(
            e.meetingTime.year, e.meetingTime.month, e.meetingTime.day)] = [e];
      } else {
        _schedulesForCalendar[DateTime(
                e.meetingTime.year, e.meetingTime.month, e.meetingTime.day)]!
            .add(e);
      }
    }
    notifyListeners();
  }

  void setSelectedDate(DateTime input) {
    _selectedDate = input;
    notifyListeners();
  }

  void createSchedule(String title, String meetingTime) async {
    if (await api.createSchedule(_crewId, title, meetingTime)) {
      await Future.wait([
        getSchedules(),
        getUpcomingSchedule(),
      ]);
    }
    notifyListeners();
  }

  void joinSchedule(int scheduleId) async {
    if (await api.joinSchedule(_crewId, scheduleId)) {
      await getSchedules();
      notifyListeners();
    } else {
      showToast("일정 가입에 실패했습니다. 다시 시도 해주세요.");
    }
  }

  void cancelSchedule(int scheduleId) async {
    if (await api.cancelSchedule(_crewId, scheduleId)) {
      await getSchedules();
      notifyListeners();
    } else {
      showToast("일정 가입에 실패했습니다. 다시 시도 해주세요.");
    }
  }
}
