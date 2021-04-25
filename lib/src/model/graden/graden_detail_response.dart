// To parse this JSON data, do
//
//     final gardenDetailResponse = gardenDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/add_members/add_member_response.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:farmgate/src/model/graden/plant_protection_products.dart';
import 'package:farmgate/src/model/graden/tree_list.dart';
import 'package:farmgate/src/model/graden/tree_types.dart';

import 'garden_history_action_response.dart';

class GardenDetailResponse {
  GardenDetailResponse({
    this.error,
    this.gardenDetail,
    this.message,
  });

  bool error;
  GardenDetail gardenDetail;
  dynamic message;

  factory GardenDetailResponse.fromRawJson(String str) =>
      GardenDetailResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GardenDetailResponse.fromJson(Map<String, dynamic> json) =>
      GardenDetailResponse(
        error: json["error"] == null ? null : json["error"],
        gardenDetail:
            json["data"] == null ? null : GardenDetail.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": gardenDetail == null ? null : gardenDetail.toJson(),
        "message": message,
      };
}

class GardenDetail {
  GardenDetail(
      {this.id,
      this.userId,
      this.name,
      this.description,
      this.treeList,
      this.districtsId,
      this.cityId,
      this.address,
      this.north,
      this.south,
      this.east,
      this.west,
      this.createdAt,
      this.updatedAt,
      this.memberGarden,
      this.gardenPlantProtectionProducts,
      this.image});

  int id;
  int userId;
  String name;
  String description;
  List<TreeListGarden> treeList;
  List<String> image;
  dynamic districtsId;
  dynamic cityId;
  String address;
  dynamic north;
  dynamic south;
  dynamic east;
  dynamic west;
  String createdAt;
  String updatedAt;
  List<Member> memberGarden;
  List<GardenPlantProtectionProduct> gardenPlantProtectionProducts;

  factory GardenDetail.fromRawJson(String str) =>
      GardenDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GardenDetail.fromJson(Map<String, dynamic> json) => GardenDetail(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        treeList: json["tree_list"] == null
            ? []
            : List<TreeListGarden>.from(
                json["tree_list"].map((x) => TreeListGarden.fromJson(x))),
        districtsId: json["districts_id"],
        cityId: json["city_id"],
        address: json["address"] == null ? null : json["address"],
        north: json["north"],
        south: json["south"],
        east: json["east"],
        west: json["west"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        memberGarden: json["member_garden"] == null
            ? []
            : List<Member>.from(
                json["member_garden"].map((x) => Member.fromJson(x))),
        gardenPlantProtectionProducts:
            json["garden_plant_protection_products"] == null
                ? null
                : List<GardenPlantProtectionProduct>.from(
                    json["garden_plant_protection_products"]
                        .map((x) => GardenPlantProtectionProduct.fromJson(x))),
        image: json["image"] == null
            ? null
            : List<String>.from(json["image"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "tree_list": treeList == null
            ? []
            : List<dynamic>.from(treeList.map((x) => x.toJson())),
        "districts_id": districtsId,
        "city_id": cityId,
        "address": address == null ? null : address,
        "north": north,
        "south": south,
        "east": east,
        "west": west,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "member_garden": memberGarden == null
            ? null
            : List<dynamic>.from(memberGarden.map((x) => x.toJson())),
        "garden_plant_protection_products":
            gardenPlantProtectionProducts == null
                ? null
                : List<dynamic>.from(
                    gardenPlantProtectionProducts.map((x) => x.toJson())),
        "image": image == null ? null : List<dynamic>.from(image.map((x) => x)),
      };
}

class GardenPlantProtectionProduct {
  GardenPlantProtectionProduct({
    this.id,
    this.gardenId,
    this.typesActionId,
    this.data,
    this.createdAt,
    this.updatedAt,
    this.plantProtectionProduct,
  });

  int id;
  int gardenId;
  int typesActionId;
  GardenPlantProtectionProductData data;
  String createdAt;
  String updatedAt;
  ProtectionGarden plantProtectionProduct;

  factory GardenPlantProtectionProduct.fromRawJson(String str) =>
      GardenPlantProtectionProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GardenPlantProtectionProduct.fromJson(Map<String, dynamic> json) =>
      GardenPlantProtectionProduct(
        id: json["id"] == null ? null : json["id"],
        gardenId: json["garden_id"] == null ? null : json["garden_id"],
        typesActionId:
            json["types_action_id"] == null ? null : json["types_action_id"],
        data: json["data"] == null
            ? null
            : GardenPlantProtectionProductData.fromJson(json["data"]),
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        plantProtectionProduct: json["plant_protection_product"] == null
            ? null
            : ProtectionGarden.fromJson(json["plant_protection_product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "garden_id": gardenId == null ? null : gardenId,
        "types_action_id": typesActionId == null ? null : typesActionId,
        "data": data == null ? null : data.toJson(),
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "plant_protection_product": plantProtectionProduct == null
            ? null
            : plantProtectionProduct.toJson(),
      };
}

class GardenPlantProtectionProductData {
  GardenPlantProtectionProductData({
    this.id,
    this.name,
    this.image,
    this.plantProtectionProductId,
    this.createdAt,
    this.updatedAt,
    this.actions,
  });

  int id;
  String name;
  String image;
  int plantProtectionProductId;
  dynamic createdAt;
  dynamic updatedAt;
  List<ActionModel> actions;

  factory GardenPlantProtectionProductData.fromRawJson(String str) =>
      GardenPlantProtectionProductData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GardenPlantProtectionProductData.fromJson(
          Map<String, dynamic> json) =>
      GardenPlantProtectionProductData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? '' : json["image"],
        plantProtectionProductId: json["plant_protection_product_id"] == null
            ? null
            : json["plant_protection_product_id"],
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
        "image": image == null ? null : image,
        "plant_protection_product_id":
            plantProtectionProductId == null ? null : plantProtectionProductId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "actions": actions == null
            ? null
            : List<dynamic>.from(actions.map((x) => x.toJson())),
      };
}

class TreeListGarden {
  TreeListGarden({
    this.id,
    this.gardenId,
    this.treeId,
    this.seedling,
    this.amount,
    this.year,
    this.plantingMethod,
    this.area,
    this.statusGarden,
    this.owner,
    this.createdAt,
    this.updatedAt,
    this.tree,
  });

  int id;
  int gardenId;
  int treeId;
  dynamic seedling;
  String amount;
  String year;
  String plantingMethod;
  String area;
  String statusGarden;
  String owner;
  String createdAt;
  String updatedAt;
  Tree tree;

  factory TreeListGarden.fromRawJson(String str) =>
      TreeListGarden.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TreeListGarden.fromJson(Map<String, dynamic> json) => TreeListGarden(
        id: json["id"] == null ? null : json["id"],
        gardenId: json["garden_id"] == null ? null : json["garden_id"],
        treeId: json["tree_id"] == null ? null : json["tree_id"],
        seedling: json["seedling"],
        amount: json["amount"] == null ? null : json["amount"],
        year: json["year"] == null ? null : json["year"],
        plantingMethod:
            json["planting_method"] == null ? null : json["planting_method"],
        area: json["area"] == null ? null : json["area"],
        statusGarden:
            json["status_garden"] == null ? null : json["status_garden"],
        owner: json["owner"] == null ? null : json["owner"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        tree: json["tree"] == null ? null : Tree.fromJson(json["tree"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "garden_id": gardenId == null ? null : gardenId,
        "tree_id": treeId == null ? null : treeId,
        "seedling": seedling,
        "amount": amount == null ? null : amount,
        "year": year == null ? null : year,
        "planting_method": plantingMethod == null ? null : plantingMethod,
        "area": area == null ? null : area,
        "status_garden": statusGarden == null ? null : statusGarden,
        "owner": owner == null ? null : owner,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "tree": tree == null ? null : tree.toJson(),
      };
}

class Tree {
  Tree({
    this.id,
    this.name,
    this.treeTypeId,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.treeTypes,
  });

  int id;
  String name;
  String treeTypeId;
  String image;
  String createdAt;
  String updatedAt;
  String status;
  TreeTypes treeTypes;

  factory Tree.fromRawJson(String str) => Tree.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tree.fromJson(Map<String, dynamic> json) => Tree(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        treeTypeId: json["tree_type_id"] == null ? null : json["tree_type_id"],
        image: json["image"] == null ? null : json["image"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        status: json["status"] == null ? null : json["status"],
        treeTypes: json["tree_types"] == null
            ? null
            : TreeTypes.fromJson(json["tree_types"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "tree_type_id": treeTypeId == null ? null : treeTypeId,
        "image": image == null ? null : image,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "status": status == null ? null : status,
        "tree_types": treeTypes == null ? null : treeTypes.toJson(),
      };
}
