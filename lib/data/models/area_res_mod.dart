// To parse this JSON data, do
//
//     final areaResponse = areaResponseFromJson(jsonString);

import 'dart:convert';

List<AreaResponse> areaResponseFromJson(String str) => List<AreaResponse>.from(
    json.decode(str).map((x) => AreaResponse.fromJson(x)));

String areaResponseToJson(List<AreaResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AreaResponse {
  final int? areaId;
  final String? areaName;
  final int? pincodeId;

  AreaResponse({
    this.areaId,
    this.areaName,
    this.pincodeId,
  });

  factory AreaResponse.fromJson(Map<String, dynamic> json) => AreaResponse(
        areaId: json["areaId"],
        areaName: json["areaName"],
        pincodeId: json["pincodeId"],
      );

  Map<String, dynamic> toJson() => {
        "areaId": areaId,
        "areaName": areaName,
        "pincodeId": pincodeId,
      };
}
