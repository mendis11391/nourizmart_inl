// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

List<UserResponse> userResponseFromJson(String str) => List<UserResponse>.from(
    json.decode(str).map((x) => UserResponse.fromJson(x)));

String userResponseToJson(List<UserResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

UserResponse userResponseSingleFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseSingleToJson(UserResponse data) =>
    json.encode(data.toJson());

class UserResponse {
  String? firstName;
  String? lastName;
  String? mobile;
  final String? email;
  String? houseNo;
  String? street;
  String? areaName;
  String? districtName;
  String? stateName;
  String? pincode;
  int? pincodeId;

  UserResponse({
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.houseNo,
    this.street,
    this.areaName,
    this.districtName,
    this.stateName,
    this.pincode,
    this.pincodeId,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        firstName: json["firstname"],
        lastName: json["lastname"],
        mobile: json["mobile"],
        email: json["email"],
        houseNo: json["houseno"],
        street: json["street"],
        areaName: json["areaname"],
        districtName: json["districtname"],
        stateName: json["statename"],
        pincode: json["pincode"],
        pincodeId: json["pincodeId"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstName,
        "lastname": lastName,
        "mobile": mobile,
        "email": email,
        "houseno": houseNo,
        "street": street,
        "areaname": areaName,
        "districtname": districtName,
        "statename": stateName,
        "pincode": pincode,
        "pincodeId": pincodeId,
      };
}
