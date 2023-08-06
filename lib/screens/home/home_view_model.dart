import 'package:blabla/models/content.dart';
import 'package:blabla/models/crew.dart';
import 'package:blabla/models/user.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  final api = API();

  bool _isLoading = true;
  UserSimple? _user;
  List<CrewSimple> _myCrewList = [];
  List<CrewSimple> _nowCrewList = [];
  Content? _todayContent;

  bool get isLoading => _isLoading;
  UserSimple? get user => _user;
  List<CrewSimple> get myCrewList => _myCrewList;
  List<CrewSimple> get nowCrewList => _nowCrewList;
  Content? get todayContent => _todayContent;

  HomeViewModel() {
    init();
  }

  void init() async {
    await Future.wait([
      getMyPrfile(),
      getMyCrews(),
      getNowCrews(),
      getTodayContent(),
    ]);
    _isLoading = false;
  }

  Future<void> getMyPrfile() async {
    _user = await api.getMyProfile();
    notifyListeners();
  }

  Future<void> getMyCrews() async {
    _myCrewList = await api.getMyCrews();
    notifyListeners();
  }

  Future<void> getNowCrews() async {
    _nowCrewList = await api.getNowCrews();
    notifyListeners();
  }

  Future<void> getTodayContent() async {
    _todayContent = await api.getTodayContent();
    notifyListeners();
  }
}
