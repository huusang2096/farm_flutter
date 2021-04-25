// To parse this JSON data, do
//
//     final informationResponse = informationResponseFromJson(jsonString);

import 'dart:convert';

class InformationResponse {
  InformationResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<Rule> data;
  String message;

  factory InformationResponse.fromRawJson(String str) => InformationResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InformationResponse.fromJson(Map<String, dynamic> json) => InformationResponse(
    error: json["error"] == null ? null : json["error"],
    data: json["data"] == null ? null : List<Rule>.from(json["data"].map((x) => Rule.fromJson(x))),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message == null ? null : message,
  };
}

class Rule {
  Rule({
    this.id,
    this.name,
    this.content,
    this.status,
    this.userId,
    this.image,
    this.template,
    this.isFeatured,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String content;
  String status;
  int userId;
  dynamic image;
  String template;
  int isFeatured;
  String description;
  String createdAt;
  String updatedAt;

  factory Rule.fromRawJson(String str) => Rule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rule.fromJson(Map<String, dynamic> json) => Rule(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    content: json["content"] == null ? null : json["content"],
    status: json["status"] == null ? null : json["status"],
    userId: json["user_id"] == null ? null : json["user_id"],
    image: json["image"],
    template: json["template"] == null ? null : json["template"],
    isFeatured: json["is_featured"] == null ? null : json["is_featured"],
    description: json["description"] == null ? null : json["description"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "content": content == null ? null : content,
    "status": status == null ? null : status,
    "user_id": userId == null ? null : userId,
    "image": image,
    "template": template == null ? null : template,
    "is_featured": isFeatured == null ? null : isFeatured,
    "description": description == null ? null : description,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
