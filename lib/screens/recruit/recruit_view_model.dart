import 'dart:math';

import 'package:flutter/material.dart';

enum RecruitPage {
  profile,
  name,
  desc,
  cycle,
  tags,
  joinWay,
  memberNum,
  langLv,
  memberProp,
  detail,
  complete
}

enum CrewProfile {
  cooking,
  exercise,
  book,
}

enum CrewCycle {
  free("자율", "FREE"),
  onceAMonth("월 1회", "ONCEAMONTH"),
  twiceAMonth("월 2회", "TWICEAMONTH"),
  onceAWeek("주 1회", "ONCEAWEEK"),
  twiceAWeek("주 2~3회", "TWICEAWEEK"),
  fourTimesAWeek("주 4~5회", "FOURTIMESAWEEK"),
  everyday("매일", "EVERYDAY");
  
  const CrewCycle(this.name, this.tag);
  final String name;
  final String tag;
}

class RecruitViewModel with ChangeNotifier {
  late String _profileImg;
  late String _name;
  late String _desc;
  CrewCycle? _cycle;

  String get profileImg => _profileImg;
  String get name => _name;
  String get desc => _desc;
  CrewCycle? get cycle => _cycle;

  RecruitViewModel() {
    changeProfile();
  }

  void initPage(RecruitPage page) {
    switch (page) {
      case RecruitPage.profile:
        changeProfile();
        break;
      case RecruitPage.name:
        initName();
      case RecruitPage.desc:
        initDesc();
      case RecruitPage.cycle:
        initCycle();
      default:
        break;
    }
    notifyListeners();
  }

  void changeProfile() {
    int idx = Random().nextInt(CrewProfile.values.length);
    _profileImg = CrewProfile.values[idx].name;
    notifyListeners();
  }

  void initName() {
    _name = "";
    notifyListeners();
  }

  void setName(String input) {
    _name = input;
    notifyListeners();
  }

  void initDesc() {
    _desc = "";
    notifyListeners();
  }

  void setDesc(String input) {
    _desc = input;
    notifyListeners();
  }

  void initCycle() {
    _cycle = null;
    notifyListeners();
  }

  void setCycle(int idx) {
    _cycle = CrewCycle.values[idx];
    notifyListeners();
  }
}
