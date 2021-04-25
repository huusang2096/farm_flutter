import 'dart:convert';

import 'package:farmgate/src/model/graden/tree_list.dart';

class TreeTypes {
  TreeTypes(
      {this.id, this.name, this.createdAt, this.updatedAt, this.listTree});

  int id;
  String name;
  dynamic createdAt;
  dynamic updatedAt;
  List<TreeList> listTree;

  factory TreeTypes.fromRawJson(String str) =>
      TreeTypes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TreeTypes.fromJson(Map<String, dynamic> json) => TreeTypes(
      id: json["id"] == null ? null : json["id"],
      name: json["name"] == null ? null : json["name"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      listTree: []);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
