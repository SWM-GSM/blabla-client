import 'package:blabla/models/content_feedback.dart';
import 'package:blabla/models/history.dart';
import 'package:blabla/models/report.dart';
import 'package:blabla/models/user.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum HistoryFilter {
  personal("play_circle", "개인"),
  crew("team", "크루");

  const HistoryFilter(this.icon, this.tag);
  final String icon;
  final String tag;
}

class ProfileViewModel with ChangeNotifier {
  final api = API();

  ProfileViewModel() {
    initProfile();
    initHistories();
  }

  /* 유저 정보 */
  UserProfile? _user;
  bool? _allowNotification;
  String? _lang;

  UserProfile? get user => _user;
  bool? get allowNotification => _allowNotification;
  String? get lang => _lang;

  /* 히스토리 */
  HistoryFilter _filter = HistoryFilter.personal;
  List<History> _histories = [];
  List<History> _historyList = [];

  HistoryFilter get filter => _filter;
  List<History> get histories => _histories;

  /* 리포트 */
  ReportDetail? _report;
  ReportDetail? get report => _report;
  ContentFeedback? _feedback;
  ContentFeedback? get feedback => _feedback;

  void initCrewReport() async {
    _report = null;
    notifyListeners();
  }

  void initPersonalReport() async {
    _feedback = null;
    notifyListeners();
  }

  void setCrewReport(int reportId) async {
    _report = await api.getDetailReport(reportId);
    notifyListeners();
  }

  void setPersonalReport(int reportId) async {
    _feedback = await api.getContentFeedback(reportId);
    notifyListeners();
  }

  void initProfile() async {
    const storage = FlutterSecureStorage();
    _user = await api.getMyProfile();
    final setting = await api.getSetting();
    _allowNotification = setting.pushNotification;
    _lang = (await storage.read(key: "language"))!;
    notifyListeners();
  }

  void changePushNotification() async {
    await api.patchAllowNotification(!_allowNotification!);
    _allowNotification = !_allowNotification!;
    notifyListeners();
  }

  void setLang(String lang) async {
    const storage = FlutterSecureStorage();
    _lang = lang;
    await storage.write(key: "language", value: _lang);
    notifyListeners();
  }

  Future<bool> withdrawal() async {
    const storage = FlutterSecureStorage();
    if (await api.withdrawal()) {
      await storage.deleteAll();
      return true;
    } else {
      return false;
    }
  }

  void initHistories() async {
    _historyList = [...await api.getHistory()];
    makeHistories();
    notifyListeners();
  }

  void setHistoryFilter(HistoryFilter input) {
    _filter = input;
    makeHistories();
    notifyListeners();
  }

  void makeHistories() {
    _histories = _historyList
        .map((history) => History(
            datetime: history.datetime,
            reports: history.reports
                .where((historyReport) => historyReport.type == _filter.name)
                .toList()))
        .toList();
    notifyListeners();
  }
}
