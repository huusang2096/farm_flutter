// To parse this JSON data, do
//
//     final requestJoinProject = requestJoinProjectFromJson(jsonString);

import 'dart:convert';

class RequestJoinProject {
  RequestJoinProject({
    this.partner,
  });

  List<String> partner;

  factory RequestJoinProject.fromRawJson(String str) =>
      RequestJoinProject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestJoinProject.fromJson(Map<String, dynamic> json) =>
      RequestJoinProject(
        partner: json["partner"] == null
            ? null
            : List<String>.from(json["partner"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "partner":
            partner == null ? null : List<dynamic>.from(partner.map((x) => x)),
      };
}
