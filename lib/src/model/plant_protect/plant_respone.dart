class PlantResponse {
  PlantResponse({
    this.error,
    this.data,
    this.message,
  });

  bool error;
  List<PlantProtect> data;
  String message;

  factory PlantResponse.fromJson(Map<String, dynamic> json) => PlantResponse(
        error: json["error"],
        data: List<PlantProtect>.from(json["data"].map((x) => PlantProtect.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class PlantProtect {
  PlantProtect({
    this.id,
    this.name,
    this.description,
    // this.image,
    this.createdAt,
    this.updatedAt,
    this.linkImage,
  });

  int id;
  String name;
  String description;

  // Image image;
  dynamic createdAt;
  dynamic updatedAt;
  String linkImage;

  factory PlantProtect.fromJson(Map<String, dynamic> json) => PlantProtect(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        // image: imageValues.map[json["image"]],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        linkImage: json["link_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        // "image": imageValues.reverse[image],
        "created_at": createdAt,
        "updated_at": updatedAt,
        "link_image": linkImage,
      };
}
