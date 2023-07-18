import 'dart:math';

import 'package:blabla/models/emoji_name_tag.dart';
import 'package:blabla/models/level.dart';
import 'package:blabla/services/apis/api.dart';
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
  final api = API();

  late String _profileImg;
  late String _name;
  late String _desc;
  CrewCycle? _cycle;
  List<EmojiNameTag> _crewTags = [];
  bool? _autoApproval;
  int _crewNum = 0;
  int _engLv = 1;
  int _korLv = 1;

  String get profileImg => _profileImg;
  String get name => _name;
  String get desc => _desc;
  CrewCycle? get cycle => _cycle;
  List<EmojiNameTag> get crewTags => _crewTags;
  bool? get autoApproval => _autoApproval;
  int get crewNum => _crewNum;
  int get engLv => _engLv;
  int get korLv => _korLv;
  
  /* 생성 시 임시로 사용됨 */
  List<EmojiNameTag> _allCrewTags = [] ;
  List<EmojiNameTag> get allCrewTags => _allCrewTags;
  List<Level> _levels = [];
  List<Level> get levels => _levels;

  RecruitViewModel() {
    changeProfile();
    getCrewTags();
    getLevels();
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
      case RecruitPage.tags:
        initCrewTags();
      case RecruitPage.joinWay:
        initApproval();
      case RecruitPage.memberNum:
        initNum();
      case RecruitPage.langLv:
        initLv();
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

  void getCrewTags() async {
    _allCrewTags = await api.getCrewTags();
    notifyListeners();
  }

  void initCrewTags() async {
    _crewTags = [];
    notifyListeners();
  }

  void setCrewTag(EmojiNameTag tag) {
    if (_crewTags.contains(tag)) {
      _crewTags.remove(tag);
    } else {
      _crewTags.add(tag);
    }
    notifyListeners();
  }
  
  void initApproval() {
    _autoApproval = null;
    notifyListeners();
  }
  
  void setApproval(bool value) {
    _autoApproval = value;
    notifyListeners();
  }

  void initNum() {
    _crewNum = 0;
    notifyListeners();
  }

  void setNum(int num) {
    _crewNum = num;
    notifyListeners();
  }

  void initLv() {
    _engLv = 1;
    _korLv = 1;
    notifyListeners();
  }

  void setEngLv(int lv) {
    _engLv = lv;
    notifyListeners();
  }

  void setKorLv(int lv) {
    _korLv = lv;
    notifyListeners();
  }

  void getLevels() async {
    _levels = await api.getLevels();
    notifyListeners();
  }
}
