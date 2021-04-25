// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

class RegisterResponse {
  RegisterResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  dynamic data;
  String message;

  RegisterResponse copyWith({
    bool error,
    dynamic data,
    String message,
  }) =>
      RegisterResponse(
        error: error ?? this.error,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory RegisterResponse.fromRawJson(String str) =>
      RegisterResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
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
