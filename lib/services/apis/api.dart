import 'dart:convert';
import 'package:blabla/models/content.dart';
import 'package:blabla/models/country.dart';
import 'package:blabla/models/crew.dart';
import 'package:blabla/models/emoji_name_tag.dart';
import 'package:blabla/models/interest.dart';
import 'package:blabla/models/level.dart';
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

// class Res {
//   final http.Response httpRes;
//   final String success;
//   final String code;
//   final String msg;
//   final dynamic data;

//   Res({required this.httpRes, required this.success, required this.code, required this.msg, required this.data});
// }

enum HttpMethod {
  post,
  get,
  patch,
  delete,
}

class API {
  API();

  Future<http.Response> api(String url, HttpMethod method,
      {String? token, Map<String, dynamic>? body}) async {
    Map<String, String>? headers;
    if (token != null) {
      headers = {"Authorization": token};
    }

    try {
      switch (method) {
        case HttpMethod.post:
          return await http.post(Uri.parse(url), headers: headers, body: body);
        case HttpMethod.get:
          return await http.get(Uri.parse(url));
        case HttpMethod.delete:
          return await http.delete(Uri.parse(url));
        case HttpMethod.patch:
          return await http.patch(Uri.parse(url));
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
    final res = await api("$korTestUrl/common/levels", HttpMethod.get);
    if (res.statusCode == 200) {
      return (jsonDecode(res.body)["data"]["levels"] as List)
          .map((e) => Level.fromJson(e))
          .toList();
    } else {
      throw Exception("http error :()");
    }
  }

  Future<List<Interest>> getInterests() async {
    // 수정 - 설정 언어 별
    final res = await api("$korTestUrl/common/keywords", HttpMethod.get);
    if (res.statusCode == 200) {
      return (jsonDecode(res.body)["data"]["keywords"] as List)
          .map((e) => Interest.fromJson(e))
          .toList();
    } else {
      throw Exception("http error :(");
    }
  }

  Future<bool> getAccessToken(token, String socialLoginType) async {
    const storage = FlutterSecureStorage();
    final res = await api(
        "$baseUrl/oauth/login/$socialLoginType", HttpMethod.post,
        token: token);
    if (res.statusCode == 200) {
      print(res.body);
      await storage.write(
          key: "accessToken", value: jsonDecode(res.body)["accessToken"]);
      await storage.write(
          key: "refreshToken", value: jsonDecode(res.body)["refreshToken"]);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> join(User user) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "accessToken");
    final res =
        await api("$baseUrl/oauth/sign-up", HttpMethod.post, token: token!);
    if (res.statusCode == 200) {
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
  Future<UserSimple> getMyPrfile() async { // 수정 - 테스트 API
    final res = await api("$testUrl/profile/1", HttpMethod.get);
    if(res.statusCode == 200) {
      return UserSimple.fromJson(jsonDecode(res.body)["data"]);
    } else {
      throw Exception("http error :(");
    }
  }

  Future<List<CrewSimple>> getMyCrews() async { // 수정 - 테스트 API
    final res = await api("$testUrl/crew/me", HttpMethod.get);
    if(res.statusCode == 200) {
      return (jsonDecode(res.body)["data"]["crews"] as List).map((e) => CrewSimple.fromJson(e)).toList();
    } else {
      throw Exception("http error :(");
    } 
  }

  Future<List<CrewSimple>> getNowCrews() async { // 수정 - 테스트 API
    final res = await api("$testUrl/crew/can-join", HttpMethod.get);
    if(res.statusCode == 200) {
      return (jsonDecode(res.body)["data"]["crews"] as List).map((e) => CrewSimple.fromJson(e)).toList();
    } else {
      throw Exception("http error :(");
    } 
  }

  Future<Content> getTodayContent() async { // 수정 - 테스트 API
    final res = await api("$testUrl/content/today", HttpMethod.get);
    if(res.statusCode == 200) {
      return Content.fromJson(jsonDecode(res.body)["data"]["content"]);
    } else {
      throw Exception("http error :(");
    }
  }
}
