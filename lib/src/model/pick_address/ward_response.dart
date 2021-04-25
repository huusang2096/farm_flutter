// To parse this JSON data, do
//
//     final wardResponse = wardResponseFromJson(jsonString);

import 'dart:convert';

class WardResponse {
  WardResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<Ward> data;
  String message;

  factory WardResponse.fromRawJson(String str) =>
      WardResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WardResponse.fromJson(Map<String, dynamic> json) => WardResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<Ward>.from(json["data"].map((x) => Ward.fromJson(x))),
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

class Ward {
  Ward({
    this.xaid,
    this.name,
    this.type,
    this.maqh,
  });

  String xaid;
  String name;
  String type;
  String maqh;

  factory Ward.fromRawJson(String str) => Ward.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        xaid: json["xaid"] == null ? null : json["xaid"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        maqh: json["maqh"] == null ? null : json["maqh"],
      );

  Map<String, dynamic> toJson() => {
        "xaid": xaid == null ? null : xaid,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "maqh": maqh == null ? null : maqh,
      };
}
