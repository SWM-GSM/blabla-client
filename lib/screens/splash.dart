import 'package:blabla/main.dart';
import 'package:blabla/screens/onboarding.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';

enum SplashPage { onboarding, home }

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  SplashPage? page;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    final refreshToken = await storage.read(key: "refreshToken");
    final accessExpireDate = await storage.read(key: "accessTokenExpiresIn");
    final refreshExpireDate = await storage.read(key: "refreshTokenExpiresIn");
    final lang = await storage.read(key: "language");

    if (lang == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await storage.write(key: "language", value: context.locale.toString());
      });
    }

    if (accessToken == null ||
        refreshToken == null ||
        accessExpireDate == null ||
        refreshExpireDate == null) {
      print(
          "$accessToken, $refreshToken, $accessExpireDate, $refreshExpireDate");
      setState(() {
        page = SplashPage.onboarding;
      });
    } else {
      print(
          "accessToken: $accessToken / refresToken: $refreshToken /  accessExpireDate: $accessExpireDate / refreshExpireDate: $refreshExpireDate");
      if (DateTime.fromMillisecondsSinceEpoch(int.parse(
              refreshExpireDate)) // refreshToken이 만료시간까지 4시간보다 넉넉하게 남아있지 않을 경우 재로그인 필요
          .isBefore(DateTime.now().add(const Duration(hours: 4)))) {
        setState(() {
          page = SplashPage.onboarding;
        });
      } else {
        if (DateTime.fromMillisecondsSinceEpoch(// accessToken이 만료시 재발급
            int.parse(accessExpireDate)).isBefore(DateTime.now())) {
          if (!await API().reissue()) {
            print("시작 전 재발급 실패"); // 재발급 실패시
            setState(() {
              page = SplashPage.onboarding;
            });
          } else {
            setState(() {
              page = SplashPage.home;
            });
            if (!await Permission.notification.isGranted) {
              if ((await Permission.notification.request()) ==
                  PermissionStatus.granted) {
                await API().patchAllowNotification(true);
              } else {
                await API().patchAllowNotification(false);
              }
            }
          }
        } else {
          setState(() {
            page = SplashPage.home;
          });
        }
      }
    }
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    switch (page) {
      case SplashPage.onboarding:
        return const OnBoarding();
      case SplashPage.home:
        return const Main();
      default:
        return const Placeholder();
    }
  }
}
