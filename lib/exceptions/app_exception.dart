import 'dart:convert';

AppErrorException appExceptionFromJson(String str) =>
    AppErrorException.fromJson(json.decode(str));

String appExceptionToJson(AppErrorException data) => json.encode(data.toJson());

class AppErrorException {
  AppErrorException({
    this.success,
    this.message,
    this.detail,
    this.errors,
    this.oldPassword,
    this.error,
  });

  final bool? success;
  final String? message;
  final String? detail;
  final String? oldPassword;
  final Errors? errors;
  final Error? error;

  factory AppErrorException.fromJson(Map<String, dynamic> json) =>
      AppErrorException(
        success: json["success"],
        message: json["message"],
        detail: json["detail"],
        oldPassword: json["old_password"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "detail": detail,
        "old_password": oldPassword,
        "errors": errors == null ? null : errors!.toJson(),
        "error": error == null ? null : error!.toJson(),
      };
}

class Errors {
  Errors({
    this.statusCode,
    this.details,
    this.message,
  });

  final int? statusCode;
  final String? message;
  final List<Detail>? details;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        statusCode: json["statusCode"],
        message: json["message"],
        details: json["details"] == null
            ? null
            : List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "details": details == null
            ? null
            : List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Error {
  Error({
    this.type,
    this.message,
  });

  final String? type;
  final String? message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        type: json["type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
      };
}

class Detail {
  Detail({
    this.param,
    this.key,
    this.property,
    this.message,
  });

  final String? param;
  final String? key;
  final String? property;
  final String? message;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        param: json["param"],
        key: json["key"],
        property: json["property"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "param": param,
        "key": key,
        "property": property,
        "message": message,
      };
}
