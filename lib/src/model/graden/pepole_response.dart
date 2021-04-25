// To parse this JSON data, do
//
//     final peopleResponse = peopleResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/add_members/add_member_response.dart';

class PeopleResponse {
  PeopleResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<Member> data;
  dynamic message;

  factory PeopleResponse.fromRawJson(String str) =>
      PeopleResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PeopleResponse.fromJson(Map<String, dynamic> json) => PeopleResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<Member>.from(json["data"].map((x) => Member.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}
