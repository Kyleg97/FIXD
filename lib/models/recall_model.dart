class RecallModel {
  RecallModel({
    required this.count,
    required this.message,
    required this.results,
  });

  int count;
  String message;
  List<Result> results;

  factory RecallModel.fromJson(Map<String, dynamic> json) => RecallModel(
        count: json["Count"],
        message: json["Message"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Count": count,
        "Message": message,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.manufacturer,
    required this.nhtsaCampaignNumber,
    required this.parkIt,
    required this.parkOutSide,
    required this.nhtsaActionNumber,
    required this.reportReceivedDate,
    required this.component,
    required this.summary,
    required this.consequence,
    required this.remedy,
    required this.notes,
    required this.modelYear,
    required this.make,
    required this.model,
  });

  String manufacturer;
  String nhtsaCampaignNumber;
  bool parkIt;
  bool parkOutSide;
  String nhtsaActionNumber;
  String reportReceivedDate;
  String component;
  String summary;
  String consequence;
  String remedy;
  String notes;
  String modelYear;
  String make;
  String model;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        manufacturer: json["Manufacturer"],
        nhtsaCampaignNumber: json["NHTSACampaignNumber"],
        parkIt: json["parkIt"],
        parkOutSide: json["parkOutSide"],
        nhtsaActionNumber: json["NHTSAActionNumber"],
        reportReceivedDate: json["ReportReceivedDate"],
        component: json["Component"],
        summary: json["Summary"],
        consequence: json["Consequence"],
        remedy: json["Remedy"],
        notes: json["Notes"],
        modelYear: json["ModelYear"],
        make: json["Make"],
        model: json["Model"],
      );

  Map<String, dynamic> toJson() => {
        "Manufacturer": manufacturer,
        "NHTSACampaignNumber": nhtsaCampaignNumber,
        "parkIt": parkIt,
        "parkOutSide": parkOutSide,
        "NHTSAActionNumber": nhtsaActionNumber,
        "ReportReceivedDate": reportReceivedDate,
        "Component": component,
        "Summary": summary,
        "Consequence": consequence,
        "Remedy": remedy,
        "Notes": notes,
        "ModelYear": modelYear,
        "Make": make,
        "Model": model,
      };
}
