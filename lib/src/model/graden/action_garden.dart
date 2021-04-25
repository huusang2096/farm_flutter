// To parse this JSON data, do
//
//     final gardenResponse = gardenResponseFromJson(jsonString);

import 'dart:convert';

class ActionGardenResponse {
  ActionGardenResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<ActionGarden> data;
  dynamic message;

  factory ActionGardenResponse.fromRawJson(String str) =>
      ActionGardenResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActionGardenResponse.fromJson(Map<String, dynamic> json) =>
      ActionGardenResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<ActionGarden>.from(
                json["data"].map((x) => ActionGarden.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class ActionGarden {
  ActionGarden({
    this.id,
    this.name,
    this.image,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String image;
  String type;
  dynamic createdAt;
  dynamic updatedAt;

  factory ActionGarden.fromRawJson(String str) =>
      ActionGarden.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActionGarden.fromJson(Map<String, dynamic> json) => ActionGarden(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? '' : json["image"],
        type: json["type_name"] == null ? null : json["type_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image": image == null ? '' : image,
        "type_name": type == null ? null : type,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
