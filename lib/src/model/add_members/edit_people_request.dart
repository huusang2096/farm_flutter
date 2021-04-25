// To parse this JSON data, do
//
//     final editPeopleRequest = editPeopleRequestFromJson(jsonString);

import 'dart:convert';

class EditPeopleRequest {
    EditPeopleRequest({
        this.peopleGardenId,
        this.name,
        this.description,
    });

    int peopleGardenId;
    String name;
    String description;

    factory EditPeopleRequest.fromRawJson(String str) => EditPeopleRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EditPeopleRequest.fromJson(Map<String, dynamic> json) => EditPeopleRequest(
        peopleGardenId: json["people_garden_id"] == null ? null : json["people_garden_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
    );

    Map<String, dynamic> toJson() => {
        "people_garden_id": peopleGardenId == null ? null : peopleGardenId,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
    };
}
