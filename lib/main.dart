import 'package:blabla/providers/nav_provider.dart';
import 'package:blabla/screens/crew_space/crews_joined_view.dart';
import 'package:blabla/screens/crew_space/crews_view_model.dart';
import 'package:blabla/screens/home/crew_view_model.dart';
import 'package:blabla/screens/home/home_view.dart';
import 'package:blabla/screens/home/home_view_model.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/screens/my_space/mys_main_view.dart';
import 'package:blabla/screens/profile/profile_main_view.dart';
import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/screens/profile/profile_view_model.dart';
import 'package:blabla/screens/recruit/recruit_view_model.dart';
import 'package:blabla/screens/report/report_main_view.dart';
import 'package:blabla/screens/report/report_view_model.dart';
import 'package:blabla/screens/splash.dart';
import 'package:blabla/services/amplitude.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/theme.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);

  AnalyticsConfig().init();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => JoinViewModel()),
        ChangeNotifierProvider(create: (_) => RecruitViewModel()),
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CrewViewModel()),
        ChangeNotifierProvider(create: (_) => CrewsViewModel()),
        ChangeNotifierProvider(create: (_) => ReportViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileModifyViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
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
          home: const Splash(),
          ),
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);
    final navKeyList = List.generate(5, (idx) => GlobalKey<NavigatorState>()); 
    final botNavList = ["home", "team", "play", "notepad", "person"];
    final pageList = [
      HomeView(),
      CrewsJoinedView(),
      MysMainView(),
      ReportMainView(),
      ProfileMainView(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: navProvider.curIdx,
        children: navKeyList
            .map(
              (e) => Navigator(
                key: e,
                onGenerateRoute: (_) => MaterialPageRoute(
                    builder: (context) => pageList[navKeyList.indexOf(e)]),
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int idx) {
          navProvider.changeIdx(idx);
        },
        currentIndex: navProvider.curIdx,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: BlaColor.orange,
        unselectedItemColor: BlaColor.grey500,
        backgroundColor: BlaColor.white,
        iconSize: 28,
        elevation: 1,
        items: botNavList
            .map(
              (iconName) => BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      "assets/icons/ic_28_${iconName}_disabled.svg"),
                  activeIcon: SvgPicture.asset(
                      "assets/icons/ic_28_${iconName}_enabled.svg"),
                  label: "",
                  tooltip: ""),
            )
            .toList(),
      ),
    );
  }
}