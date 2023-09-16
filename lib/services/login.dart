import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum Login {
  google('구글', GoogleLoginService()),
  apple('애플', AppleLoginService());

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
      await account.authentication.then((value) async {
        await storage.write(
            key: "platform", value: Login.google.name.toUpperCase());
        await storage.write(key: "socialToken", value: value.accessToken);
        print(
            "[socialLogin] socialToken: ${await storage.read(key: "socialToken")}");
        viewModel.initUser(Login.google.name);
      });
      if (await storage.read(key: "socialToken") != null) {
        return true;
      } else {
        return false;
      }
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
  Future<void> logout() async {
    const storage = FlutterSecureStorage();
    await GoogleSignIn().signOut();
    await storage.deleteAll();
  }
}

class AppleLoginService extends LoginService {
  const AppleLoginService();

  @override
  Login get platform => Login.google;

  @override
  Future<bool> socialLogin(BuildContext context) async {
    final viewModel = Provider.of<JoinViewModel>(context, listen: false);
    const storage = FlutterSecureStorage();
    try {
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
            clientId: "net.blablah.prod.blabla",
            redirectUri: Uri.parse("https://dev.blablah.shop/apple/callback")),
      );

      final email = credential.email;
      final name = credential.givenName;

      if (email != null && name != null) {
        viewModel.initUser(Login.apple.name);
      }

      await storage.write(
          key: "platform", value: Login.apple.name.toUpperCase());
      await storage.write(
          key: "socialToken", value: "Bearer ${credential.authorizationCode}");

      print(
          "[socialLogin] socialToken: ${await storage.read(key: "socialToken")}");

      if (await storage.read(key: "socialToken") != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> login() async {
    final api = API();
    return await api.login(Login.apple.name.toUpperCase());
  }

  @override
  Future<void> logout() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}

abstract class LoginService {
  const LoginService();

  Login get platform;

  Future<bool> socialLogin(BuildContext context);

  Future<bool> login();

  Future<void> logout();
}
