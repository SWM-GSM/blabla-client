import 'package:amplitude_flutter/amplitude.dart';
import 'package:blabla/utils/dotenv.dart';
import 'package:flutter/foundation.dart';

class AnalyticsConfig {
  final Amplitude analytics = Amplitude.getInstance(instanceName: "그랜드");

  Future<void> init() async {
    final key = kReleaseMode
        ? env["AMPLITUDE_PROD_API_KEY"]
        : env["AMPLITUDE_DEV_API_KEY"];
    analytics.init(key, userId: "test_mintato");

    analytics.logEvent("MyApp startup");
  }

  Future<void> btnClick(String btnType) async {
    analytics.logEvent("$btnType Btn Click");
  }
}
