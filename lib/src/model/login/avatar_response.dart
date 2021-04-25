// To parse this JSON data, do
//
//     final avatarResponse = avatarResponseFromJson(jsonString);

import 'dart:convert';

class AvatarResponse {
  AvatarResponse({
    this.error,
    this.message,
  });

  bool error;
  String message;

  factory AvatarResponse.fromRawJson(String str) =>
      AvatarResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AvatarResponse.fromJson(Map<String, dynamic> json) => AvatarResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
      };
}
