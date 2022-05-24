import 'package:fixd/models/user_model.dart';
import 'package:flutter/material.dart';
import '../api.dart';
import '../models/vin_model.dart';

class VinProvider with ChangeNotifier {
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  late VinModel _vinModel;

  VinModel get vinModel => _vinModel;

  Future<void> getMakeAndModel(String VIN) async {
    _isFetching = true;
    notifyListeners();
    _vinModel = await API.getMakeAndModel(VIN);
    _isFetching = false;
    notifyListeners();
  }
}
