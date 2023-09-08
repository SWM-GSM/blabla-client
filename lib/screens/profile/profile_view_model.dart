import 'package:blabla/models/user.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileViewModel with ChangeNotifier {
  final api = API();
  
  ProfileViewModel() {
    init();
  }

  UserProfile? _user;
  late bool _openBirthdate;
  late bool _openGender;
  late bool _allowNotification;
  late String _lang;

  UserProfile? get user => _user;
  bool get openBirthdate => _openBirthdate;
  bool get openGender => _openGender;
  bool get allowNotification => _allowNotification;
  String get lang => _lang;

  void init() async {
    const storage = FlutterSecureStorage();
    _user = await api.getMyProfile();
    final setting = await api.getSetting();
    _openBirthdate = setting.birthDateDisclosure;
    _openGender = setting.genderDisclosure;
    _allowNotification = setting.pushNotification;  
    _lang = (await storage.read(key: "language"))!;
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

  void setLang(String lang) async {
    const storage = FlutterSecureStorage();
    _lang = lang;
    await storage.write(key: "language", value: _lang);
    notifyListeners();
  }
}