// To parse this JSON data, do
//
//     final historyTransactionDetalResponse = historyTransactionDetalResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmgate/src/model/manager_project/history_project.dart';

class HistoryTransactionDetalResponse {
  HistoryTransactionDetalResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  HistoryTransaction data;
  String message;

  factory HistoryTransactionDetalResponse.fromRawJson(String str) =>
      HistoryTransactionDetalResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HistoryTransactionDetalResponse.fromJson(Map<String, dynamic> json) =>
      HistoryTransactionDetalResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : HistoryTransaction.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}
