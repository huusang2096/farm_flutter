// To parse this JSON data, do
//
//     final myReportResponse = myReportResponseFromJson(jsonString);

import 'dart:convert';

class MyReportResponse {
  MyReportResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  MyReport data;
  String message;

  factory MyReportResponse.fromRawJson(String str) =>
      MyReportResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyReportResponse.fromJson(Map<String, dynamic> json) =>
      MyReportResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null ? null : MyReport.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}

class MyReport {
  MyReport({
    this.totalPosts,
    this.latestManureDate,
    this.latestSprayDate,
  });

  int totalPosts;
  dynamic latestManureDate;
  dynamic latestSprayDate;

  factory MyReport.fromRawJson(String str) =>
      MyReport.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyReport.fromJson(Map<String, dynamic> json) => MyReport(
        totalPosts: json["total_posts"] == null ? null : json["total_posts"],
        latestManureDate: json["latest_manure_date"],
        latestSprayDate: json["latest_spray_date"],
      );

  Map<String, dynamic> toJson() => {
        "total_posts": totalPosts == null ? null : totalPosts,
        "latest_manure_date": latestManureDate,
        "latest_spray_date": latestSprayDate,
      };
}
