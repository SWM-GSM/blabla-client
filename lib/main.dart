import 'package:blabla/providers/nav_provider.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/screens/practice/practice_main_view.dart';
import 'package:blabla/screens/practice/practice_view_model.dart';
import 'package:blabla/screens/profile/profile_main_view.dart';
import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/screens/profile/profile_view_model.dart';
import 'package:blabla/screens/splash.dart';
import 'package:blabla/screens/square/square_main_view.dart';
import 'package:blabla/screens/square/square_view_model.dart';
import 'package:blabla/services/amplitude.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/theme.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/utils/dotenv.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:blabla/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsBinding widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  AnalyticsConfig().init();

  const storage = FlutterSecureStorage();
  final lang = await storage.read(key: "language");

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
    if (message != null) {
      if (message.notification != null) {
        print("[FCM] ${message.notification!.title}");
        print("[FCM] ${message.notification!.body}");
      }
    }
  });

  // await _initLocalNotification();

  FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
    if (message != null) {
      if (message.notification != null) {
        print("[FCM] ${message.notification!.title}");
        print("[FCM] ${message.notification!.body}");
      }
    }
  });

  runApp(
    EasyLocalization(
      supportedLocales:
          lang == null ? const [Locale('en'), Locale('ko')] : [Locale(lang)],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => JoinViewModel()),
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(create: (_) => ProfileModifyViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => PracticeViewModel()),
        ChangeNotifierProvider(create: (_) => SquareViewModel()),
      ], child: const MyApp()),
    ),
  );
}

// Future<void> _initLocalNotification() async {
//   FlutterLocalNotificationsPlugin _localNotification =
//       FlutterLocalNotificationsPlugin();
//   AndroidInitializationSettings initSettingsAndroid =
//       const AndroidInitializationSettings('@mipmap/ic_launcher');
//   DarwinInitializationSettings initSettingsIOS =
//       const DarwinInitializationSettings(
//     requestSoundPermission: false,
//     requestBadgePermission: false,
//     requestAlertPermission: false,
//   );
//   InitializationSettings initSettings = InitializationSettings(
//     android: initSettingsAndroid,
//     iOS: initSettingsIOS,
//   );
//   await _localNotification.initialize(
//     initSettings,
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("locale 테스트 ${context.locale}");
    return StyledToast(
      locale: context.locale,
      textStyle: BlaTxt.txt16R.copyWith(color: BlaColor.white),
      backgroundColor: BlaColor.grey800.withOpacity(0.8),
      toastPositions: StyledToastPosition.bottom,
      borderRadius: BorderRadius.circular(20),
      duration: const Duration(milliseconds: 1500),
      toastAnimation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      child: MaterialApp(
        locale: context.locale,
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
    final navKeyList = List.generate(3, (idx) => GlobalKey<NavigatorState>());
    final botNavList = ["team", "play", "person"];
    final pageList = [
      const SquareMainView(),
      const PracticeMainView(),
      const ProfileMainView(),
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
