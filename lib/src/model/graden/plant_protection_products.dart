import 'dart:convert';

class ProtectionGarden {
  ProtectionGarden({
    this.id,
    this.name,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String description;
  String image;
  String createdAt;
  String updatedAt;

  factory ProtectionGarden.fromRawJson(String str) =>
      ProtectionGarden.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProtectionGarden.fromJson(Map<String, dynamic> json) =>
      ProtectionGarden(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null ? '' : json["image"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "image": image == null ? '' : image,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
