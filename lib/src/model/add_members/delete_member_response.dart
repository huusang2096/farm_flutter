// To parse this JSON data, do
//
//     final deleteMemberResponse = deleteMemberResponseFromJson(jsonString);

import 'dart:convert';

class DeleteMemberResponse {
  DeleteMemberResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  dynamic data;
  String message;

  factory DeleteMemberResponse.fromRawJson(String str) =>
      DeleteMemberResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteMemberResponse.fromJson(Map<String, dynamic> json) =>
      DeleteMemberResponse(
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
