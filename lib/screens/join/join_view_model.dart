import 'dart:math';

import 'package:blabla/models/country.dart';
import 'package:blabla/models/emoji_name_tag.dart';
import 'package:blabla/models/interest.dart';
import 'package:blabla/models/level.dart';
import 'package:blabla/models/user.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

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

enum Profile {
  bear,
  cat,
  chicken,
  cow,
  dog,
  dove,
  dragon,
  fox,
  hamster,
  koala,
  lion,
  monkey,
  mouse,
  panda,
  pig,
  polar,
  rabbit,
  raccoon,
  tiger,
  wolf,
}

enum Gender {
  female("여성", "👩"),
  male("남성", "👨"),
  etc("기타", "✨");

  final String kr;
  final String emoji;
  const Gender(this.kr, this.emoji);
  
  factory Gender.getByStr(String str) {
    return Gender.values.firstWhere((e) => e.toString().split(".")[1] == str);
  }
}

class JoinViewModel with ChangeNotifier {
  final api = API();

  late String _socialLoginType;
  late String _identifier;
  late String _nickname;
  late String _birthdate;
  String _gender = "";
  String _countryCode = "";
  int _korLangLevel = 0;
  int _engLangLevel = 0;
  List<String> _keywords = [];
  bool _pushNotification = true;
  late String _profileImg;

  List<Country> _countries = [];
  List<Country> _searchCountries = [];
  List<Level> _levels = [];
  List<Interest> _interests = [];

  JoinViewModel() {
    changeProfile();
    initCountries();
    getLevels();
    getInterests();
  }

  String get profileImg => _profileImg;
  String get nickname => _nickname;
  List<Country> get searchCountries => _searchCountries;
  String get gender => _gender;
  String get countryCode => _countryCode;
  List<Level> get levels => _levels;
  int get korLangLevel => _korLangLevel;
  int get engLangLevel => _engLangLevel;
  List<Interest> get interests => _interests;
  List<String> get keywords => _keywords;

  void initPage(JoinPage page) {
    switch (page) {
      case JoinPage.profile:
        changeProfile();
        break;
      case JoinPage.nickname:
        setNick("");
        break;
      case JoinPage.birthdate:
        setBirthdate(DateTime(2000, 1, 1));
      case JoinPage.gender:
        _gender = "";
      case JoinPage.country:
        setCountry("");
      case JoinPage.engLv:
        setEngLangLevel(0);
      case JoinPage.korLv:
        setKorLangLevel(0);
      case JoinPage.keyword:
        initKeywords();
      default:
        break;
    }
    notifyListeners();
  }

  void initUser(String loginType, String identifier, String nickname,
      {birthdate, gender}) {
    _identifier = identifier;
    _socialLoginType = loginType.toUpperCase();
    _nickname = nickname;
  }

  void setProfile(String img) {
    _profileImg = img;
    notifyListeners();
  }

  void changeProfile() {
    int idx = Random().nextInt(Profile.values.length);
    _profileImg = Profile.values[idx].name;
    notifyListeners();
  }

  Future<bool> nickDupValid(String input) async {
    return await api.getNicknameDup(input);
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

  void getLevels() async {
    _levels = await api.getLevels();
    notifyListeners();
  }

  void setKorLangLevel(int level) {
    _korLangLevel = level;
    notifyListeners();
  }

  void setEngLangLevel(int level) {
    _engLangLevel = level;
    notifyListeners();
  }

  void getInterests() async {
    _interests = await api.getInterests();
    notifyListeners();
  }

  void setKeywords(EmojiNameTag input) {
    if (_keywords.contains(input.tag)) {
      _keywords.remove(input.tag);
    } else {
      if (_keywords.length == 10) {
        showToast("키워드는 10개까지만 선택할 수 있습니다.");
      } else {
        _keywords.add(input.tag);
      }
    }
    notifyListeners();
  }

  void initKeywords() {
    _keywords = [];
    notifyListeners();
  }

  Future<bool> join() async {
    final user = User(
        socialLoginType: _socialLoginType,
        profileImage: _profileImg,
        nickname: _nickname,
        birthDate: _birthdate,
        gender: _gender,
        countryCode: _countryCode,
        korLevel: _korLangLevel,
        engLevel: _engLangLevel,
        keywords: keywords,
        pushNotification: _pushNotification);
    return await api.join(user);
  }
}
