// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

class ProfileUpdateResponse {
  ProfileUpdateResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  ProfileUpdate data;
  String message;

  factory ProfileUpdateResponse.fromRawJson(String str) =>
      ProfileUpdateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateResponse(
        error: json["error"] == null ? null : json["error"],
        data:
            json["data"] == null ? null : ProfileUpdate.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}

class ProfileUpdate {
  ProfileUpdate({
    this.id,
    this.firstName,
    this.lastName,
    this.description,
    this.gender,
    this.email,
    this.avatarId,
    this.dob,
    this.phone,
    this.confirmedAt,
    this.emailVerifyToken,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String firstName;
  String lastName;
  dynamic description;
  dynamic gender;
  String email;
  int avatarId;
  DateTime dob;
  String phone;
  dynamic confirmedAt;
  String emailVerifyToken;
  String createdAt;
  String updatedAt;

  factory ProfileUpdate.fromRawJson(String str) =>
      ProfileUpdate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileUpdate.fromJson(Map<String, dynamic> json) => ProfileUpdate(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        description: json["description"],
        gender: json["gender"],
        email: json["email"] == null ? null : json["email"],
        avatarId: json["avatar_id"] == null ? null : json["avatar_id"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        phone: json["phone"] == null ? null : json["phone"],
        confirmedAt: json["confirmed_at"],
        emailVerifyToken: json["email_verify_token"] == null
            ? null
            : json["email_verify_token"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "description": description,
        "gender": gender,
        "email": email == null ? null : email,
        "avatar_id": avatarId == null ? null : avatarId,
        "dob": dob == null
            ? null
            : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "phone": phone == null ? null : phone,
        "confirmed_at": confirmedAt,
        "email_verify_token":
            emailVerifyToken == null ? null : emailVerifyToken,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
