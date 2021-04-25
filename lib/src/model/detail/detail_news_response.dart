// To parse this JSON data, do
//
//     final detailNewsResponse = detailNewsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/news/category.dart';

class DetailNewsResponse {
  DetailNewsResponse({
    this.data,
    this.error,
    this.message,
  });

  Detail data;
  bool error;
  dynamic message;

  factory DetailNewsResponse.fromRawJson(String str) =>
      DetailNewsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailNewsResponse.fromJson(Map<String, dynamic> json) =>
      DetailNewsResponse(
        data: json["data"] == null ? null : Detail.fromJson(json["data"]),
        error: json["error"] == null ? null : json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "error": error == null ? null : error,
        "message": message,
      };
}

class Detail {
  Detail(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.content,
      this.image,
      this.categories,
      this.tags,
      this.formatType,
      this.videoLink,
      this.createdAt,
      this.updatedAt,
      this.resource});

  int id;
  String name;
  String slug;
  String description;
  String content;
  String image;
  List<Category> categories;
  List<dynamic> tags;
  dynamic formatType;
  dynamic videoLink;
  String createdAt;
  String updatedAt;
  String resource;

  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        description: json["description"] == null ? null : json["description"],
        content: json["content"] == null ? null : json["content"],
        image: json["image"] == null ? '' : json["image"],
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        tags: json["tags"] == null
            ? null
            : List<dynamic>.from(json["tags"].map((x) => x)),
        formatType: json["format_type"],
        videoLink: json["video_link"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        resource: json["resource"] == null
            ? "https://dev.farmgate.di4l.vn/tin-tuc/diem-tin-the-thao-sang-26-2-messi-va-ronaldo-deu-vang-mat-trong-top-10-dat-gia-nhat-the-gioi"
            : json["resource"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "description": description == null ? null : description,
        "content": content == null ? null : content,
        "image": image == null ? '' : image,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x.toJson())),
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "format_type": formatType,
        "video_link": videoLink,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "resource": resource == null
            ? "https://dev.farmgate.di4l.vn/tin-tuc/diem-tin-the-thao-sang-26-2-messi-va-ronaldo-deu-vang-mat-trong-top-10-dat-gia-nhat-the-gioi"
            : resource,
      };
}
