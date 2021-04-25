// To parse this JSON data, do
//
//     final plantProtectionTypesResponse = plantProtectionTypesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/plant_protect/plant_respone.dart';

class PlantProtectionTypesResponse {
  PlantProtectionTypesResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<PlantProtectionTypes> data;
  String message;

  factory PlantProtectionTypesResponse.fromRawJson(String str) =>
      PlantProtectionTypesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlantProtectionTypesResponse.fromJson(Map<String, dynamic> json) =>
      PlantProtectionTypesResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<PlantProtectionTypes>.from(
                json["data"].map((x) => PlantProtectionTypes.fromJson(x))),
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

class PlantProtectionTypes {
  PlantProtectionTypes(
      {this.id,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.plantProtects});

  int id;
  String name;
  String description;
  dynamic createdAt;
  dynamic updatedAt;
  List<PlantProtect> plantProtects;

  factory PlantProtectionTypes.fromRawJson(String str) =>
      PlantProtectionTypes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlantProtectionTypes.fromJson(Map<String, dynamic> json) =>
      PlantProtectionTypes(
          id: json["id"] == null ? null : json["id"],
          name: json["name"] == null ? null : json["name"],
          description: json["description"] == null ? null : json["description"],
          createdAt: json["created_at"],
          updatedAt: json["updated_at"],
          plantProtects: []);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
