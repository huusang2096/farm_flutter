import 'dart:convert';

class NotificationModel {
  NotificationModel({
    this.title,
    this.subTitle,
    this.body,
    this.orderId,
    this.type,
  });

  String title;
  String subTitle;
  String body;
  String orderId;
  String type;

  factory NotificationModel.fromRawJson(String str) =>
      NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        title: json["title"] == null ? null : json["title"],
        subTitle: json["sub_title"] == null ? null : json["sub_title"],
        body: json["body"] == null ? null : json["body"],
        orderId: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "sub_title": subTitle == null ? null : subTitle,
        "body": body == null ? null : body,
        "id": orderId == null ? null : orderId,
        "type": type == null ? null : type,
      };
}
