// To parse this JSON data, do
//
//     final districtResponse = districtResponseFromJson(jsonString);

import 'dart:convert';

List<DistrictResponse> districtResponseFromJson(String str) =>
    List<DistrictResponse>.from(
        json.decode(str).map((x) => DistrictResponse.fromJson(x)));

String districtResponseToJson(List<DistrictResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DistrictResponse {
  final int? districtId;
  final String? districtName;
  final int? stateId;

  DistrictResponse({
    this.districtId,
    this.districtName,
    this.stateId,
  });

  factory DistrictResponse.fromJson(Map<String, dynamic> json) =>
      DistrictResponse(
        districtId: json["districtId"],
        districtName: json["districtName"],
        stateId: json["stateID"],
      );

  Map<String, dynamic> toJson() => {
        "districtId": districtId,
        "districtName": districtName,
        "stateID": stateId,
      };
}
