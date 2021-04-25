// To parse this JSON data, do
//
//     final videoResponse = videoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/news/news_model.dart';

class NewsCategoryResponse {
  NewsCategoryResponse({this.data, this.error, this.message, this.links});

  List<News> data;
  bool error;
  dynamic message;
  Links links;

  factory NewsCategoryResponse.fromRawJson(String str) =>
      NewsCategoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsCategoryResponse.fromJson(Map<String, dynamic> json) =>
      NewsCategoryResponse(
        data: json["data"] == null
            ? null
            : List<News>.from(json["data"].map((x) => News.fromJson(x))),
        error: json["error"] == null ? null : json["error"],
        message: json["message"],
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : error,
        "message": message,
        "links": links == null ? null : links.toJson(),
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  String next;

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"] == null ? null : json["first"],
        last: json["last"] == null ? null : json["last"],
        prev: json["prev"],
        next: json["next"] == null ? null : json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first == null ? null : first,
        "last": last == null ? null : last,
        "prev": prev,
        "next": next == null ? null : next,
      };
}
