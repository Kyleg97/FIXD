import 'package:fixd/models/user_model.dart';
import 'package:flutter/material.dart';
import '../api.dart';

class VinProvider with ChangeNotifier {
  bool _isFetching = false;

  bool get isFetching => _isFetching;
}
