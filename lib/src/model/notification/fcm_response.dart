// To parse this JSON data, do
//
//     final fcmResponse = fcmResponseFromJson(jsonString);

import 'dart:convert';

class FcmResponse {
  FcmResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory FcmResponse.fromRawJson(String str) => FcmResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcmResponse.fromJson(Map<String, dynamic> json) => FcmResponse(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.fcmToken,
    this.deviceId,
    this.platform,
  });

  String fcmToken;
  String deviceId;
  String platform;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fcmToken: json["fcm_token"] == null ? null : json["fcm_token"],
    deviceId: json["device_id"] == null ? null : json["device_id"],
    platform: json["platform"] == null ? null : json["platform"],
  );

  Map<String, dynamic> toJson() => {
    "fcm_token": fcmToken == null ? null : fcmToken,
    "device_id": deviceId == null ? null : deviceId,
    "platform": platform == null ? null : platform,
  };
}
