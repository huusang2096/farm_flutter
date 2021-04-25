// To parse this JSON data, do
//
//     final createTransactionRequest = createTransactionRequestFromJson(jsonString);

import 'dart:convert';

class CreateTransactionRequest {
  CreateTransactionRequest({
    this.numOfContract,
    this.quantity,
    this.price,
    this.tripNumber,
    this.reward4C,
    this.createAt,
    this.typeOfProduct,
    this.methodOfTransaction,
    this.totalReward4C,
    this.totalPrice,
    this.total,
    this.idSeller,
  });

  String numOfContract;
  String quantity;
  String price;
  String tripNumber;
  String reward4C;
  String createAt;
  String typeOfProduct;
  String methodOfTransaction;
  double totalReward4C;
  double totalPrice;
  double total;
  Seller idSeller;

  factory CreateTransactionRequest.fromRawJson(String str) =>
      CreateTransactionRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateTransactionRequest.fromJson(Map<String, dynamic> json) =>
      CreateTransactionRequest(
        numOfContract:
            json["num_of_contract"] == null ? null : json["num_of_contract"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        price: json["price"] == null ? null : json["price"],
        tripNumber: json["trip_number"] == null ? null : json["trip_number"],
        reward4C: json["reward4c"] == null ? null : json["reward4c"],
        createAt: json["create_at"] == null ? null : json["create_at"],
        typeOfProduct:
            json["type_of_product"] == null ? null : json["type_of_product"],
        methodOfTransaction: json["method_of_transaction"] == null
            ? null
            : json["method_of_transaction"],
        totalReward4C: json["total_reward4c"] == null
            ? null
            : json["total_reward4c"].toDouble(),
        totalPrice:
            json["total_price"] == null ? null : json["total_price"].toDouble(),
        total: json["total"] == null ? null : json["total"].toDouble(),
        idSeller: json["id_seller"] == null
            ? null
            : Seller.fromJson(json["id_seller"]),
      );

  Map<String, dynamic> toJson() => {
        "num_of_contract": numOfContract == null ? null : numOfContract,
        "quantity": quantity == null ? null : quantity,
        "price": price == null ? null : price,
        "trip_number": tripNumber == null ? null : tripNumber,
        "reward4c": reward4C == null ? null : reward4C,
        "create_at": createAt == null ? null : createAt,
        "type_of_product": typeOfProduct == null ? null : typeOfProduct,
        "method_of_transaction":
            methodOfTransaction == null ? null : methodOfTransaction,
        "total_reward4c": totalReward4C == null ? null : totalReward4C,
        "total_price": totalPrice == null ? null : totalPrice,
        "total": total == null ? null : total,
        "id_seller": idSeller == null ? null : idSeller.toJson(),
      };
}

class Seller {
  Seller({
    this.avatar,
    this.fullName,
    this.regency,
  });

  String avatar;
  String fullName;
  String regency;

  factory Seller.fromRawJson(String str) => Seller.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        avatar: json["avatar"] == null ? null : json["avatar"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        regency: json["regency"] == null ? null : json["regency"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar == null ? null : avatar,
        "full_name": fullName == null ? null : fullName,
        "regency": regency == null ? null : regency,
      };
}
