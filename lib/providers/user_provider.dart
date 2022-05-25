import 'package:fixd/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api.dart';

class UserProvider with ChangeNotifier {
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  UserModel? _userModel;

  UserModel get userModel => _userModel ?? UserModel(status: "NULL");

  Future<void> login(String email, String password) async {
    _isFetching = true;
    notifyListeners();
    _userModel = await API.postLogin(email, password);
    if (_userModel!.status != "ERROR") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('auth', _userModel!.data!.authenticationToken ?? "");
    }
    _isFetching = false;
    notifyListeners();
  }

  Future<void> fetchUserInfo(String auth) async {
    _isFetching = true;
    // notifyListeners();
    _userModel = await API.getUserInfo(auth);
    _isFetching = false;
    // notifyListeners();
    print("----model----");
    print(_userModel!.data.toString());
  }
}
