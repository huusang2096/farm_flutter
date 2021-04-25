// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromJson(jsonString);

import 'dart:convert';

class RegisterRequest {
  RegisterRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.password,
    this.passwordConfirmation,
    this.verifyToken,
    this.countryCode,
    this.deviceId,
    this.deviceToken,
    this.platform,
    this.fcmToken,
  });

  String firstName;
  String lastName;
  String email;
  String phone;
  String password;
  String passwordConfirmation;
  String verifyToken;
  String countryCode;
  String deviceId;
  String deviceToken;
  String platform;
  String fcmToken;

  RegisterRequest copyWith({
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
    String passwordConfirmation,
    String verifyToken,
    String countryCode,
    String deviceId,
    String deviceToken,
    String platform,
    String fcmToken,
  }) =>
      RegisterRequest(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
        verifyToken: verifyToken ?? this.verifyToken,
        countryCode: countryCode ?? this.countryCode,
        deviceId: deviceId ?? this.deviceId,
        deviceToken: deviceToken ?? this.deviceToken,
        platform: platform ?? this.platform,
        fcmToken: fcmToken ?? this.fcmToken,
      );

  factory RegisterRequest.fromRawJson(String str) =>
      RegisterRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        password: json["password"] == null ? null : json["password"],
        passwordConfirmation: json["password_confirmation"] == null
            ? null
            : json["password_confirmation"],
        verifyToken: json["verify_token"] == null ? null : json["verify_token"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        deviceId: json["device_id"] == null ? null : json["device_id"],
        deviceToken: json["device_token"] == null ? null : json["device_token"],
        platform: json["platform"] == null ? null : json["platform"],
        fcmToken: json["fcm_token"] == null ? null : json["fcm_token"],
      );

  Map<String, dynamic> toJson() {
    final data = {
      "first_name": firstName == null ? null : firstName,
      "last_name": lastName == null ? null : lastName,
      "email": email == null ? null : email,
      "phone": phone == null ? null : phone,
      "password": password == null ? null : password,
      "password_confirmation":
          passwordConfirmation == null ? null : passwordConfirmation,
      "verify_token": verifyToken == null ? null : verifyToken,
      "country_code": countryCode == null ? null : countryCode,
      "device_id": deviceId == null ? null : deviceId,
      "device_token": deviceToken == null ? null : deviceToken,
      "platform": platform == null ? null : platform,
      "fcm_token": fcmToken == null ? null : fcmToken,
    };
    if (email == null || email.isEmpty) {
      data.remove('email');
    }

    return data;
  }
}
