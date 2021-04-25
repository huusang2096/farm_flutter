// To parse this JSON data, do
//
//     final addMemberRequest = addMemberRequestFromJson(jsonString);

import 'dart:convert';

class AddMemberRequest {
  AddMemberRequest({
    this.name,
    this.description,
    this.relation,
    this.education,
    this.sex,
    this.dob,
    this.job,
  });

  String name;
  String description;
  String relation;
  String education;
  String sex;
  String dob;
  String job;

  AddMemberRequest copyWith({
    String name,
    String description,
    String relation,
    String education,
    String sex,
    String dob,
    String job,
  }) =>
      AddMemberRequest(
        name: name ?? this.name,
        description: description ?? this.description,
        relation: relation ?? this.relation,
        education: education ?? this.education,
        sex: sex ?? this.sex,
        dob: dob ?? this.dob,
        job: job ?? this.job,
      );

  factory AddMemberRequest.fromRawJson(String str) =>
      AddMemberRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddMemberRequest.fromJson(Map<String, dynamic> json) =>
      AddMemberRequest(
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        relation: json["relation"] == null ? null : json["relation"],
        education: json["education"] == null ? null : json["education"],
        sex: json["sex"] == null ? null : json["sex"],
        dob: json["dob"] == null ? null : json["dob"],
        job: json["job"] == null ? null : json["job"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "relation": relation == null ? null : relation,
        "education": education == null ? null : education,
        "sex": sex == null ? null : sex,
        "dob": dob == null ? null : dob,
        "job": job == null ? null : job,
      };
}
