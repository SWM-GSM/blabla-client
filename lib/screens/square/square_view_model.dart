import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:blabla/models/agora.dart';
import 'package:blabla/models/member.dart';
import 'package:blabla/models/schedule.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:blabla/utils/dotenv.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

enum Accuse { abuse, porn, conflict, spam, etc }

class SquareViewModel with ChangeNotifier {
  final api = API();

  /* 보이스룸 */
  int? _myId;
  Agora? _agora; // 초기화 필요
  DateTime? _updateTime;
  late RtcEngine _engine;
  List<MemberSimple>? _voiceroomList = [];
  int? _voiceFileId; // 초기화 필요

  int? get myId => _myId;
  Agora? get agora => _agora;
  RtcEngine get engine => _engine;
  DateTime? get updateTime => _updateTime;
  List<MemberSimple>? get voiceroomList => _voiceroomList;

  /* 신고 */
  List<MemberSimple>? _withMemberList; // 초기화 필요
  List<MemberSimple>? get withMemberList => _withMemberList;

  SquareViewModel() {
    initInfo();
    initEngine();
    getUpcomingSchedule();
    getSchedules();
  }

  void initInfo() async {
    getMyId();
    await getVoiceRoomList();
  }

  void initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: env["AGORA_APP_ID"]
    ));
    await _engine.enableAudio();
    await _engine
        .setChannelProfile(ChannelProfileType.channelProfileCommunication);
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    _engine.registerEventHandler(RtcEngineEventHandler(
      onRejoinChannelSuccess: (connection, uid) {
        print("[H-TEST] rejoinChannelSuccess: $connection, $uid");
      },
      onJoinChannelSuccess: (connection, uid) {
        print("[H-TEST] joinChannelSuccess: $connection, $uid");
        getVoiceRoomList();
      },
      onUserJoined: (connection, uid, elapsed) {
        print("[[H-TEST] userJoined: $uid, $elapsed");
        getVoiceRoomList();
      },
      onLeaveChannel: (connection, stats) {
        print("[H-TEST] leaveChannel: ${stats.userCount}");
        getVoiceRoomList();
      },
      onUserOffline: (connection, uid, reason) {
        print("[H-TEST] userOffline: $uid, $reason");
        getVoiceRoomList();
      },
    ));
  }

  void initAgora() async {
    _agora = null;
    notifyListeners();
  }

  Future<void> joinChannel() async {
    await _engine.leaveChannel();
    await api.getVoiceRoomList();
    if (_voiceroomList!.isEmpty) {
      await getAgora(false);
      print("새로 생성 / token: ${_agora!.token}");
    } else {
      await getAgora(true);
      print("이미 생성됨 / token: ${_agora!.token}");
    }
    await _engine.joinChannel(
        token: _agora!.token,
        channelId: "blablah",
        uid: _myId!,
        options: const ChannelMediaOptions());
  }

  Future<void> getAgora(bool isActivated) async {
    _agora = await api.getAgora(isActivated);
    notifyListeners();
  }

  void leaveChannel() async {
    await _engine.leaveChannel();
  }

  void getMyId() async {
    _myId = await api.getMyId();
    notifyListeners();
  }

  Future<void> getVoiceRoomList() async {
    _updateTime = DateTime.now();
    _voiceroomList = await api.getVoiceRoomList();
    notifyListeners();
  }

  Future<int> uploadVoiceFile(String path) async {
    _voiceFileId = await api.uploadVoiceFile(_agora!.reportId, path);
    print(_voiceFileId);
    return _voiceFileId!;
  }

  Future<bool> requestCreateReport() async {
    return await api.requestCreateReport(_agora!.reportId);
  }

  void sendSquareFeedback(String feedback) async {
    await api.sendSquareFeedback(_voiceFileId!, feedback);
  }

  void makeWithMemberList() async {
    final prevMemberList = await api.getPrevMember(_agora!.reportId);
    _withMemberList = [..._voiceroomList!] +
        [...prevMemberList.where((e) => !voiceroomList!.contains(e))];
    notifyListeners();
  }

  Future<bool> accuseMember(int reportee, Accuse accuse,
      {String description = ""}) async {
    return await api.accuseMember(reportee, accuse, description);
  }

  void initVoiceCall() async {
    _agora = null;
    _withMemberList = null;
    _voiceFileId = null;
    notifyListeners();
  }

  /* 일정 */
  ScheduleSimple? _upcomingSchedule;
  List<Schedule>? _schedules;
  Map<DateTime, List<Schedule>> _schedulesForCalendar = {};
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  ScheduleSimple? get upcomingSchedule => _upcomingSchedule;
  List<Schedule>? get schedules => _schedules;
  Map<DateTime, List<Schedule>> get schedulesForCalendar =>
      _schedulesForCalendar;
  DateTime get selectedDate => _selectedDate;
  DateTime get focusedDate => _focusedDate;
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

  void setFocusedDate(DateTime input) {
    _focusedDate = input;
    notifyListeners();
  }

  void createSchedule(String title, String meetingTime) async {
    if (await api.createSchedule(title, meetingTime)) {
      await getSchedules();
      await getUpcomingSchedule();
    }
    notifyListeners();
  }

  void joinSchedule(int scheduleId) async {
    if (await api.joinSchedule(scheduleId)) {
      await getSchedules();
      await getUpcomingSchedule();
      notifyListeners();
    } else {
      showToast("failToJoinSchedule".tr());
    }
  }

  void cancelSchedule(int scheduleId) async {
    if (await api.cancelSchedule(scheduleId)) {
      await getSchedules();
      await getUpcomingSchedule();
      notifyListeners();
    } else {
      showToast("failToUnsubscribe".tr());
    }
  }
}
