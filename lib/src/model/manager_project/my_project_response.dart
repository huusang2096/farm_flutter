// To parse this JSON data, do
//
//     final myProjectResponse = myProjectResponseFromJson(jsonString);

import 'dart:convert';

class MyProjectResponse {
  MyProjectResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<MyProject> data;
  String message;

  factory MyProjectResponse.fromRawJson(String str) =>
      MyProjectResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyProjectResponse.fromJson(Map<String, dynamic> json) =>
      MyProjectResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<MyProject>.from(
                json["data"].map((x) => MyProject.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message == null ? null : message,
      };
}

class MyProject {
  MyProject({
    this.id,
    this.memberId,
    this.projectId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.project,
    this.reasonCancel,
  });

  int id;
  String memberId;
  String projectId;
  String status;
  String createdAt;
  String updatedAt;
  Project project;
  String reasonCancel;

  factory MyProject.fromRawJson(String str) =>
      MyProject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyProject.fromJson(Map<String, dynamic> json) => MyProject(
        id: json["id"] == null ? null : json["id"],
        memberId: json["member_id"] == null ? null : json["member_id"],
        projectId: json["project_id"] == null ? null : json["project_id"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        project:
            json["project"] == null ? null : Project.fromJson(json["project"]),
        reasonCancel:
            json["reason_cancel"] == null ? null : json["reason_cancel"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "member_id": memberId == null ? null : memberId,
        "project_id": projectId == null ? null : projectId,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "project": project == null ? null : project.toJson(),
        "reason_cancel": reasonCancel == null ? null : reasonCancel
      };
}

class Project {
  Project({
    this.id,
    this.name,
    this.description,
    this.createdAtProject,
    this.address,
    this.listMember,
    this.listTransaction,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String description;
  DateTime createdAtProject;
  String address;
  dynamic listMember;
  dynamic listTransaction;
  String status;
  String createdAt;
  String updatedAt;

  factory Project.fromRawJson(String str) => Project.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        createdAtProject: json["created_at_project"] == null
            ? null
            : DateTime.parse(json["created_at_project"]),
        address: json["address"] == null ? null : json["address"],
        listMember: json["list_member"],
        listTransaction: json["list_transaction"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "created_at_project": createdAtProject == null
            ? null
            : "${createdAtProject.year.toString().padLeft(4, '0')}-${createdAtProject.month.toString().padLeft(2, '0')}-${createdAtProject.day.toString().padLeft(2, '0')}",
        "address": address == null ? null : address,
        "list_member": listMember,
        "list_transaction": listTransaction,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
