import 'package:fixd/api.dart';
import 'package:fixd/models/recall_model.dart';
import 'package:fixd/models/vin_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('API Calls', () {
    test('returns json response decoded into VinModel object', () async {
      print("Running valid VIN getMakeAndModel API call test");
      const String vin = "5J8TB1H29CA003675";
      final VinModel response = await API.getMakeAndModel(vin);
      expect(response.results[6].value, "ACURA");
      expect(response.results[8].value, "RDX");
    });

    test('returns a json response without make/model data due to invalid VIN',
        () async {
      print("Running invalid VIN getMakeAndModel API call test");
      const String vin = "blah";
      final VinModel response = await API.getMakeAndModel(vin);
      expect(response.results[6].value, ""); // no make
      expect(response.results[8].value, ""); // no model
    });

    test('returns a json response decoded into RecallModel object', () async {
      print("Running valid make/model/year getRecallData API call test");
      const String vin = "blah";
      final RecallModel response =
          await API.getRecallData("ACURA", "RDX", "2012");
      expect(response.count, 2);
      expect(response.results.isNotEmpty, true);
      expect(
          response.results[0].manufacturer, "Honda (American Honda Motor Co.)");
    });

    test('returns a json response without data due to invalid parameters',
        () async {
      print("Running invalid make/model/year getRecallData API call test");
      const String vin = "blah";
      final RecallModel response =
          await API.getRecallData("blah", "blah", "blah");
      expect(response.count, 0);
      expect(response.results.isEmpty, true);
    });
  });
}
