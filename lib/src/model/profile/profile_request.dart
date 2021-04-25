// To parse this JSON data, do
//
//     final profileRequest = profileRequestFromJson(jsonString);

import 'dart:convert';

class ProfileRequest {
  ProfileRequest({
    this.firstName,
    this.lastName,
    this.phone,
    this.dob,
    this.description,
    this.districtId,
    this.cityId,
    this.wardId,
    this.address,
    this.formatAddess,
    this.gender,
  });

  String firstName;
  String lastName;
  String phone;
  String dob;
  String description;
  String districtId;
  String cityId;
  String wardId;
  String address;
  String formatAddess;
  String gender;

  ProfileRequest copyWith({
    String firstName,
    String lastName,
    String phone,
    String dob,
    String description,
    String districtId,
    String cityId,
    String wardId,
    String address,
    String formatAddess,
    String gender,
  }) =>
      ProfileRequest(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        dob: dob ?? this.dob,
        description: description ?? this.description,
        districtId: districtId ?? this.districtId,
        cityId: cityId ?? this.cityId,
        wardId: wardId ?? this.wardId,
        address: address ?? this.address,
        formatAddess: formatAddess ?? this.formatAddess,
        gender: gender ?? this.gender,
      );

  factory ProfileRequest.fromRawJson(String str) =>
      ProfileRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileRequest.fromJson(Map<String, dynamic> json) => ProfileRequest(
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        phone: json["phone"] == null ? null : json["phone"],
        dob: json["dob"] == null ? null : json["dob"],
        description: json["description"] == null ? null : json["description"],
        districtId: json["district_id"] == null ? null : json["district_id"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        wardId: json["ward_id"] == null ? null : json["ward_id"],
        address: json["address"] == null ? null : json["address"],
        formatAddess:
            json['formatAddess'] == null ? null : json['formatAddess'],
        gender: json["gender"] == null ? null : json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "phone": phone == null ? null : phone,
        "dob": dob == null ? null : dob,
        "description": description == null ? null : description,
        "district_id": districtId == null ? null : districtId,
        "city_id": cityId == null ? null : cityId,
        "ward_id": wardId == null ? null : wardId,
        "address": address == null ? null : address,
        'formatAddess': formatAddess == null ? null : formatAddess,
        "gender": gender == null ? null : gender,
      };
}
