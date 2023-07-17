import 'package:amplitude_flutter/amplitude.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/screens/onboarding.dart';
import 'package:blabla/screens/recruit/recruit_profile_view.dart';
import 'package:blabla/screens/recruit/recruit_view_model.dart';
import 'package:blabla/services/amplitude.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/theme.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load();

  AnalyticsConfig().init();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => JoinViewModel()),
        ChangeNotifierProvider(create: (_) => RecruitViewModel())
      ], child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledToast(
      locale: const Locale("ko"),
      textStyle: BlaTxt.txt16R.copyWith(color: BlaColor.white),
      backgroundColor: BlaColor.grey800.withOpacity(0.8),
      toastPositions: StyledToastPosition.bottom,
      borderRadius: BorderRadius.circular(20),
      duration: const Duration(milliseconds: 1500),
      toastAnimation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        title: 'BlaBla',
        theme: BlaTheme.blaTheme,
        home: RecruitProfileView()//OnBoarding(),
      ),
    );
  }
}
