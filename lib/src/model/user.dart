// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

class UserResponse {
  bool success;
  String message;
  User data;

  UserResponse({
    this.success,
    this.message,
    this.data,
  });

  factory UserResponse.fromRawJson(String str) =>
      UserResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class User {
  int id;
  String firstName;
  String lastName;
  String name;
  String email;
  String apiToken;
  String phone;
  String address;
  String bio;
  String image;
  String birthday;
  String address1;
  String city;
  String state;
  int countryId;
  String timezone;
  String type;
  UserLevel currentLevel;
  UserLevel nextLevel;
  double currentPoints;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.name,
      this.email,
      this.apiToken,
      this.phone,
      this.address,
      this.bio,
      this.image,
      this.birthday,
      this.address1,
      this.city,
      this.state,
      this.countryId,
      this.timezone,
      this.type,
      this.currentLevel,
      this.nextLevel,
      this.currentPoints});

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  String fullName() {
    return (firstName ??= '') + ' ' + (lastName ??= '');
  }

  String addressAll() {
    return (address1 ??= '') + ' ' + (city ??= '') + ' ' + (state ??= '');
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? "" : json["first_name"],
        lastName: json["last_name"] == null ? "" : json["last_name"],
        name: json["name"] == null ? "" : json["name"],
        email: json["email"] == null ? "" : json["email"],
        apiToken: json["apiToken"] == null ? "" : json["apiToken"],
        phone: json["phone"] == null ? "" : json["phone"],
        address: json["address"] == null ? "" : json["address"],
        bio: json["bio"] == null ? "" : json["bio"],
        image: json["image"] == null ? "" : json["image"],
        birthday: json["birthday"] == null ? "" : json["birthday"],
        address1: json["address_1"] == null ? "" : json["address_1"],
        city: json["city"] == null ? "" : json["city"],
        state: json["state"] == null ? "" : json["state"],
        countryId: json["country_id"] == null ? 0 : json["country_id"],
        timezone: json["timezone"] == null ? "" : json["timezone"],
        type: json['type'] == null ? '' : json['type'],
        currentLevel: json["currentLevel"] == null
            ? null
            : UserLevel.fromJson(json["currentLevel"]),
        nextLevel: json["nextLevel"] == null
            ? null
            : UserLevel.fromJson(json["nextLevel"]),
        currentPoints: json["currentPoints"] == null
            ? null
            : json["currentPoints"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? "" : firstName,
        "last_name": lastName == null ? "" : lastName,
        "name": name == null ? "" : name,
        "email": email == null ? "" : email,
        "apiToken": apiToken == null ? "" : apiToken,
        "phone": phone == null ? "" : phone,
        "address": address == null ? "" : address,
        "bio": bio == null ? "" : bio,
        "image": image == null ? "" : image,
        "birthday": birthday == null ? "" : birthday,
        "address_1": address1 == null ? "" : address1,
        "city": city == null ? "" : city,
        "state": state == null ? "" : state,
        "country_id": countryId == null ? 0 : countryId,
        "timezone": timezone == null ? "" : timezone,
        'type': type == null ? '' : type,
        "currentLevel": currentLevel == null ? null : currentLevel.toJson(),
        "nextLevel": nextLevel == null ? null : nextLevel.toJson(),
        "currentPoints": currentPoints == null ? null : currentPoints,
      };
}

class UserLevel {
  String name;
  String badgeImage;
  double minimumPoint;

  UserLevel({
    this.name,
    this.badgeImage,
    this.minimumPoint,
  });

  factory UserLevel.fromJson(Map<String, dynamic> json) => UserLevel(
        name: json["name"] == null ? null : json["name"],
        badgeImage: json["badge_image"] == null ? null : json["badge_image"],
        minimumPoint: json["minimum_point"] == null
            ? null
            : json["minimum_point"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "badge_image": badgeImage == null ? null : badgeImage,
        "minimum_point": minimumPoint == null ? null : minimumPoint,
      };
}
