// To parse this JSON data, do
//
//     final allProjectResponse = allProjectResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/manager_project/my_project_response.dart';

class AllProjectResponse {
  AllProjectResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<Project> data;
  String message;

  factory AllProjectResponse.fromRawJson(String str) =>
      AllProjectResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllProjectResponse.fromJson(Map<String, dynamic> json) =>
      AllProjectResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<Project>.from(json["data"].map((x) => Project.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message == null ? null : message,
      };
}
