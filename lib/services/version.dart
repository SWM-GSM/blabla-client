import 'dart:convert';
import 'dart:io';
import 'package:blabla/utils/dotenv.dart';
import 'package:html/parser.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;

Future<bool> needForceUpdate() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final storeVersion = Platform.isAndroid
      ? await getPlayStoreVersion(packageInfo)
      : await getAppStoreVersion(packageInfo);
  print(
      "버전: ${packageInfo.version} / 패키지아이디: ${packageInfo.packageName} / 스토어버전: $storeVersion");

  switch (getVersionStatus(storeVersion, packageInfo.version)) {
    case VersionStatus.needUpdate:
      return true;
    default:
      return false;
  }
}

enum VersionStatus {
  needUpdate, // 스토어버전 > 앱버전 & 업데이트 필요
  noNeedUpdate, // 스토어버전 > 앱버전 & 업데이트 불필요(패치 업데이트)
  same, // 스토어버전 == 앱버전
  deploying // 스토어버전 < 앱버전
}

VersionStatus getVersionStatus(String storeVersion, String appVersion) {
  final storeVersionList =
      storeVersion.split(".").map((e) => int.parse(e)).toList();
  final appVersionList =
      appVersion.split(".").map((e) => int.parse(e)).toList();

  if (storeVersionList[0] > appVersionList[0]) {
    return VersionStatus.needUpdate;
  } else if (storeVersionList[0] == appVersionList[0]) {
    if (storeVersionList[1] > appVersionList[1]) {
      return VersionStatus.needUpdate;
    } else if (storeVersionList[1] == appVersionList[1]) {
      if (storeVersionList[2] > appVersionList[2]) {
        return VersionStatus.noNeedUpdate;
      } else if (storeVersionList[2] == appVersionList[2]) {
        return VersionStatus.same;
      } else {
        return VersionStatus.deploying;
      }
    } else {
      return VersionStatus.deploying;
    }
  } else {
    return VersionStatus.deploying;
  }
}

Future<String> getPlayStoreVersion(PackageInfo packageInfo) async {
  final res = await http.get(Uri.https("play.google.com", "/store/apps/details",
      {"id": packageInfo.packageName, "hl": "en"}));
  if (res.statusCode != 200) {
    throw Exception("play store http error");
  } else {
    try {
      final versionStrList =
          parse(res.body).getElementsByClassName('SfzRHd')[2].text.split(".");
      final version = [
        versionStrList[0][versionStrList[0].length - 1],
        versionStrList[1][0],
        versionStrList[2][0]
      ].join(".");
      return version.toString();
    } catch (e) {
      throw Exception("play store parsing error");
    }
  }
}

Future<String> getAppStoreVersion(PackageInfo packageInfo) async {
  final res = await http.get(Uri.https(
      "itunes.apple.com", "/lookup", {"bundleId": packageInfo.packageName}));
  if (res.statusCode != 200) {
    throw Exception("play store http error");
  } else {
    final version = jsonDecode(res.body)["results"][0]["version"];
    print(version);
    return version;
  }
}

Uri getStoreUrl() {
  if (Platform.isAndroid) {
    return Uri.parse(env['ANDROID_STORE_URL']);
  } else {
    return Uri.parse(env['IOS_STORE_URL']);
  }
}
