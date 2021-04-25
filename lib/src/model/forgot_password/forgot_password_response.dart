// To parse this JSON data, do
//
//     final forgotPasswordResponse = forgotPasswordResponseFromJson(jsonString);

import 'dart:convert';

class ForgotPasswordResponse {
  ForgotPasswordResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  dynamic data;
  String message;

  ForgotPasswordResponse copyWith({
    bool error,
    dynamic data,
    String message,
  }) =>
      ForgotPasswordResponse(
        error: error ?? this.error,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory ForgotPasswordResponse.fromRawJson(String str) =>
      ForgotPasswordResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(
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
