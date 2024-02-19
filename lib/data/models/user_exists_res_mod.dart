// To parse this JSON data, do
//
//     final userExistsResponse = userExistsResponseFromJson(jsonString);

import 'dart:convert';

UserExistsResponse userExistsResponseFromJson(String str) =>
    UserExistsResponse.fromJson(json.decode(str));

String userExistsResponseToJson(UserExistsResponse data) =>
    json.encode(data.toJson());

class UserExistsResponse {
  final bool? exists;

  UserExistsResponse({
    this.exists,
  });

  factory UserExistsResponse.fromJson(Map<String, dynamic> json) =>
      UserExistsResponse(
        exists: json["exists"],
      );

  Map<String, dynamic> toJson() => {
        "exists": exists,
      };
}
