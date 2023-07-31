import 'dart:convert';
import 'package:blabla/models/country.dart';
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
      {String? token, body}) async {
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

    try {
      switch (method) {
        case HttpMethod.post:
          return await http.post(Uri.parse(url), headers: headers, body: body);
        case HttpMethod.get:
          return await http.get(Uri.parse(url), headers: headers);
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

  Future<bool> login(String loginType) async {
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/oauth/login/$loginType", HttpMethod.post,
        token: await storage.read(key: "socialToken"));
    if (res.statusCode == 200 && jsonDecode(res.body)["accessToken"] != null) {
      print(jsonDecode(res.body)["accessToken"]);
      print(jsonDecode(res.body)["refreshToken"]);
      await Future.wait([
        storage.write(
            key: "accessToken", value: jsonDecode(res.body)["accessToken"]),
        storage.write(
            key: "refreshToken", value: jsonDecode(res.body)["refreshToken"]),
      ]);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> join(User user) async {
    const storage = FlutterSecureStorage();
    final res = await api("$baseUrl/oauth/sign-up", HttpMethod.post,
        token: await storage.read(key: "socialToken"), body: jsonEncode(user));
    
    print(await storage.read(key: "socialToken"));
    if (res.statusCode == 200) {
      await Future.wait([
        storage.write(
            key: "accessToken", value: jsonDecode(res.body)["accessToken"]),
        storage.write(
            key: "refreshToken", value: jsonDecode(res.body)["refreshToken"]),
      ]);
      return true;
    } else {
      print(res.body);
      return false;
    }
  }
}
