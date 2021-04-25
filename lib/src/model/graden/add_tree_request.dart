// To parse this JSON data, do
//
//     final addTreeRequest = addTreeRequestFromJson(jsonString);

import 'dart:convert';

class AddTreeRequest {
  AddTreeRequest({
    this.treeId,
    this.seeding,
    this.amount,
    this.year,
    this.plantingMethod,
    this.area,
    this.statusGarden,
    this.owner,
  });

  int treeId;
  String seeding;
  String amount;
  int year;
  String plantingMethod;
  String area;
  String statusGarden;
  String owner;

  factory AddTreeRequest.fromRawJson(String str) =>
      AddTreeRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddTreeRequest.fromJson(Map<String, dynamic> json) => AddTreeRequest(
        treeId: json["tree_id"] == null ? null : json["tree_id"],
        seeding: json["seeding"] == null ? null : json["seeding"],
        amount: json["amount"] == null ? null : json["amount"],
        year: json["year"] == null ? null : json["year"],
        plantingMethod:
            json["planting_method"] == null ? null : json["planting_method"],
        area: json["area"] == null ? null : json["area"],
        statusGarden:
            json["status_garden"] == null ? null : json["status_garden"],
        owner: json["owner"] == null ? null : json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "tree_id": treeId == null ? null : treeId,
        "seeding": seeding == null ? null : seeding,
        "amount": amount == null ? null : amount,
        "year": year == null ? null : year,
        "planting_method": plantingMethod == null ? null : plantingMethod,
        "area": area == null ? null : area,
        "status_garden": statusGarden == null ? null : statusGarden,
        "owner": owner == null ? null : owner,
      };
}
