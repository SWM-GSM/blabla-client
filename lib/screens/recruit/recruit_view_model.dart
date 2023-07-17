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

  String get profileImg => _profileImg;
  String get name => _name;

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
}
