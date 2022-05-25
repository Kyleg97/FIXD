class UserModel {
  UserModel({
    required this.status,
    this.data,
  });

  String status;
  Data? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.authenticationToken,
    required this.country,
    required this.diyLevel,
    required this.universalUuid,
  });

  int id;
  String name;
  String email;
  String phoneNumber;
  String? authenticationToken;
  String country;
  dynamic diyLevel;
  String universalUuid;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        authenticationToken: json["authentication_token"],
        country: json["country"],
        diyLevel: json["diy_level"],
        universalUuid: json["universal_uuid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "authentication_token": authenticationToken,
        "country": country,
        "diy_level": diyLevel,
        "universal_uuid": universalUuid,
      };
}
