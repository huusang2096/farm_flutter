// To parse this JSON data, do
//
//     final editMemberResponse = editMemberResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/add_members/add_member_response.dart';

class EditMemberResponse {
  EditMemberResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  Member data;
  String message;

  factory EditMemberResponse.fromRawJson(String str) =>
      EditMemberResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EditMemberResponse.fromJson(Map<String, dynamic> json) =>
      EditMemberResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null ? null : Member.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}
