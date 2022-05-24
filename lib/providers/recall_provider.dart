import 'package:flutter/material.dart';
import '../api.dart';
import '../models/recall_model.dart';

class RecallProvider with ChangeNotifier {
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  late RecallModel _recallModel;

  RecallModel get recallModel => _recallModel;

  Future<void> getRecallData(String make, String model, String year) async {
    _isFetching = true;
    notifyListeners();
    _recallModel = await API.getRecallData(make, model, year);
    _isFetching = false;
    notifyListeners();
  }
}
