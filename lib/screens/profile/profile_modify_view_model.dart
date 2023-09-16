import 'dart:math';
import 'package:blabla/models/user.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';

class ProfileModifyViewModel with ChangeNotifier {
  final api = API();

  /* 프로필 수정 */
  late String _profileImage;
  late String _nickname;
  late String _language;

  late String _tempProfileImage;
  late String _tempNickname;
  late String _tempLanguage;

  String get tempProfileImage => _tempProfileImage;
  String get tempNickname => _tempNickname;
  String get tempLanguage => _tempLanguage;

  ProfileModifyViewModel() {}

  void init(
    String profileImage,
    String nickname,
    String language,
  ) {
    _profileImage = profileImage;
    _nickname = nickname;
    _language = language;

    _tempProfileImage = profileImage;
    _tempNickname = nickname;
    _tempLanguage = language;
  }

  void revert() {
    revertProfileImage();
    revertNickname();
    revertLanguage();
  }

  bool isProfileChanged() {
    return (_profileImage != _tempProfileImage ||
        _nickname != _tempNickname ||
        _language != tempLanguage);
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

  void setLanguage(String lang) {
    _tempLanguage = lang;
    notifyListeners();
  }

  void revertLanguage() {
    _tempLanguage = _language;
  }

  Future<bool> nickDupValid(String input) async {
    return await api.getNicknameDup(input);
  }

  Future<bool> saveProfile() async {
    // 수정
    if (await api.patchProfile(UserProfile(
      nickname: _tempNickname,
      profileImage: _tempProfileImage,
      language: _tempLanguage,
    ))) {
      return true;
    } else {
      return false;
    }
  }
}
