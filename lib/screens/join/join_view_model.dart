import 'dart:math';

import 'package:blabla/models/country.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum JoinPage {
  profile,
  nickname,
  birthdate,
  gender,
  country,
  engLv,
  korLv,
  keyword,
}

enum DefaultProfile {
  dog("dog"),
  cat("cat"),
  fox("fox");

  const DefaultProfile(this.url);
  final String url;
}

enum Gender {
  female("여성", "👩"),
  male("남성", "👨"),
  etc("기타", "✨");

  final String kr;
  final String emoji;
  const Gender(this.kr, this.emoji);
}

class JoinViewModel with ChangeNotifier {
  final api = API();

  late String _socialLoginType;
  late String _nickname;
  late String _birthdate;
  String _gender = "";
  String _countryCode = "";
  late String _firstLang;
  late int _firstLangLevel;
  late String _secondLang;
  late int _secondLangLevel;
  late List<String> _keywords;
  late bool _pushNotification;
  late String _profileImg;

  late bool _isNickDupValid;
  List<Country> _countries = [];
  List<Country> _searchCountries = [];

  JoinViewModel() {
    changeProfile();
    initNickValid();
    initCountries();
  }

  String get profileImg => _profileImg;
  String get nickname => _nickname;
  bool get isNickDupValid => _isNickDupValid;
  List<Country> get searchCountries => _searchCountries;
  String get gender => _gender;
  String get countryCode => _countryCode;

  void initPage(JoinPage page) {
    switch (page) {
      case JoinPage.profile:
        changeProfile();
        break;
      case JoinPage.nickname:
        initNickValid();
        setNick("");
        break;
      case JoinPage.birthdate:
        setBirthdate(DateTime(2000, 1, 1));
      case JoinPage.gender:
        _gender = "";
      default:
        break;
    }
    notifyListeners();
  }

  void setProfile({String? img}) {}

  void changeProfile() {
    int idx = Random().nextInt(DefaultProfile.values.length);
    _profileImg = DefaultProfile.values[idx].url;
    notifyListeners();
  }

  void initNickValid() {
    _isNickDupValid = false;
    notifyListeners();
  }

  void nickDupValid(String input) async {
    _isNickDupValid = await api.getNicknameDup(input);
    notifyListeners();
  }

  void setNick(String input) {
    _nickname = input;
    notifyListeners();
  }

  void setBirthdate(DateTime input) {
    _birthdate = DateFormat("yyyy-MM-dd").format(input).toString();
    notifyListeners();
  }

  void setGender(String input) {
    _gender = input;
    notifyListeners();
  }

  void initCountries() async {
    _countries = await api.getCountries();
    getCountries("");
    notifyListeners();
  }

  void getCountries(String keyword) {
    if (keyword.isEmpty) {
      _searchCountries = _countries;
    } else {
      _searchCountries = _countries
          .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void setCountry(String code) {
    _countryCode = code;
    notifyListeners();
  }
}
