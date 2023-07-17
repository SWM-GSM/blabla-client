import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

enum Login {
  google('구글', GoogleLoginService());
  // apple('애플', false, AppleLoginService());

  const Login(this.kor, this.service);
  final String kor;
  final LoginService service;
}

class GoogleLoginService extends LoginService {
  const GoogleLoginService();

  @override
  Login get platform => Login.google;

  @override
  Future<bool> login(BuildContext context) async {
    final viewModel = Provider.of<JoinViewModel>(context, listen: false);
    final api = API();
    final account = await GoogleSignIn().signIn();
    if (account != null) {
      account.authentication.then((value) async {
        if (await api.getAccessToken(value.accessToken, platform.name.toUpperCase())) {
          viewModel.initUser(
          Login.google.name, account.email, account.displayName!);
        } else {
          return false;
        }
      });
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<void> withdraw() {
    throw UnimplementedError();
  }
}

abstract class LoginService {
  const LoginService();

  Login get platform;

  Future<bool> login(BuildContext context);

  Future<void> logout();

  Future<void> withdraw();
}
