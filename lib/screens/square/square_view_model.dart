import 'package:blabla/models/schedule.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class SquareViewModel with ChangeNotifier {
  final api = API();

  /* 보이스룸 */
  int? _myId;
  String? _agoraToken;

  int? get myId => _myId;
  String? get agoraToken => _agoraToken;

  SquareViewModel() {
    getMyId();
    getAgoraToken();
    getUpcomingSchedule();
    getSchedules();
  }

  void getMyId() async {
    _myId = await api.getMyId();
    print(_myId);
    notifyListeners();
  }

  void getAgoraToken() async {
    _agoraToken = (await api.getAgoraToken(false)).token;
    print(_agoraToken);
  }

  /* 일정 */
  ScheduleSimple? _upcomingSchedule;
  List<Schedule>? _schedules;
  Map<DateTime, List<Schedule>> _schedulesForCalendar = {};
  DateTime _selectedDate = DateTime.now();

  ScheduleSimple? get upcomingSchedule => _upcomingSchedule;
  List<Schedule>? get schedules => _schedules;
  Map<DateTime, List<Schedule>> get schedulesForCalendar =>
      _schedulesForCalendar;
  DateTime get selectedDate => _selectedDate;
  List<Schedule>? get selectedDateSchedules => schedulesForCalendar[
      DateTime(selectedDate.year, selectedDate.month, selectedDate.day)];

  Future<void> getUpcomingSchedule() async {
    _upcomingSchedule = await api.getUpcomingSchedule();
    notifyListeners();
  }

  Future<void> getSchedules() async {
    _schedules = await api.getSchedules();
    _schedulesForCalendar = {};
    for (var e in _schedules!) {
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
    if (await api.createSchedule(title, meetingTime)) {
      await Future.wait([
        getSchedules(),
        getUpcomingSchedule(),
      ]);
    }
    notifyListeners();
  }

  void joinSchedule(int scheduleId) async {
    if (await api.joinSchedule(scheduleId)) {
      await getSchedules();
      notifyListeners();
    } else {
      showToast("일정 가입에 실패했습니다. 다시 시도 해주세요.");
    }
  }

  void cancelSchedule(int scheduleId) async {
    if (await api.cancelSchedule(scheduleId)) {
      await getSchedules();
      notifyListeners();
    } else {
      showToast("참여 취소에 실패했습니다. 다시 시도 해주세요.");
    }
  }
}
