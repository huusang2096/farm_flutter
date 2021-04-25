// To parse this JSON data, do
//
//     final treeTypeResponse = treeTypeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/graden/tree_types.dart';

class TreeTypeResponse {
  TreeTypeResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<TreeTypes> data;
  String message;

  factory TreeTypeResponse.fromRawJson(String str) =>
      TreeTypeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TreeTypeResponse.fromJson(Map<String, dynamic> json) =>
      TreeTypeResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<TreeTypes>.from(
                json["data"].map((x) => TreeTypes.fromJson(x))),
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
