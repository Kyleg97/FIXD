import "package:http/http.dart" as http;
import '../models/user_model.dart';
import 'dart:convert';
import 'models/recall_model.dart';
import 'models/vin_model.dart';

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
    if (jsonDecode(response.body.toString())["status"] == "ERROR") {
      return UserModel(status: "ERROR");
    }
    return UserModel.fromJson(json.decode(response.body.toString()));
  }

  static Future getUserInfo(String auth) async {
    String url = "https://staff.dev.fixdapp.com/api/v2/users/559426";
    final headers = {
      'Authorization': auth,
      'X-Endpoint-Version': '2019-06-20',
      'X-Verbose-Response': 'true',
      'Accept-Language': 'en-US',
      'Content-Type': 'application/json;distance=mi;currency=USD'
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    return UserModel.fromJson(json.decode(response.body.toString()));
  }

  static Future getMakeAndModel(String VIN) async {
    String url =
        "https://vpic.nhtsa.dot.gov/api/vehicles/decodevin/${VIN}?format=json";
    final response = await http.get(Uri.parse(url));
    print("------response--------");
    print(response.body.toString());
    return VinModel.fromJson(json.decode(response.body.toString()));
  }

  static Future getRecallData(String make, String model, String year) async {
    String url =
        "https://api.nhtsa.gov/recalls/recallsByVehicle?make=${make}&model=${model}&modelYear=${year}";
    final response = await http.get(Uri.parse(url));
    return RecallModel.fromJson(json.decode(response.body.toString()));
  }
}
