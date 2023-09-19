import 'package:blabla/main.dart';
import 'package:blabla/screens/join/join_lang_view.dart';
import 'package:blabla/services/login.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Image.asset("assets/imgs/img_140_logo.png",
                height: 140, width: 140)),
        Text(
          "signUpWithSNS".tr(),
          style: BlaTxt.txt14R.copyWith(color: BlaColor.grey700),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loginBtn("apple", BlaColor.grey900, () async {
              try {
                final socialLoginSuccess =
                    await Login.apple.service.socialLogin(context);
                if (socialLoginSuccess) {
                  await Login.apple.service.login().then((alreadyJoined) {
                    // 이미 가입된 유저
                    if (alreadyJoined) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Main()),
                          (route) => false);
                    } else {
                      throw Exception();
                    }
                  });
                } else {
                  // 소셜 로그인 실패
                  throw Exception();
                }
              } catch (e) {
                switch (e) {
                  case "M002":
                    await Login.apple.service.socialLogin(context);
                    if (context.mounted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const JoinLangView()));
                    }
                    break;
                  default:
                    print(e);
                    showToast("failToLogin".tr());
                    break;
                }
              }
            }),
            loginBtn("google", BlaColor.grey200, () async {
              try {
                final socialLoginSuccess =
                    await Login.google.service.socialLogin(context);
                if (socialLoginSuccess) {
                  await Login.google.service.login().then((alreadyJoined) {
                    // 이미 가입된 유저
                    if (alreadyJoined) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Main()),
                          (route) => false);
                    } else {
                      throw Exception();
                    }
                  });
                } else {
                  // 소셜 로그인 실패
                  throw Exception();
                }
              } catch (e) {
                switch (e) {
                  case "M002":
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const JoinLangView()));
                    break;
                  default:
                    print(e);
                    showToast("failToLogin".tr());
                    break;
                }
              }
            }),
          ],
        ),
        GestureDetector(
          onTap: () async {
            await launchUrl(Uri.parse(env["TALK_URL"]!));
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 18),
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 40),
            child: Text(
              "inquiriesAboutLoggingIn".tr(),
              style: BlaTxt.txt14M.copyWith(
                  color: BlaColor.grey800,
                  decoration: TextDecoration.underline),
            ),
          ),
        )
      ],
    ));
  }

  Widget loginBtn(String icName, Color bgColor, onTap,
      {bool hasBorder = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(16),
        width: 56,
        height: 56,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(28),
            border: hasBorder
                ? Border.all(width: 1, color: const Color(0xFFD9D9D9))
                : null),
        child: Image.asset(
          "assets/imgs/img_24_brand_$icName.png",
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
