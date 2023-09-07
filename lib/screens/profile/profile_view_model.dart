import 'package:blabla/models/user.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';

class ProfileViewModel with ChangeNotifier {
  final api = API();
  
  ProfileViewModel() {
    init();
  }

  UserProfile? _user;
  late bool _openBirthdate;
  late bool _openGender;
  late bool _allowNotification;
  late bool _lang; // 수정;

  UserProfile? get user => _user;
  bool get openBirthdate => _openBirthdate;
  bool get openGender => _openGender;
  bool get allowNotification => _allowNotification;
  bool get lang => _lang; // 수정;

  void init() async {
    _user = await api.getMyProfile();
    final setting = await api.getSetting();
    _openBirthdate = setting.birthDateDisclosure;
    _openGender = setting.genderDisclosure;
    _allowNotification = setting.pushNotification;
    notifyListeners();
  }

  void changeOpenBirthdate() async {
    await api.patchOpenBirthdate(!_openBirthdate);
    _openBirthdate = !_openBirthdate;
    notifyListeners();
  }

  void changeOpenGender() async {
    await api.patchOpenGender(!_openGender);
    _openGender = !_openGender;
    notifyListeners();
  }

  void changePushNotification() async {
    await api.patchAllowNotification(!_allowNotification);
    _allowNotification = !_allowNotification;
    notifyListeners();
  }
}