// To parse this JSON data, do
//
//     final videoResponse = videoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/news/news_model.dart';

class NewsByTagsResponse {
  NewsByTagsResponse({
    this.data,
    this.error,
    this.message,
  });

  List<News> data;
  bool error;
  dynamic message;

  factory NewsByTagsResponse.fromRawJson(String str) =>
      NewsByTagsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsByTagsResponse.fromJson(Map<String, dynamic> json) =>
      NewsByTagsResponse(
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
