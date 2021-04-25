// To parse this JSON data, do
//
//     final actionResponse = actionResponseFromJson(jsonString);

import 'dart:convert';

class ActionResponse {
  ActionResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<ActionModel> data;
  dynamic message;

  factory ActionResponse.fromRawJson(String str) =>
      ActionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActionResponse.fromJson(Map<String, dynamic> json) => ActionResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<ActionModel>.from(
                json["data"].map((x) => ActionModel.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class ActionModel {
  ActionModel({
    this.id,
    this.typesActionId,
    this.inputType,
    this.unitName,
    this.unitPrice,
    this.inputData,
    this.isCheck,
    this.inputProductId,
    this.createdAt,
    this.updatedAt,
    this.inputProduct,
  });

  int id;
  int typesActionId;
  String inputType;
  String unitName;
  String unitPrice;
  String inputData;
  int isCheck;
  List<String> inputProductId;
  dynamic createdAt;
  dynamic updatedAt;
  List<InputProduct> inputProduct;

  factory ActionModel.fromRawJson(String str) =>
      ActionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActionModel.fromJson(Map<String, dynamic> json) => ActionModel(
        id: json["id"] == null ? null : json["id"],
        typesActionId:
            json["types_action_id"] == null ? null : json["types_action_id"],
        inputType: json["input_type"] == null ? null : json["input_type"],
        unitName: json["unit_name"] == null ? null : json["unit_name"],
        unitPrice: json["unit_price"] == null ? "" : json["unit_price"],
        inputData: json["input_data"] == null ? null : json["input_data"],
        isCheck: json["isCheck"] == null ? null : json["isCheck"],
        inputProductId: json["input_product_id"] == null
            ? null
            : List<String>.from(json["input_product_id"].map((x) => x)),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        inputProduct: json["input_product"] == null
            ? null
            : List<InputProduct>.from(
                json["input_product"].map((x) => InputProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "types_action_id": typesActionId == null ? null : typesActionId,
        "input_type": inputType == null ? null : inputType,
        "unit_name": unitName == null ? null : unitName,
        "unit_price": unitPrice == null ? "" : unitPrice,
        "input_data": inputData == null ? null : inputData,
        "isCheck": isCheck == null ? null : isCheck,
        "input_product_id": inputProductId == null
            ? null
            : List<dynamic>.from(inputProductId.map((x) => x)),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "input_product": inputProduct == null
            ? null
            : List<dynamic>.from(inputProduct.map((x) => x.toJson())),
      };
}

class InputProduct {
  InputProduct({
    this.id,
    this.name,
    this.unitPrice,
    this.price,
    this.isSelect,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String unitPrice;
  String price;
  int isSelect;
  dynamic createdAt;
  dynamic updatedAt;

  factory InputProduct.fromRawJson(String str) =>
      InputProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InputProduct.fromJson(Map<String, dynamic> json) => InputProduct(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        unitPrice: json["unit_price"] == null ? null : json["unit_price"],
        price: json["price"] == null ? null : json["price"],
        isSelect: json["is_select"] == null ? null : json["is_select"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "unit_price": unitPrice == null ? null : unitPrice,
        "price": price == null ? null : price,
        "is_select": isSelect == null ? null : isSelect,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
