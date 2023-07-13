import 'dart:convert';
import 'package:blabla/models/country.dart';
import 'package:blabla/utils/dotenv.dart';
import 'package:http/http.dart' as http;

typedef JSON = Map<String, dynamic>;

get baseUrl => env["BASE_URL"];
get countryAPI => env["COUNTRY_API"];

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

  Future<http.Response> api(String url, HttpMethod method, {String? token, Map<String, dynamic>? body}) async {
    try {
      switch (method) {
      case HttpMethod.post:        
        return await http.post(Uri.parse(url));
      case HttpMethod.get:
        return await http.get(Uri.parse(url));
      case HttpMethod.delete:
        return await http.delete(Uri.parse(url));
      case HttpMethod.patch:
        return await http.patch(Uri.parse(url));
      }
    } catch(e) {
      return http.Response(e.toString(), 404);
    }
    
  }

  Future<bool> getNicknameDup(String nickname) async { 
    final res = await api("$baseUrl/members/nicknames/$nickname", HttpMethod.get);
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
    if(res.statusCode == 200) {
      return (jsonDecode(res.body)["data"] as List).map((e) => Country.fromJson(e)).toList();
    } else {
      throw Exception("http error :(");
    }
  }
}
