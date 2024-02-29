// To parse this JSON data, do
//
//     final stateResponse = stateResponseFromJson(jsonString);

import 'dart:convert';

List<StateResponse> stateResponseFromJson(String str) =>
    List<StateResponse>.from(
        json.decode(str).map((x) => StateResponse.fromJson(x)));

String stateResponseToJson(List<StateResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StateResponse {
  final int? stateId;
  final String? stateName;

  StateResponse({
    this.stateId,
    this.stateName,
  });

  factory StateResponse.fromJson(Map<String, dynamic> json) => StateResponse(
        stateId: json["stateId"],
        stateName: json["stateName"],
      );

  Map<String, dynamic> toJson() => {
        "stateId": stateId,
        "stateName": stateName,
      };
}
