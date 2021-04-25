// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';

class LoginRequest {
    LoginRequest({
        this.phone,
        this.password,
    });

    String phone;
    String password;

    LoginRequest copyWith({
        String phone,
        String password,
    }) => 
        LoginRequest(
            phone: phone ?? this.phone,
            password: password ?? this.password,
        );

    factory LoginRequest.fromRawJson(String str) => LoginRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        phone: json["phone"] == null ? null : json["phone"],
        password: json["password"] == null ? null : json["password"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone == null ? null : phone,
        "password": password == null ? null : password,
    };
}
