// To parse this JSON data, do
//
//     final gardenResponse = gardenResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/polygon_garden.dart';

class GardenResponse {
  GardenResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<MyGarden> data;
  dynamic message;

  factory GardenResponse.fromRawJson(String str) =>
      GardenResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GardenResponse.fromJson(Map<String, dynamic> json) => GardenResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<MyGarden>.from(
                json["data"].map((x) => MyGarden.fromJson(x))),
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

class MyGarden {
  MyGarden(
      {this.id,
      this.userId,
      this.name,
      this.description,
      this.address,
      this.locationPolygon,
      this.createdAt,
      this.updatedAt,
      this.image});

  int id;
  int userId;
  String name;
  String description;
  String address;
  List<LocationPolygon> locationPolygon;
  String createdAt;
  String updatedAt;
  List<String> image;

  factory MyGarden.fromRawJson(String str) =>
      MyGarden.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyGarden.fromJson(Map<String, dynamic> json) => MyGarden(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        address: json["address"] == null ? null : json["address"],
        locationPolygon: json["location_polygon"] == null
            ? null
            : List<LocationPolygon>.from(json["location_polygon"]
                .map((x) => LocationPolygon.fromJson(x))),
        image: json["image"] == null
            ? []
            : List<String>.from(json["image"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "address": address == null ? null : address,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "location_polygon": locationPolygon == null
            ? null
            : List<dynamic>.from(locationPolygon.map((x) => x.toJson())),
        "image": image == null ? [] : List<dynamic>.from(image.map((x) => x)),
      };

  getImage() {
    if (image.length == 0) {
      return IMAGE_BASE_URL + "news/183d2958-33a0-475f-b929-496a6fb07b1e.jpg";
    } else {
      return image[0];
    }
  }
}
