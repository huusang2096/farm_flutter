// To parse this JSON data, do
//
//     final shareResponse = shareResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/news/news_model.dart';

class ShareResponse {
  ShareResponse({
    this.data,
    this.error,
    this.message,
  });

  List<News> data;
  bool error;
  dynamic message;

  factory ShareResponse.fromRawJson(String str) =>
      ShareResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShareResponse.fromJson(Map<String, dynamic> json) => ShareResponse(
        data: json["data"] == null
            ? null
            : List<News>.from(json["data"].map((x) => News.fromJson(x))),
        error: json["error"] == null ? null : json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : error,
        "message": message,
      };
}
