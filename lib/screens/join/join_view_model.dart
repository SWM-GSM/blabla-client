import 'dart:math';

import 'package:blabla/services/apis/api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum DefaultProfile {
  dog("dog"),
  cat("cat"),
  fox("fox");

  const DefaultProfile(this.url);
  final String url;
}

class JoinViewModel with ChangeNotifier {
  late String _socialLoginType;
  late String _nickname;
  late String _birthdate;
  late String _gender;
  late String _countryCode;
  late String _firstLang;
  late int _firstLangLevel;
  late String _secondLang;
  late int _secondLangLevel;
  late List<String> _keywords;
  late bool _pushNotification;
  late String _profileImg;

  late bool _isNickDupValid;

  JoinViewModel() {
    changeProfile();
    initNickValid();
  }

  String get profileImg => _profileImg;

  bool get isNickDupValid => _isNickDupValid;

  void setProfile({String? img}) {
    
  }
  
  void changeProfile() {
    int idx = Random().nextInt(DefaultProfile.values.length);
    _profileImg = DefaultProfile.values[idx].url;
    notifyListeners();
  }

  void initNickValid() {
    _isNickDupValid = false;
    notifyListeners();
  }

  void nickDupValid (String input) async {
    _isNickDupValid = await const API().getNicknameDup(input);
    notifyListeners();
  }

  void setNick(String input) {
    _nickname = input;
  }

  void setBirthdate(DateTime input) {
    _birthdate = DateFormat("yyyy-MM-dd").format(input).toString();
  }
}