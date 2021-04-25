// To parse this JSON data, do
//
//     final videoResponse = videoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/news/news_model.dart';

class VideoResponse {
  VideoResponse({
    this.data,
    this.error,
    this.message,
  });

  List<News> data;
  bool error;
  dynamic message;

  factory VideoResponse.fromRawJson(String str) =>
      VideoResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VideoResponse.fromJson(Map<String, dynamic> json) => VideoResponse(
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
