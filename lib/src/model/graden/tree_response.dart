// To parse this JSON data, do
//
//     final treeResponse = treeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/graden/tree_list.dart';

class TreeResponse {
  TreeResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<TreeList> data;
  String message;

  factory TreeResponse.fromRawJson(String str) =>
      TreeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TreeResponse.fromJson(Map<String, dynamic> json) => TreeResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<TreeList>.from(
                json["data"].map((x) => TreeList.fromJson(x))),
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
