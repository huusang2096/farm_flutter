// To parse this JSON data, do
//
//     final forgotPasswordRequest = forgotPasswordRequestFromJson(jsonString);

import 'dart:convert';

class ForgotPasswordRequest {
  ForgotPasswordRequest({
    this.phone,
    this.verifyToken,
    this.password,
    this.passwordConfirmation,
  });

  String phone;
  String verifyToken;
  String password;
  String passwordConfirmation;

  ForgotPasswordRequest copyWith({
    String phone,
    String verifyToken,
    String password,
    String passwordConfirmation,
  }) =>
      ForgotPasswordRequest(
        phone: phone ?? this.phone,
        verifyToken: verifyToken ?? this.verifyToken,
        password: password ?? this.password,
        passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      );

  factory ForgotPasswordRequest.fromRawJson(String str) =>
      ForgotPasswordRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordRequest(
        phone: json["phone"] == null ? null : json["phone"],
        verifyToken: json["verify_token"] == null ? null : json["verify_token"],
        password: json["password"] == null ? null : json["password"],
        passwordConfirmation: json["password_confirmation"] == null
            ? null
            : json["password_confirmation"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone == null ? null : phone,
        "verify_token": verifyToken == null ? null : verifyToken,
        "password": password == null ? null : password,
        "password_confirmation":
            passwordConfirmation == null ? null : passwordConfirmation,
      };
}
