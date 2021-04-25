// To parse this JSON data, do
//
//     final districtResponse = districtResponseFromJson(jsonString);

import 'dart:convert';

class DistrictResponse {
  DistrictResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<District> data;
  String message;

  factory DistrictResponse.fromRawJson(String str) =>
      DistrictResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DistrictResponse.fromJson(Map<String, dynamic> json) =>
      DistrictResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<District>.from(
                json["data"].map((x) => District.fromJson(x))),
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

class District {
  District({
    this.maqh,
    this.name,
    this.type,
    this.matp,
  });

  String maqh;
  String name;
  String type;
  String matp;

  factory District.fromRawJson(String str) =>
      District.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory District.fromJson(Map<String, dynamic> json) => District(
        maqh: json["maqh"] == null ? null : json["maqh"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        matp: json["matp"] == null ? null : json["matp"],
      );

  Map<String, dynamic> toJson() => {
        "maqh": maqh == null ? null : maqh,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "matp": matp == null ? null : matp,
      };
}
