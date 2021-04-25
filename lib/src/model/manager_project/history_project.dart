// To parse this JSON data, do
//
//     final historyTransactionProject = historyTransactionProjectFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/manager_project/mem_partner_project_response.dart';

class HistoryTransactionProject {
  HistoryTransactionProject({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<HistoryTransaction> data;
  String message;

  factory HistoryTransactionProject.fromRawJson(String str) =>
      HistoryTransactionProject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HistoryTransactionProject.fromJson(Map<String, dynamic> json) =>
      HistoryTransactionProject(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<HistoryTransaction>.from(
                json["data"].map((x) => HistoryTransaction.fromJson(x))),
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

class HistoryTransaction {
  HistoryTransaction(
      {this.id,
      this.dateSale,
      this.numberContract,
      this.amountSale,
      this.price,
      this.numberMove,
      this.bonus4C,
      this.typeGoods,
      this.typeSale,
      this.memberIdSale,
      this.memberIdBuy,
      this.projectId,
      this.totalBonus4C,
      this.totalMoney,
      this.status,
      this.reason,
      this.createdAt,
      this.updatedAt,
      this.transactionType,
      this.memberSale,
      this.memberBuy});

  int id;
  DateTime dateSale;
  String numberContract;
  String amountSale;
  String price;
  String numberMove;
  String bonus4C;
  String typeGoods;
  String typeSale;
  int memberIdSale;
  int memberIdBuy;
  int projectId;
  String totalBonus4C;
  String totalMoney;
  String status;
  dynamic reason;
  String createdAt;
  String updatedAt;
  String transactionType;
  MemberPartner memberSale;
  MemberPartner memberBuy;

  factory HistoryTransaction.fromRawJson(String str) =>
      HistoryTransaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HistoryTransaction.fromJson(Map<String, dynamic> json) =>
      HistoryTransaction(
        id: json["id"] == null ? null : json["id"],
        dateSale: json["date_sale"] == null
            ? null
            : DateTime.parse(json["date_sale"]),
        numberContract:
            json["number_contract"] == null ? null : json["number_contract"],
        amountSale: json["amount_sale"] == null ? null : json["amount_sale"],
        price: json["price"] == null ? '0' : json["price"],
        numberMove: json["number_move"] == null ? null : json["number_move"],
        bonus4C: json["bonus_4c"] == null ? null : json["bonus_4c"],
        typeGoods: json["type_goods"] == null ? null : json["type_goods"],
        typeSale: json["type_sale"] == null ? null : json["type_sale"],
        memberIdSale:
            json["member_id_sale"] == null ? null : json["member_id_sale"],
        memberIdBuy:
            json["member_id_buy"] == null ? null : json["member_id_buy"],
        projectId: json["project_id"] == null ? null : json["project_id"],
        totalBonus4C:
            json["total_bonus_4c"] == null ? null : json["total_bonus_4c"],
        totalMoney: json["total_money"] == null ? null : json["total_money"],
        status: json["status"] == null ? null : json["status"],
        reason: json["reason"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        transactionType:
            json["TransactionType"] == null ? null : json["TransactionType"],
        memberSale: json["member_sale"] == null
            ? null
            : MemberPartner.fromJson(json["member_sale"]),
        memberBuy: json["member_buy"] == null
            ? null
            : MemberPartner.fromJson(json["member_buy"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "date_sale": dateSale == null
            ? null
            : "${dateSale.year.toString().padLeft(4, '0')}-${dateSale.month.toString().padLeft(2, '0')}-${dateSale.day.toString().padLeft(2, '0')}",
        "number_contract": numberContract == null ? null : numberContract,
        "amount_sale": amountSale == null ? null : amountSale,
        "price": price == null ? '0' : price,
        "number_move": numberMove == null ? null : numberMove,
        "bonus_4c": bonus4C == null ? null : bonus4C,
        "type_goods": typeGoods == null ? null : typeGoods,
        "type_sale": typeSale == null ? null : typeSale,
        "member_id_sale": memberIdSale == null ? null : memberIdSale,
        "member_id_buy": memberIdBuy == null ? null : memberIdBuy,
        "project_id": projectId == null ? null : projectId,
        "total_bonus_4c": totalBonus4C == null ? null : totalBonus4C,
        "total_money": totalMoney == null ? null : totalMoney,
        "status": status == null ? null : status,
        "reason": reason,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "TransactionType": transactionType == null ? null : transactionType,
        "member_sale": memberSale == null ? null : memberSale.toJson(),
        "member_buy": memberBuy == null ? null : memberBuy.toJson(),
      };
}
