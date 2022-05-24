import 'dart:ffi';

import 'package:fixd/models/user_model.dart';
import 'package:flutter/material.dart';

import '../api.dart';

class UserProvider with ChangeNotifier {
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  late UserModel _userModel;

  UserModel get userModel => _userModel;

  Future<void> login(String email, String password) async {
    _isFetching = true;
    notifyListeners();
    _userModel = await API.postLogin(email, password);
    _isFetching = false;
    notifyListeners();
  }

  Future<void> fetchUserInfo() async {
    _isFetching = true;
    notifyListeners();
    _userModel = await API.getUserInfo();
    _isFetching = false;
    notifyListeners();
  }
}
