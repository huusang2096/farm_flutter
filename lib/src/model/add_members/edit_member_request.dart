// To parse this JSON data, do
//
//     final editMemberRequest = editMemberRequestFromJson(jsonString);

import 'dart:convert';

class EditMemberRequest {
    EditMemberRequest({
        this.membersGardenId,
        this.name,
        this.description,
    });

    int membersGardenId;
    String name;
    String description;

    factory EditMemberRequest.fromRawJson(String str) => EditMemberRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EditMemberRequest.fromJson(Map<String, dynamic> json) => EditMemberRequest(
        membersGardenId: json["members_garden_id"] == null ? null : json["members_garden_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
    );

    Map<String, dynamic> toJson() => {
        "members_garden_id": membersGardenId == null ? null : membersGardenId,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
    };
}
