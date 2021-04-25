// To parse this JSON data, do
//
//     final postCommentResponse = postCommentResponseFromJson(jsonString);

import 'dart:convert';

class PostCommentResponse {
  PostCommentResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  Data data;
  dynamic message;

  factory PostCommentResponse.fromRawJson(String str) =>
      PostCommentResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostCommentResponse.fromJson(Map<String, dynamic> json) =>
      PostCommentResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null ? null : data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.status,
    this.appKey,
    this.url,
  });

  String status;
  String appKey;
  String url;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        appKey: json["app-key"] == null ? null : json["app-key"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "app-key": appKey == null ? null : appKey,
        "url": url == null ? null : url,
      };
}
