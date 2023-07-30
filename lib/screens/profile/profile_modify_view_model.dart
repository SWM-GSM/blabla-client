import 'package:blabla/models/country.dart';
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

  String get gender => _gender;
  String get countryCode => _countryCode;

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

  List<Country> _countryList = [];
  List<Country> get countryList => _countryList;
  List<Country> _searchCountryList = [];
  List<Country> get searchCountryList => _searchCountryList;

  ProfileModifyViewModel() {
    init("닉네임", '2000.09.14', "female", "KR", 5, 2, ["SING", "DANCE"]);
    initCountryList();
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
    revertBirthdate();
    revertGender();
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

  Future<bool> nickDupValid(String input) async {
    return await api.getNicknameDup(input);
  }

  void setBirthdate(String input) {
    _tempBirthdate = input;
    notifyListeners();
  }

  void revertBirthdate() {
    _tempBirthdate = _birthdate;
    notifyListeners();
  }

  void setGender(String input) {
    _tempGender = input;
    notifyListeners();
  }

  void revertGender() {
    _tempGender = _gender;
    notifyListeners();
  }

  void setCountry(String code) {
    _tempCountryCode = code;
    notifyListeners();
  }

  void revertCountry() {
    _tempCountryCode = _countryCode;
    notifyListeners();
  }

  void initCountryList() async {
    _countryList = await api.getCountries();
    getSearchCountryList("");
    notifyListeners();
  }

  void getSearchCountryList(String keyword) {
    if (keyword.isEmpty) {
      _searchCountryList = _countryList;
    } else {
      _searchCountryList = _countryList
          .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
