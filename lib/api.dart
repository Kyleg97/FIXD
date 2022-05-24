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
    // await getUserInfo();
    print("response!");
    print(response.body.toString());
    return UserModel.fromJson(json.decode(response.body.toString()));
  }

  static Future getUserInfo() async {
    String url = "https://staff.dev.fixdapp.com/api/v2/users/559426";
    final headers = {
      'Authorization':
          'BearerwFj/uwMby4UqX6jj.VnyMkjUwNx9evRJf0WCB6kAlqhRGeBt6cIYe5v++uqQhRDWxm3lF21x0BXEwqU0P',
      'X-Endpoint-Version': '2019-06-20',
      'X-Verbose-Response': 'true',
      'Accept-Language': 'en-US',
      'Content-Type': 'application/json;distance=mi;currency=USD'
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    return UserModel.fromJson(json.decode(response.body.toString()));
    // print(response.body.toString());
  }
}
