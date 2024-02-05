// To parse this JSON data, do
//
//     final userRegisterModel = userRegisterModelFromJson(jsonString);

import 'dart:convert';

UserRegisterModel userRegisterModelFromJson(String str) =>
    UserRegisterModel.fromJson(json.decode(str));

String userRegisterModelToJson(UserRegisterModel data) =>
    json.encode(data.toJson());

class UserRegisterModel {
  dynamic firebaseId;
  dynamic firstName;
  dynamic lastName;
  dynamic mobile;
  dynamic email;
  dynamic houseNo;
  dynamic street;
  dynamic stateId;
  dynamic districtId;
  dynamic pincodeId;
  dynamic areaId;
  dynamic landmark;
  dynamic isActive;
  dynamic createdBy;

  UserRegisterModel(
      {required this.firebaseId,
      required this.firstName,
      required this.lastName,
      required this.mobile,
      required this.email,
      required this.houseNo,
      required this.street,
      required this.stateId,
      required this.districtId,
      required this.pincodeId,
      required this.areaId,
      required this.landmark,
      required this.isActive,
      required this.createdBy});

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterModel(
          firebaseId: json["firebaseId"],
          firstName: json["first_name"],
          lastName: json["last_name"],
          mobile: json["mobile"],
          email: json["email"],
          houseNo: json["house_no"],
          street: json["street"],
          stateId: json["stateId"],
          districtId: json["districtId"],
          pincodeId: json["pincodeId"],
          areaId: json["areaId"],
          landmark: json["landmark"],
          isActive: json["is_active"],
          createdBy: json["createdBy"]);

  Map<String, dynamic> toJson() => {
        "firebaseId": firebaseId,
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
        "email": email,
        "house_no": houseNo,
        "street": street,
        "stateId": stateId,
        "districtId": districtId,
        "pincodeId": pincodeId,
        "areaId": areaId,
        "landmark": landmark,
        "is_active": isActive,
        "createdBy": createdBy
      };
}
