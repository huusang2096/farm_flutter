// To parse this JSON data, do
//
//     final actionRequest = actionRequestFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/graden/action.dart';

class ActionRequest {
  ActionRequest({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.actions,
  });

  int id;
  String name;
  String image;
  dynamic createdAt;
  dynamic updatedAt;
  List<ActionModel> actions = [];

  factory ActionRequest.fromRawJson(String str) =>
      ActionRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActionRequest.fromJson(Map<String, dynamic> json) => ActionRequest(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        actions: json["actions"] == null
            ? []
            : List<ActionModel>.from(
                json["actions"].map((x) => ActionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "actions": actions == null
            ? null
            : List<dynamic>.from(actions.map((x) => x.toJson())),
      };
}
