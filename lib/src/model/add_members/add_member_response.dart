// To parse this JSON data, do
//
//     final addMemberResponse = addMemberResponseFromJson(jsonString);

import 'dart:convert';

class AddMemberResponse {
  AddMemberResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  Member data;
  String message;

  AddMemberResponse copyWith({
    bool error,
    Member data,
    String message,
  }) =>
      AddMemberResponse(
        error: error ?? this.error,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory AddMemberResponse.fromRawJson(String str) =>
      AddMemberResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddMemberResponse.fromJson(Map<String, dynamic> json) =>
      AddMemberResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null ? null : Member.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}

class Member {
  Member(
      {this.name,
      this.description,
      this.gardenId,
      this.image,
      this.relation,
      this.education,
      this.sex,
      this.dob,
      this.job,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.peopleId});

  String name;
  String description;
  String gardenId;
  String image;
  String relation;
  String education;
  String sex;
  DateTime dob;
  String job;
  String updatedAt;
  String createdAt;
  int id;
  int peopleId;

  Member copyWith({
    String name,
    String description,
    String gardenId,
    String image,
    String relation,
    String education,
    String sex,
    DateTime dob,
    String job,
    String updatedAt,
    String createdAt,
    int id,
    int peopleId,
  }) =>
      Member(
          name: name ?? this.name,
          description: description ?? this.description,
          gardenId: gardenId ?? this.gardenId,
          image: image ?? this.image,
          relation: relation ?? this.relation,
          education: education ?? this.education,
          sex: sex ?? this.sex,
          dob: dob ?? this.dob,
          job: job ?? this.job,
          updatedAt: updatedAt ?? this.updatedAt,
          createdAt: createdAt ?? this.createdAt,
          id: id ?? this.id,
          peopleId: peopleId ?? this.peopleId);

  factory Member.fromRawJson(String str) => Member.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        gardenId:
            json["garden_id"] == null ? null : json["garden_id"].toString(),
        image: json["image"] == null ? null : json["image"],
        relation: json["relation"] == null ? null : json["relation"],
        education: json["education"] == null ? null : json["education"],
        sex: json["sex"] == null ? null : json["sex"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        job: json["job"] == null ? null : json["job"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        id: json["id"] == null ? null : json["id"],
        peopleId:
            json["people_garden_id"] == null ? null : json["people_garden_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "garden_id": gardenId == null ? null : gardenId,
        "image": image == null ? null : image,
        "relation": relation == null ? null : relation,
        "education": education == null ? null : education,
        "sex": sex == null ? null : sex,
        "dob": dob == null
            ? null
            : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "job": job == null ? null : job,
        "updated_at": updatedAt == null ? null : updatedAt,
        "created_at": createdAt == null ? null : createdAt,
        "id": id == null ? null : id,
        "people_garden_id": peopleId == null ? null : peopleId,
      };
}
