import 'dart:convert';
import 'package:blabla/models/agora.dart';
import 'package:blabla/models/content.dart';
import 'package:blabla/models/content_category.dart';
import 'package:blabla/models/content_feedback.dart';
import 'package:blabla/models/country.dart';
import 'package:blabla/models/crew.dart';
import 'package:blabla/models/emoji_name_tag.dart';
import 'package:blabla/models/history.dart';
import 'package:blabla/models/interest.dart';
import 'package:blabla/models/level.dart';
import 'package:blabla/models/report.dart';
import 'package:blabla/models/schedule.dart';
import 'package:blabla/models/user.dart';
import 'package:blabla/screens/my_space/mys_view_model.dart';
import 'package:blabla/utils/dotenv.dart';
import 'package:dio/dio.dart';
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

    try {
      if (needCheck &&
          DateTime.fromMillisecondsSinceEpoch(
                  int.parse((await storage.read(key: "accessTokenExpiresIn"))!))
              .isBefore(DateTime.now())) {
        print("accessToken: ${await storage.read(key: "accessToken")}");
        print("refreshToken: ${await storage.read(key: "refreshToken")}");
        final res = await http.post(Uri.parse("$baseUrl/oauth/reissue"),
            headers: headers,
            body: jsonEncode({
              "accessToken": await storage.read(key: "accessToken"),
              "refreshToken": await storage.read(key: "refreshToken")
            }));
        if (res.statusCode == 200) {
          await saveToken(res);
          headers = {
            "Authorization": "Bearer ${await storage.read(key: "accessToken")}",
            "Content-Type": "application/json",
            "Accept": "application/json",
          };
        } else {
          print(jsonDecode(utf8.decode(res.bodyBytes)));
          print("재발급 실패");
        }
      }
      await Future.delayed(const Duration(seconds: 1));

      switch (method) {
        case HttpMethod.post:
          return await http.post(Uri.parse(url), headers: headers, body: body);
        case HttpMethod.get:
          return await http.get(Uri.parse(url), headers: headers);
        case HttpMethod.delete:
          return await http.delete(Uri.parse(url),
              headers: headers, body: body);
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
      print(res.body);
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
      print(res.body);
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
      await saveToken(res);
      return true;
    } else {
      print(res.body);
      return false;
    }
  }

  Future<bool> login(String loginType) async {
    const storage = FlutterSecureStorage();
    print("[Login] socialToken: ${await storage.read(key: "socialToken")}");
    final res = await api("$baseUrl/oauth/login/$loginType", HttpMethod.post,
        token: await storage.read(key: "socialToken"));
    if (res.statusCode == 200) {
      print("[Login] res.body: ${jsonDecode(utf8.decode(res.bodyBytes))}");
      if (jsonDecode(res.body)["success"]) { // 이미 가입된 유저
        await saveToken(res);
        return true;
      } else { // 알 수 없는 에러
        throw Error();
      }
    } else {
      print(
          "[Login - res.statusCode not 200] res.body: ${jsonDecode(utf8.decode(res.bodyBytes))}");
      // return false; // 가입되지 않은 유저
      throw jsonDecode(res.body)["code"];
    }
  }

  Future<bool> join(User user) async {
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/oauth/sign-up", HttpMethod.post,
        token: await storage.read(key: "socialToken"), body: jsonEncode(user));
    if (res.statusCode == 200) {
      await saveToken(res);
      return true;
    } else {
      print(res.body);
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
    //print(jsonDecode(utf8.decode(res.bodyBytes)));
    if (res.statusCode == 200) {
      return UserProfile.fromJson(
          jsonDecode(utf8.decode(res.bodyBytes))["data"]);
    } else {
      throw Exception("http error :(");
    }
  }

  Future<List<CrewSimple>> getMyCrews() async {
    // 수정 - 테스트 API
    const storage = FlutterSecureStorage();
    // final res = await api("$testUrl/crews/me", HttpMethod.get);
    final res = await api("$baseUrl/crews/me", HttpMethod.get,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true);
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
    const storage = FlutterSecureStorage();
    // final res = await api("$testUrl/crews/me/can-join", HttpMethod.get);
    final res = await api("$baseUrl/crews/can-join", HttpMethod.get,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true);
    // print(jsonDecode(utf8.decode(res.bodyBytes)));
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
    const storage = FlutterSecureStorage();
    // final res = await api("$testUrl/contents/today", HttpMethod.get,
    final res = await api("$korBaseUrl/contents/today", HttpMethod.get,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true);
    // print(jsonDecode(utf8.decode(res.bodyBytes)));
    if (res.statusCode == 200) {
      return Content.fromJson(jsonDecode(utf8.decode(res.bodyBytes))["data"]);
    } else {
      throw Exception("http error :(");
    }
  }

  /* 홈 - 크루 API */
  Future<List<Crew>> getCrews() async {
    // 수정 - page, sort
    const storage = FlutterSecureStorage();
    // final res = await api("$korTestUrl/crews", HttpMethod.get);
    final res = await api("$korBaseUrl/crews", HttpMethod.get,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true);
    if (res.statusCode == 200) {
      return (jsonDecode(utf8.decode(res.bodyBytes))["data"]["content"] as List)
          .map((e) => Crew.fromJson(e))
          .toList();
    } else {
      throw Exception("http error :(");
    }
  }

  Future<CrewDetail> getCrewDetail(int crewId) async {
    const storage = FlutterSecureStorage();
    // 수정 - 테스트 API & crewId, 한글
    // final res = await api("$korTestUrl/crews/$crewId", HttpMethod.get);
    final res = await api("$korBaseUrl/crews/$crewId", HttpMethod.get,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true);
    if (res.statusCode == 200) {
      return (CrewDetail.fromJson(
          jsonDecode(utf8.decode(res.bodyBytes))["data"]));
    } else {
      throw Exception("http error :(");
    }
  }

  Future<int> createCrew(CrewToJson crew) async {
    // 수정 - 테스트 API
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/crews", HttpMethod.post,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        body: jsonEncode(crew.toJson()),
        needCheck: true);
    // final res =
    //     await api("$testUrl/crews", HttpMethod.post, body: jsonEncode(crew));
    if (res.statusCode == 200) {
      return jsonDecode(utf8.decode(res.bodyBytes))["data"]["crewId"];
    } else {
      throw Exception("http error :(");
    }
  }

  Future<bool> joinCrew(int crewId, bool autoApproval,
      {String msg = ""}) async {
    const storage = FlutterSecureStorage();
    late final http.Response res;
    if (autoApproval) {
      res = await api("$baseUrl/crews/$crewId/join", HttpMethod.post,
          token: "Bearer ${await storage.read(key: "accessToken")}",
          needCheck: true);
    } else {
      res = await api("$baseUrl/crews/$crewId/join", HttpMethod.post,
          body: jsonEncode({"message": msg}),
          token: "Bearer ${await storage.read(key: "accessToken")}",
          needCheck: true);
    }
    if (res.statusCode == 200) {
      return jsonDecode(utf8.decode(res.bodyBytes))["success"];
    } else {
      print(jsonDecode(utf8.decode(res.bodyBytes)));
      throw Exception("http error :(");
    }
  }

  /* 크루 스페이스 */
  Future<List<Report>> getReports(int crewId) async {
    const storage = FlutterSecureStorage();
    // 수정 - sort 추가
    final res = await api("$baseUrl/crews/$crewId/reports", HttpMethod.get,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true);
    if (res.statusCode == 200) {
      return (jsonDecode(utf8.decode(res.bodyBytes))["data"]["reports"] as List)
          .map((e) => Report.fromJson(e))
          .toList();
    } else {
      print(res.body);
      throw Exception("http error :(");
    }
  }

  Future<int> getMyId() async {
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/members/my-id", HttpMethod.get,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true);
    print(jsonDecode(utf8.decode(res.bodyBytes)));
    if (res.statusCode == 200) {
      return jsonDecode(utf8.decode(res.bodyBytes))["data"]["id"];
    } else {
      throw Exception("http error :(");
    }
  }

  Future<Agora> getAgoraToken(int crewId, bool isActivated) async {
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/crews/$crewId/voice-room", HttpMethod.post,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        body: jsonEncode({"isActivated": isActivated}),
        needCheck: true);
    if (res.statusCode == 200) {
      return Agora.fromJson(jsonDecode(utf8.decode(res.bodyBytes))["data"]);
    } else {
      print(res.body);
      throw Exception("http error :(");
    }
  }

  Future<bool> uploadVoiceFile(int reportId, String path) async {
    const storage = FlutterSecureStorage();
    final dio = Dio();
    final formData =
        FormData.fromMap({"file": MultipartFile.fromFileSync(path)});

    final res = await dio.post("$baseUrl/crews/reports/$reportId/voice-file",
        data: formData,
        options: Options(headers: {
          "Authorization": "Bearer ${await storage.read(key: "accessToken")}",
        }));
    print(res.data);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestCreateReport(int reportId) async {
    const storage = FlutterSecureStorage();
    final res = await api(
        "$baseUrl/crews/reports/$reportId/request", HttpMethod.post,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true);
    if (res.statusCode == 200) {
      return true;
    } else {
      print(res.body);
      throw Exception("http error :(");
    }
  }

  /* 크루 스페이스 - 일정 */
  Future<ScheduleSimple?> getUpcomingSchedule(int crewId) async {
    const storage = FlutterSecureStorage();
    final res = await api(
        "$baseUrl/crews/$crewId/schedules/upcoming", HttpMethod.get,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true);
    print(crewId);
    if (res.statusCode == 200) {
      if (jsonDecode(utf8.decode(res.bodyBytes))["data"].toString() == "{}") {
        return null;
      } else {
        return ScheduleSimple.fromJson(
            jsonDecode(utf8.decode(res.bodyBytes))["data"]);
      }
    } else {
      throw Exception("http error :(");
    }
  }

  Future<List<Schedule>> getSchedules(int crewId) async {
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/crews/$crewId/schedules", HttpMethod.get,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true);
    print(jsonDecode(utf8.decode(res.bodyBytes)));
    if (res.statusCode == 200) {
      return (jsonDecode(utf8.decode(res.bodyBytes))["data"]["schedules"]
              as List)
          .map((e) => Schedule.fromJson(e))
          .toList();
    } else {
      throw Exception("http error :(");
    }
  }

  Future<bool> createSchedule(
      int crewId, String title, String meetingTime) async {
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/crews/$crewId/schedules", HttpMethod.post,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true,
        body: jsonEncode({"title": title, "meetingTime": meetingTime}));
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception("http error :(");
    }
  }

  Future<bool> joinSchedule(int crewId, int scheduleId) async {
    const storage = FlutterSecureStorage();
    final res = await api(
        "$baseUrl/crews/$crewId/schedules/join", HttpMethod.post,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true,
        body: jsonEncode({"id": scheduleId}));
    print(jsonDecode(utf8.decode(res.bodyBytes)));
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> cancelSchedule(int crewId, int scheduleId) async {
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/crews/$crewId/schedules", HttpMethod.delete,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true,
        body: jsonEncode({"id": scheduleId}));
    print(jsonDecode(utf8.decode(res.bodyBytes)));
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /* 크루 리포트 */
  Future<ReportDetail> getDetailReport(int crewId, int reportId) async {
    const storage = FlutterSecureStorage();
    final res = await api(
      "$baseUrl/crews/reports/$reportId",
      HttpMethod.get,
      token: "Bearer ${await storage.read(key: "accessToken")}",
      needCheck: true,
    );
    if (res.statusCode == 200) {
      return ReportDetail.fromJson(
          jsonDecode(utf8.decode(res.bodyBytes))["data"]);
    } else {
      throw Exception("http error :(");
    }
  }

  /* 마이페이지 */
  Future<bool> patchProfile(UserProfile user) async {
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/profile", HttpMethod.patch,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        body: jsonEncode(user.toJson()));
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

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

  /* 마이스페이스 */
  Future<List<ContentCategory>> getContentList(ContentLangType type) async {
    final langUrl = (type == ContentLangType.kor ? korBaseUrl : engBaseUrl);
    const storage = FlutterSecureStorage();
    final res = await api(
      "$langUrl/contents",
      HttpMethod.get,
      token: "Bearer ${await storage.read(key: "accessToken")}",
      needCheck: true,
    );
    if (res.statusCode == 200) {
      print(jsonDecode(utf8.decode(res.bodyBytes)));
      return (jsonDecode(utf8.decode(res.bodyBytes))["data"]["category"]
              as List)
          .map((e) => ContentCategory.fromJson(e))
          .toList();
    } else {
      print(jsonDecode(utf8.decode(res.bodyBytes)));
      throw Exception("http error :(");
    }
  }

  Future<ContentDetail> getContent(int contentId) async {
    const storage = FlutterSecureStorage();
    final res = await api(
      "$baseUrl/contents/$contentId",
      HttpMethod.get,
      token: "Bearer ${await storage.read(key: "accessToken")}",
    );
    if (res.statusCode == 200) {
      return ContentDetail.fromJson(
          jsonDecode(utf8.decode(res.bodyBytes))["data"]);
    } else {
      print(jsonDecode(utf8.decode(res.bodyBytes)));
      throw Exception("http error :(");
    }
  }

  Future<ContentFeedback> getContentFeedback(
      int contentId, String userAnswer) async {
    const storage = FlutterSecureStorage();
    final res = await api(
        "$baseUrl/contents/$contentId/feedback", HttpMethod.post,
        token: "Bearer ${await storage.read(key: "accessToken")}",
        needCheck: true,
        body: jsonEncode({"userAnswer": userAnswer}));
    if (res.statusCode == 200) {
      return ContentFeedback.fromJson(
          jsonDecode(utf8.decode(res.bodyBytes))["data"]);
    } else {
      throw Exception("http error :(");
    }
  }

  Future<bool> uploadRecords(int contentId, List<String> pathes) async {
    const storage = FlutterSecureStorage();
    final dio = Dio();
    final formData = FormData.fromMap({
      "files": List.generate(
          pathes.length, (idx) => MultipartFile.fromFileSync(pathes[idx]))
    });

    final res = await dio.post("$baseUrl/contents/$contentId/practice",
        data: formData,
        options: Options(headers: {
          "Authorization": "Bearer ${await storage.read(key: "accessToken")}",
        }));
    print(res.data);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /* 히스토리 */
  Future<List<History>> getHistory() async {
    const storage = FlutterSecureStorage();
    final res = await api(
      "$baseUrl/reports/history",
      HttpMethod.get,
      token: "Bearer ${await storage.read(key: "accessToken")}",
    );
    if (res.statusCode == 200) {
      return (jsonDecode(utf8.decode(res.bodyBytes))["data"]["histories"]
              as List)
          .map((e) => History.fromJson(e))
          .toList();
    } else {
      print(jsonDecode(utf8.decode(res.bodyBytes)));
      throw Exception("http error :(");
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
