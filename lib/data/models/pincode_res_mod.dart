// To parse this JSON data, do
//
//     final pincodeResponse = pincodeResponseFromJson(jsonString);

import 'dart:convert';

List<PincodeResponse> pincodeResponseFromJson(String str) =>
    List<PincodeResponse>.from(
        json.decode(str).map((x) => PincodeResponse.fromJson(x)));

String pincodeResponseToJson(List<PincodeResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PincodeResponse {
  final int? pincodeId;
  final String? pincode;
  final int? districtId;

  PincodeResponse({
    this.pincodeId,
    this.pincode,
    this.districtId,
  });

  factory PincodeResponse.fromJson(Map<String, dynamic> json) =>
      PincodeResponse(
        pincodeId: json["pincodeId"],
        pincode: json["pincode"],
        districtId: json["districtId"],
      );

  Map<String, dynamic> toJson() => {
        "pincodeId": pincodeId,
        "pincode": pincode,
        "districtId": districtId,
      };
}
