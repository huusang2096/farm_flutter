// To parse this JSON data, do
//
//     final addGradenResponse = addGradenResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/graden/graden_response.dart';

class AddGradenResponse {
  AddGradenResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  MyGarden data;
  String message;

  factory AddGradenResponse.fromRawJson(String str) =>
      AddGradenResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddGradenResponse.fromJson(Map<String, dynamic> json) =>
      AddGradenResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null ? null : MyGarden.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}
