// To parse this JSON data, do
//
//     final cityResponse = cityResponseFromJson(jsonString);

import 'dart:convert';

class CityResponse {
  CityResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<City> data;
  String message;

  factory CityResponse.fromRawJson(String str) =>
      CityResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<City>.from(json["data"].map((x) => City.fromJson(x))),
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

class City {
  City({
    this.matp,
    this.name,
    this.type,
  });

  String matp;
  String name;
  String type;

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory City.fromJson(Map<String, dynamic> json) => City(
        matp: json["matp"] == null ? null : json["matp"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "matp": matp == null ? null : matp,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
      };
}
