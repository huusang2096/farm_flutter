import 'dart:convert';

class Author {
  Author({
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
  String gender;
  String email;
  int avatarId;
  String dob;
  String phone;
  dynamic confirmedAt;
  String emailVerifyToken;
  DateTime createdAt;
  DateTime updatedAt;

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  String fullName() {
    return (firstName ??= '') + ' ' + (lastName ??= '');
  }

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        description: json["description"],
        gender: json["gender"] == null ? null : json["gender"],
        email: json["email"] == null ? null : json["email"],
        avatarId: json["avatar_id"] == null ? null : json["avatar_id"],
        dob: json["dob"] == null ? null : json["dob"],
        phone: json["phone"] == null ? null : json["phone"],
        confirmedAt: json["confirmed_at"],
        emailVerifyToken: json["email_verify_token"] == null
            ? null
            : json["email_verify_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "description": description,
        "gender": gender == null ? null : gender,
        "email": email == null ? null : email,
        "avatar_id": avatarId == null ? null : avatarId,
        "dob": dob == null ? null : dob,
        "phone": phone == null ? null : phone,
        "confirmed_at": confirmedAt,
        "email_verify_token":
            emailVerifyToken == null ? null : emailVerifyToken,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
