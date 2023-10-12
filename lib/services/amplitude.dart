import 'package:amplitude_flutter/amplitude.dart';
import 'package:blabla/utils/dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AnalyticsConfig {
  final Amplitude analytics = Amplitude.getInstance(instanceName: "그랜드");
  final storage = const FlutterSecureStorage();

  Future<void> init() async {
    final key = kReleaseMode
        ? env["AMPLITUDE_PROD_API_KEY"]
        : env["AMPLITUDE_DEV_API_KEY"];

    analytics.init(key);
    analytics.logEvent("Start_App");
  }

  Future<void> btnClick(String btnType) async {
    analytics.logEvent("Click_$btnType");
  }
}
