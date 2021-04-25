import 'dart:convert';

import 'package:farmgate/src/model/graden/tree_types.dart';

class TreeList {
  TreeList({
    this.id,
    this.name,
    this.treeTypeId,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.treeTypes,
  });

  int id;
  String name;
  String treeTypeId;
  String image;
  dynamic createdAt;
  dynamic updatedAt;
  TreeTypes treeTypes;

  factory TreeList.fromRawJson(String str) =>
      TreeList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TreeList.fromJson(Map<String, dynamic> json) => TreeList(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        treeTypeId: json["tree_type_id"] == null ? null : json["tree_type_id"],
        image: json["image"] == null ? '' : json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        treeTypes: json["tree_types"] == null
            ? null
            : TreeTypes.fromJson(json["tree_types"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "tree_type_id": treeTypeId == null ? null : treeTypeId,
        "image": image == null ? '' : image,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "tree_types": treeTypes == null ? null : treeTypes.toJson(),
      };
}
