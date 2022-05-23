import "package:http/http.dart" as http;
import '../models/user_model.dart';
import 'dart:convert';

class API {
  static Future postLogin(String email, String password) async {
    String url = "https://staff.dev.fixdapp.com/api/v2/session";
    final data = jsonEncode({
      "session": {"email": email, "password": password}
    });
    final headers = {
      'X-Endpoint-Version': '2019-06-20',
      'X-Verbose-Response': 'true',
      'Accept-Language': 'en-US',
      'X-Key-Inflection': 'snake',
      'Content-Type': 'application/json;distance=mi;currency=USD',
    };
    final response =
        await http.post(Uri.parse(url), headers: headers, body: data);
    return UserModel.fromJson(json.decode(response.body.toString()));
  }
}
