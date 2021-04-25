// To parse this JSON data, do
//
//     final profileRequestImg = profileRequestImgFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

class ProfileRequestImg {
  ProfileRequestImg({
    this.image,
  });

  File image;

  factory ProfileRequestImg.fromRawJson(String str) =>
      ProfileRequestImg.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileRequestImg.fromJson(Map<String, dynamic> json) =>
      ProfileRequestImg(
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image,
      };
}
