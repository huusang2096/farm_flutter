import 'dart:convert';

import 'package:farmgate/src/model/news/news_model.dart';

class Category {
  Category(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.listNews,
      this.nextPage});

  int id;
  String name;
  String slug;
  String description;
  List<News> listNews = [];
  int nextPage;

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json["id"] == null ? null : json["id"],
      name: json["name"] == null ? null : json["name"],
      slug: json["slug"] == null ? null : json["slug"],
      description: json["description"] == null ? null : json["description"],
      listNews: []);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "description": description == null ? null : description,
      };
}
