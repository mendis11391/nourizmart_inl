// To parse this JSON data, do
//
//     final userRegisterModel = userRegisterModelFromJson(jsonString);

import 'dart:convert';

UserRegisterModel userRegisterModelFromJson(String str) =>
    UserRegisterModel.fromJson(json.decode(str));

String userRegisterModelToJson(UserRegisterModel data) =>
    json.encode(data.toJson());

class UserRegisterModel {
  String firebaseId;
  String firstName;
  String lastName;
  String mobile;
  String email;
  String state;
  String district;
  String area;
  int pincode;
  String landmark;

  UserRegisterModel({
    required this.firebaseId,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.state,
    required this.district,
    required this.area,
    required this.pincode,
    required this.landmark,
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterModel(
        firebaseId: json["firebaseId"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        email: json["email"],
        state: json["state"],
        district: json["district"],
        area: json["area"],
        pincode: json["pincode"],
        landmark: json["landmark"],
      );

  Map<String, dynamic> toJson() => {
        "firebaseId": firebaseId,
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
        "email": email,
        "state": state,
        "district": district,
        "area": area,
        "pincode": pincode,
        "landmark": landmark,
      };
}
