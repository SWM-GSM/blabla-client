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

class RecruitViewModel with ChangeNotifier {
  late String _profileImg;
  late String _name;
  late String _desc;

  String get profileImg => _profileImg;
  String get name => _name;
  String get desc => _desc;

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
  }

  void setName(String input) {
    _name = input;
  }

  void initDesc() {
    _desc = "";
  }

  void setDesc(String input) {
    _desc = input;
  }
}
