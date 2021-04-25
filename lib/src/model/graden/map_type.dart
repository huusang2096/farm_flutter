// To parse this JSON data, do
//
//     final gardenResponse = gardenResponseFromJson(jsonString);

import 'package:simplest/simplest.dart';

class MapTypeModel {
  String title;
  String image;
  MapType acitonType;

  MapTypeModel({this.title, this.image, this.acitonType});

  List<MapTypeModel> getListMapType() {
    List<MapTypeModel> list = [];

    list.add(new MapTypeModel(
        title: 'normal',
        image: 'assets/images/map_icon_svg.svg',
        acitonType: MapType.normal));
    list.add(new MapTypeModel(
        title: 'satellite',
        image: 'assets/images/satelite.svg',
        acitonType: MapType.satellite));
    list.add(new MapTypeModel(
        title: 'hybrid',
        image: 'assets/images/roadmap.svg',
        acitonType: MapType.hybrid));
    list.add(new MapTypeModel(
        title: 'terrain',
        image: 'assets/images/terrain.svg',
        acitonType: MapType.terrain));

    return list;
  }
}
