// To parse this JSON data, do
//
//     final videoResponse = videoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/news/news_model.dart';

class HotResponse {
  HotResponse({
    this.data,
    this.error,
    this.message,
  });

  List<News> data;
  bool error;
  dynamic message;

  factory HotResponse.fromRawJson(String str) =>
      HotResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HotResponse.fromJson(Map<String, dynamic> json) => HotResponse(
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
