import 'package:amplitude_flutter/amplitude.dart';
import 'package:blabla/screens/join/join_nickname_view.dart';
import 'package:blabla/screens/join/join_profile_view.dart';
import 'package:blabla/screens/join/join_profile2_view.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/screens/onboarding.dart';
import 'package:blabla/services/amplitude.dart';
import 'package:blabla/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  AnalyticsConfig().init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JoinViewModel())
      ],
      child: const MyApp()
    ),
  );
    
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlaBla',
      theme: BlaTheme.blaTheme,
      home: JoinNicknameView()//OnBoarding(),
    );
  }
}
