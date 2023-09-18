import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';

enum JoinPage {
  lang,
}

enum Profile {
  bear,
  cat,
  chick,
  cow,
  dino,
  dog,
  dragon,
  fox,
  hamster,
  koala,
  lion,
  monkey,
  mouse,
  panda,
  penguin,
  pig,
  pigeon,
  rabbit,
  raccoon,
  tiger,
  whitebear,
  wolf,
}

class JoinViewModel with ChangeNotifier {
  final api = API();

  late String _socialLoginType;
  // late String _identifier;
  String? _lang;

  String? get lang => _lang;

  JoinViewModel() {}

  void initPage(JoinPage page) {
    switch (page) {
      case JoinPage.lang:
        _lang = null;
        break;
    }
    notifyListeners();
  }

  void initUser(String loginType) {
    _socialLoginType = loginType.toUpperCase();
  }

  void setLang(String lang) {
    _lang = lang;
    notifyListeners();
  }

  Future<bool> join() async {
    return await api.join(_socialLoginType, _lang!);
  }
}
