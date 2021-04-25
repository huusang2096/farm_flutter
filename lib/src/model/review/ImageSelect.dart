// To parse this JSON data, do
//
//     final reviewResponse = reviewResponseFromJson(jsonString);

import 'dart:io';

class ImageSelect {
  ImageSelect({
    this.imageUrl,
    this.url,
    this.id,
  });

  String imageUrl;
  File url;
  String id;
}
