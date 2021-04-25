// To parse this JSON data, do
//
//     final gardenHistoryActionResponse = gardenHistoryActionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/graden/action.dart';

class GardenHistoryActionResponse {
  GardenHistoryActionResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  GardenHistoryActionResponseData data;
  String message;

  factory GardenHistoryActionResponse.fromRawJson(String str) =>
      GardenHistoryActionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GardenHistoryActionResponse.fromJson(Map<String, dynamic> json) =>
      GardenHistoryActionResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : GardenHistoryActionResponseData.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}

class GardenHistoryActionResponseData {
  GardenHistoryActionResponseData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<HistoryActionModel> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory GardenHistoryActionResponseData.fromRawJson(String str) =>
      GardenHistoryActionResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GardenHistoryActionResponseData.fromJson(Map<String, dynamic> json) =>
      GardenHistoryActionResponseData(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<HistoryActionModel>.from(
                json["data"].map((x) => HistoryActionModel.fromJson(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class HistoryActionModel {
  HistoryActionModel({
    this.id,
    this.gardenId,
    this.typesActionId,
    this.detailType,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int gardenId;
  int typesActionId;
  DetailType detailType;
  String createdAt;
  String updatedAt;

  factory HistoryActionModel.fromRawJson(String str) =>
      HistoryActionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HistoryActionModel.fromJson(Map<String, dynamic> json) =>
      HistoryActionModel(
        id: json["id"] == null ? null : json["id"],
        gardenId: json["garden_id"] == null ? null : json["garden_id"],
        typesActionId:
            json["types_action_id"] == null ? null : json["types_action_id"],
        detailType:
            json["data"] == null ? null : DetailType.fromJson(json["data"]),
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "garden_id": gardenId == null ? null : gardenId,
        "types_action_id": typesActionId == null ? null : typesActionId,
        "data": detailType == null ? null : detailType.toJson(),
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}

class DetailType {
  DetailType({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.actions,
  });

  int id;
  String name;
  String image;
  dynamic createdAt;
  dynamic updatedAt;
  List<ActionModel> actions;

  factory DetailType.fromRawJson(String str) =>
      DetailType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailType.fromJson(Map<String, dynamic> json) => DetailType(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? '' : json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        actions: json["actions"] == null
            ? null
            : List<ActionModel>.from(
                json["actions"].map((x) => ActionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image": image == null ? '' : image,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "actions": actions == null
            ? null
            : List<dynamic>.from(actions.map((x) => x.toJson())),
      };
}
