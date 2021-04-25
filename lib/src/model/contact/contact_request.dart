// To parse this JSON data, do
//
//     final contactRequest = contactRequestFromJson(jsonString);

import 'dart:convert';

class ContactRequest {
  ContactRequest({
    this.name,
    this.email,
    this.content,
    this.address,
    this.phone,
    this.subject,
  });

  String name;
  String email;
  String content;
  String address;
  String phone;
  String subject;

  factory ContactRequest.fromRawJson(String str) =>
      ContactRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactRequest.fromJson(Map<String, dynamic> json) => ContactRequest(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        content: json["content"] == null ? null : json["content"],
        address: json["address"] == null ? null : json["address"],
        phone: json["phone"] == null ? null : json["phone"],
        subject: json["subject"] == null ? null : json["subject"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "content": content == null ? null : content,
        "address": address == null ? null : address,
        "phone": phone == null ? null : phone,
        "subject": subject == null ? null : subject,
      };
}
