import 'dart:convert';

AppErrorException appExceptionFromJson(String str) =>
    AppErrorException.fromJson(json.decode(str));

String appExceptionToJson(AppErrorException data) => json.encode(data.toJson());

class AppErrorException {
  AppErrorException({
    this.success,
    this.message,
  });

  final bool? success;
  final String? message;

  factory AppErrorException.fromJson(Map<String, dynamic> json) =>
      AppErrorException(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
