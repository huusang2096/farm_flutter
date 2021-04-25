// To parse this JSON data, do
//
//     final memberPartnerProjectResponse = memberPartnerProjectResponseFromJson(jsonString);

import 'dart:convert';

class MemberPartnerProjectResponse {
  MemberPartnerProjectResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<MemberPartner> data;
  String message;

  factory MemberPartnerProjectResponse.fromRawJson(String str) =>
      MemberPartnerProjectResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MemberPartnerProjectResponse.fromJson(Map<String, dynamic> json) =>
      MemberPartnerProjectResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<MemberPartner>.from(
                json["data"].map((x) => MemberPartner.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message == null ? null : message,
      };
}

class MemberPartner {
  MemberPartner(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.avatarUrl,
      this.dob,
      this.gender,
      this.description,
      this.permission,
      this.status,
      this.isSelect});

  int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String avatarUrl;
  DateTime dob;
  String gender;
  dynamic description;
  int permission;
  String status;
  bool isSelect;

  factory MemberPartner.fromRawJson(String str) =>
      MemberPartner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MemberPartner.fromJson(Map<String, dynamic> json) => MemberPartner(
      id: json["id"] == null ? null : json["id"],
      firstName: json["first_name"] == null ? null : json["first_name"],
      lastName: json["last_name"] == null ? null : json["last_name"],
      email: json["email"] == null ? null : json["email"],
      phone: json["phone"] == null ? null : json["phone"],
      avatarUrl: json["avatar_url"] == null ? null : json["avatar_url"],
      dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
      gender: json["gender"] == null ? null : json["gender"],
      description: json["description"],
      permission: json["permission"] == null ? null : json["permission"],
      status: json["status"] == null ? null : json["status"],
      isSelect: false);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "avatar_url": avatarUrl == null ? null : avatarUrl,
        "dob": dob == null
            ? null
            : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "gender": gender == null ? null : gender,
        "description": description,
        "permission": permission == null ? null : permission,
        "status": status == null ? null : status,
      };

  get fullname {
    return firstName + lastName;
  }
}
