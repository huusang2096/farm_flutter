import 'dart:convert';

import 'package:farmgate/src/model/news/author.dart';
import 'package:farmgate/src/model/news/category.dart';

class News {
  News({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image,
    this.categories,
    this.tags,
    this.author,
    this.formatType,
    this.videoLink,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String slug;
  String description;
  String image;
  List<Category> categories;
  List<Category> tags;
  Author author;
  String formatType;
  String videoLink;
  String createdAt;
  String updatedAt;

  factory News.fromRawJson(String str) => News.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null ? '' : json["image"],
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        tags: json["tags"] == null
            ? null
            : List<Category>.from(
                json["tags"].map((x) => Category.fromJson(x))),
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        formatType: json["format_type"] == null ? null : json["format_type"],
        videoLink: json["video_link"] == null ? null : json["video_link"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "description": description == null ? null : description,
        "image": image == null ? '' : image,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x.toJson())),
        "tags": tags == null
            ? null
            : List<dynamic>.from(tags.map((x) => x.toJson())),
        "author": author == null ? null : author.toJson(),
        "format_type": formatType == null ? null : formatType,
        "video_link": videoLink == null ? null : videoLink,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
