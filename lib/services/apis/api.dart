import 'dart:convert';
import 'package:blabla/models/content.dart';
import 'package:blabla/models/country.dart';
import 'package:blabla/models/crew.dart';
import 'package:blabla/models/emoji_name_tag.dart';
import 'package:blabla/models/interest.dart';
import 'package:blabla/models/level.dart';
import 'package:blabla/models/report.dart';
import 'package:blabla/models/schedule.dart';
import 'package:blabla/models/user.dart';
import 'package:blabla/utils/dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

typedef JSON = Map<String, dynamic>;

get baseUrl => env["BASE_URL"];
get countryAPI => env["COUNTRY_API"];

get korBaseUrl => env["KOR_BASE_URL"];
get engBaseUrl => env["ENG_BASE_URL"];

get testUrl => env["TEST_API"];
get korTestUrl => env["KOR_TEST_API"];

enum HttpMethod {
  post,
  get,
  patch,
  delete,
}

class API {
  API();

  Future<http.Response> api(String url, HttpMethod method,
      {String? token, body, bool needCheck = false}) async {
    Map<String, String> headers;

    if (token != null) {
      headers = {
        "Authorization": token,
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
    } else {
      headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
    }

    const storage = FlutterSecureStorage();
    final accessTokenExpireIn = await storage.read(key: "accessTokenExpiresIn");

    try {
      if (needCheck == true) {
        if (DateTime.fromMillisecondsSinceEpoch(int.parse(accessTokenExpireIn!))
            .isBefore(DateTime.now())) {
          final res = await http.post(Uri.parse("$baseUrl/oauth/reissue"),
              headers: headers,
              body: jsonEncode({
                "accessToken": await storage.read(key: "accessToken"),
                "refreshToken": await storage.read(key: "refreshToken")
              }));
          if (res.statusCode == 200) {
            saveToken(res);
          }
        }
      }
      switch (method) {
        case HttpMethod.post:
          return await http.post(Uri.parse(url), headers: headers, body: body);
        case HttpMethod.get:
          return await http.get(Uri.parse(url), headers: headers);
        case HttpMethod.delete:
          return await http.delete(Uri.parse(url), headers: headers);
        case HttpMethod.patch:
          return await http.patch(Uri.parse(url), headers: headers, body: body);
      }
    } catch (e) {
      return http.Response(e.toString(), 404);
    }
  }

  Future<bool> getNicknameDup(String nickname) async {
    final res =
        await api("$baseUrl/members/nicknames/$nickname", HttpMethod.get);
    if (res.statusCode == 200) {
      if (!jsonDecode(res.body)["data"]["isDuplicated"]) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception("http error :(");
    }
  }

  Future<List<Country>> getCountries() async {
    final res = await api(countryAPI, HttpMethod.get);
    if (res.statusCode == 200) {
      return (jsonDecode(res.body)["data"] as List)
          .map((e) => Country.fromJson(e))
          .toList();
    } else {
      throw Exception("http error :(");
    }
  }

  Future<List<Level>> getLevels() async {
    // 수정 - 설정 언어 별
    final res = await api("$korBaseUrl/common/levels", HttpMethod.get);
    if (res.statusCode == 200) {
      return (jsonDecode(utf8.decode(res.bodyBytes))["data"]["levels"] as List)
          .map((e) => Level.fromJson(e))
          .toList();
    } else {
      throw Exception("http error :()");
    }
  }

  Future<List<Interest>> getInterests() async {
    // 수정 - 설정 언어 별
    final res = await api("$korBaseUrl/common/keywords", HttpMethod.get);
    if (res.statusCode == 200) {
      return (jsonDecode(utf8.decode(res.bodyBytes))["data"]["keywords"]
              as List)
          .map((e) => Interest.fromJson(e))
          .toList();
    } else {
      throw Exception("http error :(");
    }
  }

  Future<bool> reissue() async {
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/oauth/reissue", HttpMethod.post,
        body: jsonEncode({
          "accessToken": await storage.read(key: "accessToken"),
          "refreshToken": await storage.read(key: "refreshToken")
        }));
    if (res.statusCode == 200) {
      saveToken(res);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login(String loginType) async {
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/oauth/login/$loginType", HttpMethod.post,
        token: await storage.read(key: "socialToken"));
    if (res.statusCode == 200 &&
        await storage.read(key: "accessToken") != null) {
      saveToken(res);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> join(User user) async {
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/oauth/sign-up", HttpMethod.post,
        token: await storage.read(key: "socialToken"), body: jsonEncode(user));
    if (res.statusCode == 200) {
      saveToken(res);
      return true;
    } else {
      return false;
    }
  }

  Future<List<EmojiNameTag>> getCrewTags() async {
    // 수정 - 설정 언어 별
    final res = await api("$korBaseUrl/common/crew-tags", HttpMethod.get);
    if (res.statusCode == 200) {
      return (jsonDecode(utf8.decode(res.bodyBytes))["data"]["tags"] as List)
          .map((e) => EmojiNameTag.fromJson(e))
          .toList();
    } else {
      throw Exception("http error :(");
    }
  }

  Future<List<EmojiNameTag>> getMemProps() async {
    // 수정 - 설정 언어 별
    final res = await api("$korBaseUrl/common/prefer-members", HttpMethod.get);
    if (res.statusCode == 200) {
      return (jsonDecode(utf8.decode(res.bodyBytes))["data"]["preferMembers"]
              as List)
          .map((e) => EmojiNameTag.fromJson(e))
          .toList();
    } else {
      throw Exception("http error :(");
    }
  }

  /* 홈 API */
  Future<UserProfile> getMyProfile() async {
    const storage = FlutterSecureStorage();
    // final res = await api("$korTestUrl/profile", HttpMethod.get);
    final res = await api("$korBaseUrl/profile", HttpMethod.get,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true);
    // print(res.body);
    if (res.statusCode == 200) {
      return UserProfile.fromJson(
          jsonDecode(utf8.decode(res.bodyBytes))["data"]);
    } else {
      throw Exception("http error :(");
    }
  }

  Future<List<CrewSimple>> getMyCrews() async {
    // 수정 - 테스트 API
    final res = await api("$testUrl/crews/me", HttpMethod.get);
    if (res.statusCode == 200) {
      return (jsonDecode(utf8.decode(res.bodyBytes))["data"]["crews"] as List)
          .map((e) => CrewSimple.fromJson(e))
          .toList();
    } else {
      throw Exception("http error :(");
    }
  }

  Future<List<CrewSimple>> getNowCrews() async {
    // 수정 - 테스트 API
    final res = await api("$testUrl/crews/me/can-join", HttpMethod.get);
    if (res.statusCode == 200) {
      return (jsonDecode(utf8.decode(res.bodyBytes))["data"]["crews"] as List)
          .map((e) => CrewSimple.fromJson(e))
          .toList();
    } else {
      throw Exception("http error :(");
    }
  }

  Future<Content> getTodayContent() async {
    // 수정 - 테스트 API
    final res = await api("$korTestUrl/contents/today", HttpMethod.get);
    if (res.statusCode == 200) {
      return Content.fromJson(jsonDecode(utf8.decode(res.bodyBytes))["data"]);
    } else {
      throw Exception("http error :(");
    }
  }

  /* 홈 - 크루 API */
  Future<List<Crew>> getCrews() async {
    // 수정 - 테스트 API & page, sort
    final res = await api("$korTestUrl/crews", HttpMethod.get);
    if (res.statusCode == 200) {
      return (jsonDecode(utf8.decode(res.bodyBytes))["data"]["content"] as List)
          .map((e) => Crew.fromJson(e))
          .toList();
    } else {
      throw Exception("http error :(");
    }
  }

  Future<CrewDetail> getCrewDetail(int crewId) async {
    // 수정 - 테스트 API & crewId, 한글
    final res = await api("$korTestUrl/crews/1", HttpMethod.get);
    if (res.statusCode == 200) {
      return (CrewDetail.fromJson(
          jsonDecode(utf8.decode(res.bodyBytes))["data"]));
    } else {
      throw Exception("http error :(");
    }
  }

  Future<int> createCrew(CrewToJson crew) async {
    // 수정 - 테스트 API
    final res =
        await api("$testUrl/crews", HttpMethod.post, body: jsonEncode(crew));
    if (res.statusCode == 200) {
      return jsonDecode(utf8.decode(res.bodyBytes))["data"]["crewId"];
    } else {
      throw Exception("http error :(");
    }
  }

  /* 크루 스페이스 */
  Future<List<Report>> getReports(int crewId) async {
    final res = await api("$testUrl/crews/$crewId/reports", HttpMethod.get);
    if (res.statusCode == 200) {
      return (jsonDecode(utf8.decode(res.bodyBytes))["data"]["reports"] as List)
          .map((e) => Report.fromJson(e))
          .toList();
    } else {
      throw Exception("http error :(");
    }
  }

  Future<ScheduleSimple> getUpcomingSchedule(int crewId) async {
    final res =
        await api("$testUrl/crews/$crewId/schedules/upcoming", HttpMethod.get);
    if (res.statusCode == 200) {
      return ScheduleSimple.fromJson(
          jsonDecode(utf8.decode(res.bodyBytes))["data"]);
    } else {
      throw Exception("http error :(");
    }
  }

  Future<List<Schedule>> getSchedules(int crewId) async {
    final res = await api("$testUrl/crews/$crewId/schedules", HttpMethod.get);
    if (res.statusCode == 200) {
      return (jsonDecode(utf8.decode(res.bodyBytes))["data"] as List)
          .map((e) => Schedule.fromJson(e))
          .toList();
    } else {
      throw Exception("http error :(");
    }
  }

  Future<bool> createSchedule(
      int crewId, String title, String meetingTime) async {
    const storage = FlutterSecureStorage();
    final res = await api("$testUrl/crews/$crewId/schedules", HttpMethod.post,
        token: await storage.read(key: "socialToken"),
        body: jsonEncode({"title": title, "meetingTime": meetingTime}));
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception("http error :(");
    }
  }

  /* 크루 리포트 */
  Future<ReportDetail> getDetailReport(int crewId, int reportId) async {
    final res =
        await api("$testUrl/crews/$crewId/reports/$reportId", HttpMethod.get);
    if (res.statusCode == 200) {
      return ReportDetail.fromJson(
          jsonDecode(utf8.decode(res.bodyBytes))["data"]);
    } else {
      throw Exception("http error :(");
    }
  }

  /* 마이페이지 */
  Future<bool> patchProfileDesc(String description) async {
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/profile/description", HttpMethod.patch,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        body: jsonEncode({"description": description}));
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> patchProfileInterest(List<String> interests) async {
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/profile/keywords", HttpMethod.patch,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        body: jsonEncode({"keywords": interests}));
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

Future<void> saveToken(res) async {
  const storage = FlutterSecureStorage();
  await Future.wait([
    storage.write(
        key: "accessToken", value: jsonDecode(res.body)["data"]["accessToken"]),
    storage.write(
        key: "refreshToken",
        value: jsonDecode(res.body)["data"]["refreshToken"]),
    storage.write(
        key: "accessTokenExpiresIn",
        value: jsonDecode(res.body)["data"]["accessTokenExpiresIn"].toString()),
    storage.write(
        key: "refreshTokenExpiresIn",
        value:
            jsonDecode(res.body)["data"]["refreshTokenExpiresIn"].toString()),
  ]);
}
