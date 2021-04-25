// To parse this JSON data, do
//
//     final fcmRequest = fcmRequestFromJson(jsonString);

import 'dart:convert';

class FcmRequest {
  FcmRequest({
    this.fcmToken,
    this.deviceId,
    this.platform,
  });

  String fcmToken;
  String deviceId;
  String platform;

  factory FcmRequest.fromRawJson(String str) =>
      FcmRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcmRequest.fromJson(Map<String, dynamic> json) => FcmRequest(
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
