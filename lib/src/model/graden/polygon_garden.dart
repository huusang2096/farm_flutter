import 'dart:convert';

class LocationPolygon {
  LocationPolygon({
    this.lat,
    this.lng,
  });

  String lat;
  String lng;

  factory LocationPolygon.fromRawJson(String str) =>
      LocationPolygon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LocationPolygon.fromJson(Map<String, dynamic> json) =>
      LocationPolygon(
        lat: json["lat"] == null ? null : json["lat"],
        lng: json["lng"] == null ? null : json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}
