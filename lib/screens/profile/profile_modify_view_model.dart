import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';

class ProfileModifyViewModel with ChangeNotifier {
  final api = API();

  late String _nickname;
  late String _birthdate;
  late String _gender;
  late String _countryCode;
  late int _korLangLevel;
  late int _engLangLevel;
  late List<String> _keywords;

  late String _tempNickname;
  late String _tempBirthdate;
  late String _tempGender;
  late String _tempCountryCode;
  late int _tempKorLangLevel = 0;
  late int _tempEngLangLevel = 0;
  late List<String> _tempKeywords = [];

  String get tempNickname => _tempNickname;
  String get tempBirthdate => _tempBirthdate;
  String get tempGender => _tempGender;
  String get tempCountryCode => _tempCountryCode;
  int get tempKorLangLevel => _tempKorLangLevel;
  int get tempEngLangLevel => _tempEngLangLevel;
  List<String> get tempKeywords => _tempKeywords;

  ProfileModifyViewModel() {
    init("닉네임", '2000.09.14', "여성", "KR", 5, 2, ["SING", "DANCE"]);
  }

  void init(
      String nickname,
      String birthdate,
      String gender,
      String countryCode,
      int korLangLevel,
      int engLangLevel,
      List<String> keywords) {
    _nickname = nickname;
    _birthdate = birthdate;
    _gender = gender;
    _countryCode = countryCode;
    _korLangLevel = korLangLevel;
    _engLangLevel = engLangLevel;
    _keywords = keywords;

    _tempNickname = nickname;
    _tempBirthdate = birthdate;
    _tempGender = gender;
    _tempCountryCode = countryCode;
    _tempKorLangLevel = korLangLevel;
    _tempEngLangLevel = engLangLevel;
    _tempKeywords = keywords;
  }

  void revert() {
    revertNickname();
  }

  bool isProfileChanged() {
    return (_nickname != _tempNickname ||
        _birthdate != _tempBirthdate ||
        _gender != _tempGender ||
        _countryCode != _tempCountryCode ||
        _korLangLevel != _tempKorLangLevel ||
        _engLangLevel != _tempEngLangLevel ||
        _keywords != _tempKeywords);
  }

  void setNickname(String input) {
    _tempNickname = input;
    notifyListeners();
  }

  void revertNickname() {
    _tempNickname = _nickname;
    notifyListeners();
  }

  // void changeNickname() {
  //   _nickname = _tempNickname;
  //   notifyListeners();
  // }

  Future<bool> nickDupValid(String input) async {
    return await api.getNicknameDup(input);
  }


}
