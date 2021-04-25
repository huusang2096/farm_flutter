// To parse this JSON data, do
//
//     final changePasswordResponse = changePasswordResponseFromJson(jsonString);

import 'dart:convert';

class ChangePasswordResponse {
  ChangePasswordResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  dynamic data;
  String message;

  factory ChangePasswordResponse.fromRawJson(String str) =>
      ChangePasswordResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data,
        "message": message == null ? null : message,
      };
}
