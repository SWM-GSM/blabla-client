import 'dart:math';
import 'package:blabla/models/country.dart';
import 'package:blabla/models/emoji_name_tag.dart';
import 'package:blabla/models/interest.dart';
import 'package:blabla/models/level.dart';
import 'package:blabla/models/user.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ProfileModifyViewModel with ChangeNotifier {
  final api = API();

  /* 프로필 수정 */
  late String _profileImage;
  late String _nickname;
  late String _birthdate;
  late String _gender;
  late String _countryCode;
  late int _korLangLevel;
  late int _engLangLevel;

  String get gender => _gender;
  String get countryCode => _countryCode;
  int get korLanglevel => _korLangLevel;
  int get engLanglevel => _engLangLevel;

  late String _tempProfileImage;
  late String _tempNickname;
  late String _tempBirthdate;
  late String _tempGender;
  late String _tempCountryCode;
  late int _tempKorLangLevel = 0;
  late int _tempEngLangLevel = 0;

  String get tempProfileImage => _tempProfileImage;
  String get tempNickname => _tempNickname;
  String get tempBirthdate => _tempBirthdate;
  String get tempGender => _tempGender;
  String get tempCountryCode => _tempCountryCode;
  int get tempKorLangLevel => _tempKorLangLevel;
  int get tempEngLangLevel => _tempEngLangLevel;

  /* 자기소개 수정 */
  late String _description;
  late String _tempDescription;
  String get description => _description;
  String get tempDescription => _tempDescription;

  /* 관심사 수정 */
  late List<EmojiNameTag> _interests;
  late List<EmojiNameTag> _tempInterests;
  List<EmojiNameTag> get interests => _interests;
  List<EmojiNameTag> get tempInterests => _tempInterests;

  /* static 데이터 받아오기 */
  List<Country> _countryList = [];
  List<Country> _searchCountryList = [];
  List<Level> _levelList = [];
  List<Interest> _interestList = [];

  List<Country> get countryList => _countryList;
  List<Country> get searchCountryList => _searchCountryList;
  List<Level> get levelList => _levelList;
  List<Interest> get interestList => _interestList;

  ProfileModifyViewModel() {
    initCountryList();
    initLevelList();
    initDescription("");
    initInterestList([]);
  }

  void init(
    String profileImage,
    String nickname,
    String birthdate,
    String gender,
    String countryCode,
    int korLangLevel,
    int engLangLevel,
  ) {
    _profileImage = profileImage;
    _nickname = nickname;
    _birthdate = birthdate;
    _gender = gender;
    _countryCode = countryCode;
    _korLangLevel = korLangLevel;
    _engLangLevel = engLangLevel;

    _tempProfileImage = profileImage;
    _tempNickname = nickname;
    _tempBirthdate = birthdate;
    _tempGender = gender;
    _tempCountryCode = countryCode;
    _tempKorLangLevel = korLangLevel;
    _tempEngLangLevel = engLangLevel;
  }

  void initDescription(String description) {
    _description = description;
    _tempDescription = description;
  }

  void initInterestList(List<EmojiNameTag> interests) async {
    _interests = [...interests];
    _tempInterests = [...interests];
    _interestList = await api.getInterests();
    notifyListeners();
  }

  void revert() {
    revertProfileImage();
    revertNickname();
    revertBirthdate();
    revertGender();
    revertCountry();
    revertKorLangLevel();
    revertEngLangLevel();
  }

  bool isProfileChanged() {
    return (_profileImage != _tempProfileImage ||
        _nickname != _tempNickname ||
        _birthdate != _tempBirthdate ||
        _gender != _tempGender ||
        _countryCode != _tempCountryCode ||
        _korLangLevel != _tempKorLangLevel ||
        _engLangLevel != _tempEngLangLevel);
  }

  void setProfileImage() {
    int idx = Random().nextInt(Profile.values.length);
    _tempProfileImage = Profile.values[idx].name;
    notifyListeners();
  }

  void revertProfileImage() {
    _tempProfileImage = _profileImage;
    notifyListeners();
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

  void setKorLangLevel(int level) {
    _tempKorLangLevel = level;
    notifyListeners();
  }

  void revertKorLangLevel() {
    _tempKorLangLevel = _korLangLevel;
    notifyListeners();
  }

  void setEngLangLevel(int level) {
    _tempEngLangLevel = level;
    notifyListeners();
  }

  void revertEngLangLevel() {
    _tempEngLangLevel = _engLangLevel;
    notifyListeners();
  }

  void initLevelList() async {
    _levelList = await api.getLevels();
    notifyListeners();
  }

  Future<bool> saveProfile() async {
    if (await api.patchProfile(UserProfile(
        nickname: _tempNickname,
        profileImage: _tempProfileImage,
        birthDate: DateTime.parse(_tempBirthdate.replaceAll(".", "-")),
        gender: _tempGender,
        countryCode: _tempCountryCode,
        korLevel: _tempKorLangLevel,
        engLevel: _tempEngLangLevel,
        description: _tempDescription, // 더미
        signedUpAfter: 0, // 더미
        keywords: [] // 더미
        ))) {
      return true;
    } else {
      return false;
    }
  }

  void setDescription(String input) {
    _tempDescription = input;
    notifyListeners();
  }

  void revertDescription() {
    _tempDescription = _description;
    notifyListeners();
  }

  Future<bool> saveDescription() async {
    if (await api.patchProfileDesc(_tempDescription)) {
      initDescription(_tempDescription);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void setInterest(EmojiNameTag interest) {
    if (_tempInterests.contains(interest)) {
      _tempInterests.remove(interest);
    } else {
      if (_tempInterests.length == 10) {
        showToast("키워드는 10개까지만 선택할 수 있습니다.");
      } else {
        _tempInterests.add(interest);
      }
    }
    notifyListeners();
  }

  void revertInterests() {
    _tempInterests = _interests;
    notifyListeners();
  }

  Future<bool> saveInterests() async {
    if (await api
        .patchProfileInterest(_tempInterests.map((e) => e.tag).toList())) {
      initInterestList(_tempInterests);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
