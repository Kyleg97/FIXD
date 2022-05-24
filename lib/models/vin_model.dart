class VinModel {
  VinModel({
    required this.count,
    required this.message,
    required this.searchCriteria,
    required this.results,
  });

  int count;
  String message;
  String searchCriteria;
  List<Result> results;

  factory VinModel.fromJson(Map<String, dynamic> json) => VinModel(
        count: json["Count"],
        message: json["Message"],
        searchCriteria: json["SearchCriteria"],
        results:
            List<Result>.from(json["Results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Count": count,
        "Message": message,
        "SearchCriteria": searchCriteria,
        "Results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.value,
    this.valueId,
    this.variable,
    this.variableId,
  });

  String? value;
  String? valueId;
  String? variable;
  int? variableId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        value: json["Value"] ?? "",
        valueId: json["ValueId"] ?? "",
        variable: json["Variable"] ?? "",
        variableId: json["VariableId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Value": value,
        "ValueId": valueId,
        "Variable": variable,
        "VariableId": variableId,
      };
}
