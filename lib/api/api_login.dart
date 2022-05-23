import 'dart:convert';
import "package:http/http.dart" as http;
import '../models/user_model.dart';

Future<UserModel> postLogin(String email, String password) async {
  // return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  print("calling login api...");
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
  final userModel = userModelFromJson(response.body.toString());
  print(userModel);
  return userModel;
}

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());