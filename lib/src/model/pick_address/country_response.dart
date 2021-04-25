// To parse this JSON data, do
//
//     final countryResponse = countryResponseFromJson(jsonString);

import 'dart:convert';

class CountryResponse {
  CountryResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<Country> data;
  String message;

  factory CountryResponse.fromRawJson(String str) =>
      CountryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryResponse.fromJson(Map<String, dynamic> json) =>
      CountryResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<Country>.from(json["data"].map((x) => Country.fromJson(x))),
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

class Country {
  Country({
    this.id,
    this.countryKey,
    this.defaultName,
    this.createdAt,
    this.updatedAt,
    this.locationActive,
    this.bookingFee,
  });

  int id;
  String countryKey;
  String defaultName;
  int createdAt;
  int updatedAt;
  int locationActive;
  int bookingFee;

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"] == null ? null : json["id"],
        countryKey: json["country_key"] == null ? null : json["country_key"],
        defaultName: json["default_name"] == null ? null : json["default_name"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        locationActive:
            json["location_active"] == null ? null : json["location_active"],
        bookingFee: json["booking_fee"] == null ? null : json["booking_fee"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "country_key": countryKey == null ? null : countryKey,
        "default_name": defaultName == null ? null : defaultName,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "location_active": locationActive == null ? null : locationActive,
        "booking_fee": bookingFee == null ? null : bookingFee,
      };
}
