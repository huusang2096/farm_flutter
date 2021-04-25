// To parse this JSON data, do
//
//     final contactResponse = contactResponseFromJson(jsonString);

import 'dart:convert';

class ContactResponse {
  ContactResponse({
    this.message,
    this.errors,
  });

  String message;
  Errors errors;

  factory ContactResponse.fromRawJson(String str) =>
      ContactResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      ContactResponse(
        message: json["message"] == null ? null : json["message"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "errors": errors == null ? null : errors.toJson(),
      };
}

class Errors {
  Errors({
    this.email,
    this.content,
  });

  List<String> email;
  List<String> content;

  factory Errors.fromRawJson(String str) => Errors.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: json["email"] == null
            ? null
            : List<String>.from(json["email"].map((x) => x)),
        content: json["content"] == null
            ? null
            : List<String>.from(json["content"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : List<dynamic>.from(email.map((x) => x)),
        "content":
            content == null ? null : List<dynamic>.from(content.map((x) => x)),
      };
}
