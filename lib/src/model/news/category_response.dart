// To parse this JSON data, do
//
//     final videoResponse = videoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/news/category.dart';

class CategoryResponse {
  CategoryResponse({
    this.data,
    this.error,
    this.message,
  });

  List<Category> data;
  bool error;
  dynamic message;

  factory CategoryResponse.fromRawJson(String str) =>
      CategoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        data: json["data"] == null
            ? null
            : List<Category>.from(
                json["data"].map((x) => Category.fromJson(x))),
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
