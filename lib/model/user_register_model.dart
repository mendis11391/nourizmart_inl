// To parse this JSON data, do
//
//     final userRegisterModel = userRegisterModelFromJson(jsonString);

import 'dart:convert';

UserRegisterModel userRegisterModelFromJson(String str) =>
    UserRegisterModel.fromJson(json.decode(str));

String userRegisterModelToJson(UserRegisterModel data) =>
    json.encode(data.toJson());

class UserRegisterModel {
  int nourishmartId;
  String firebaseId;
  String firstName;
  String lastName;
  String mobile;
  String email;
  String state;
  String district;
  String taluk;
  String area;
  int pincode;
  String landmark;
  String address;

  UserRegisterModel({
    required this.nourishmartId,
    required this.firebaseId,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.state,
    required this.district,
    required this.taluk,
    required this.area,
    required this.pincode,
    required this.landmark,
    required this.address,
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterModel(
        nourishmartId: json["nourishmartId"],
        firebaseId: json["firebaseId"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        email: json["email"],
        state: json["state"],
        district: json["district"],
        taluk: json["taluk"],
        area: json["area"],
        pincode: json["pincode"],
        landmark: json["landmark"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "nourishmartId": nourishmartId,
        "firebaseId": firebaseId,
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
        "email": email,
        "state": state,
        "district": district,
        "taluk": taluk,
        "area": area,
        "pincode": pincode,
        "landmark": landmark,
        "address": address,
      };
}
