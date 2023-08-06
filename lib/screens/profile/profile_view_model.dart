import 'package:blabla/models/user.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';

class ProfileViewModel with ChangeNotifier {
  final api = API();
  
  ProfileViewModel() {
    init();
  }

  UserProfile? _user;

  UserProfile? get user => _user;

  void init() async {
    _user = await api.getMyProfile();
  }

}