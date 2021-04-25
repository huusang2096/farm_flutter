// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

class ProfileResponse {
  ProfileResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  Profile data;
  dynamic message;

  factory ProfileResponse.fromRawJson(String str) =>
      ProfileResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null ? null : Profile.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null ? null : data.toJson(),
        "message": message,
      };
}

class Profile {
  Profile(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.avatarUrl,
      this.dob,
      this.gender,
      this.description,
      this.districtId,
      this.cityId,
      this.wardId,
      this.address,
      this.addressFormat,
      this.permission,
      this.status});

  int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String avatarUrl;
  DateTime dob;
  String gender;
  String description;
  String districtId;
  String cityId;
  String wardId;
  String address;
  String addressFormat;
  int permission;
  String status;
  Profile copyWith(
          {int id,
          String firstName,
          String lastName,
          String email,
          String phone,
          String avatarUrl,
          DateTime dob,
          String gender,
          String description,
          String districtId,
          String cityId,
          String wardId,
          String address,
          String addressFormat,
          int permission,
          String status}) =>
      Profile(
          id: id ?? this.id,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          email: email ?? this.email,
          phone: phone ?? this.phone,
          avatarUrl: avatarUrl ?? this.avatarUrl,
          dob: dob ?? this.dob,
          gender: gender ?? this.gender,
          description: description ?? this.description,
          districtId: districtId ?? this.districtId,
          cityId: cityId ?? this.cityId,
          wardId: wardId ?? this.wardId,
          address: address ?? this.address,
          addressFormat: addressFormat ?? this.addressFormat,
          permission: permission ?? this.permission,
          status: status ?? this.status);
  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        avatarUrl: json["avatar_url"] == null ? null : json['avatar_url'],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        gender: json["gender"] == null ? null : json["gender"],
        description: json["description"] == null ? null : json["description"],
        districtId: json["district_id"] == null ? null : json["district_id"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        wardId: json["ward_id"] == null ? null : json["ward_id"],
        address: json["address"] == null ? "" : json["address"],
        addressFormat:
            json["address_format"] == null ? "" : json["address_format"],
        permission: json["permission"] == null ? null : json["permission"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "avatar_url": avatarUrl,
        "dob": dob == null
            ? null
            : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "gender": gender == null ? null : gender,
        "description": description == null ? null : description,
        "district_id": districtId == null ? null : districtId,
        "city_id": cityId == null ? null : cityId,
        "ward_id": wardId == null ? null : wardId,
        "address": address == null ? "" : address,
        "address_format": addressFormat == null ? "" : addressFormat,
        "permission": permission == null ? null : permission,
        "status": status == null ? null : status,
      };
}

class Avatar {
  Avatar({
    this.encoded,
    this.mime,
    this.dirname,
    this.basename,
    this.extension,
    this.filename,
  });

  String encoded;
  String mime;
  dynamic dirname;
  dynamic basename;
  dynamic extension;
  dynamic filename;

  factory Avatar.fromRawJson(String str) => Avatar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        encoded: json["encoded"] == null ? null : json["encoded"],
        mime: json["mime"] == null ? null : json["mime"],
        dirname: json["dirname"],
        basename: json["basename"],
        extension: json["extension"],
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "encoded": encoded == null ? null : encoded,
        "mime": mime == null ? null : mime,
        "dirname": dirname,
        "basename": basename,
        "extension": extension,
        "filename": filename,
      };
}
