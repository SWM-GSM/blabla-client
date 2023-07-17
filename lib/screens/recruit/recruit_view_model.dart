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

  String get profileImg => _profileImg;

  RecruitViewModel() {
    changeProfile();
  }

  void initPage(RecruitPage page) {
    switch (page) {
      case RecruitPage.profile:
        changeProfile();
        break;
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
}
