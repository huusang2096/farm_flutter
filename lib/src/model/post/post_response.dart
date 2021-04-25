// To parse this JSON data, do
//
//     final postResponse = postResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/news/news_model.dart';

class PostResponse {
  PostResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  News data;
  String message;

  factory PostResponse.fromRawJson(String str) =>
      PostResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null ? null : News.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}
