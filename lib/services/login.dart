import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  Future<bool> socialLogin(BuildContext context) async {
    final viewModel = Provider.of<JoinViewModel>(context, listen: false);
    const storage = FlutterSecureStorage();
    final account = await GoogleSignIn().signIn();
    if (account != null) {
      account.authentication.then((value) async {
        await Future.wait([
          storage.write(
              key: "platform", value: Login.google.name.toUpperCase()),
          storage.write(key: "socialToken", value: value.accessToken),
        ]);
        viewModel.initUser(
            Login.google.name, account.email, account.displayName!);
      });
      return true;
    } else {
      return false;
    }
  }
  
  @override
  Future<bool> login() async {
    final api = API();
    return await api.login(Login.google.name.toUpperCase());
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

  Future<bool> socialLogin(BuildContext context);

  Future<bool> login();

  Future<void> logout();

  Future<void> withdraw();
}
