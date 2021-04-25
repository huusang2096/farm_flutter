// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

class LoginResponse {
    LoginResponse({
        this.error,
        this.data,
        this.message,
    });

    bool error;
    Data data;
    dynamic message;

    LoginResponse copyWith({
        bool error,
        Data data,
        dynamic message,
    }) => 
        LoginResponse(
            error: error ?? this.error,
            data: data ?? this.data,
            message: message ?? this.message,
        );

    factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null ? null : data.toJson(),
        "message": message,
    };
}

class Data {
    Data({
        this.token,
    });

    String token;

    Data copyWith({
        String token,
    }) => 
        Data(
            token: token ?? this.token,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"] == null ? null : json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
    };
}
