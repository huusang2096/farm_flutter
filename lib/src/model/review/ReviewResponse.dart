// To parse this JSON data, do
//
//     final reviewResponse = reviewResponseFromJson(jsonString);

import 'dart:convert';

class ReviewResponse {
  ReviewResponse({
    this.code,
    this.name,
    this.rating
  });

  String code;
  String name;
  double rating;

  factory ReviewResponse.fromRawJson(String str) => ReviewResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
    code: json["code"] == null ? null : json["code"],
    name: json["name"] == null ? null : json["name"],
    rating: 5
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "name": name == null ? null : name,
  };
}
