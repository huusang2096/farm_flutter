import 'package:farmgate/src/model/graden/graden_response.dart';
import 'package:farmgate/src/model/graden/polygon_garden.dart';
import 'package:farmgate/src/model/place_response.dart';
import 'package:farmgate/src/model/review/ImageSelect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_garden_state.freezed.dart';

@freezed
abstract class AddGardensStateData with _$AddGardensStateData {
  const factory AddGardensStateData(
      {List<ImageSelect> imageSelects,
      Place myPlace,
      bool isLoading,
      List<LocationPolygon> list,
      MyGarden myGarden,
      DateTime time}) = Data;
}

@freezed
abstract class AddGardensState with _$AddGardensState {
  const factory AddGardensState.init(AddGardensStateData data) = Initial;
  const factory AddGardensState.addImage(AddGardensStateData data) =
      ImageChange;
  const factory AddGardensState.addPost(AddGardensStateData data) = AddPost;
  const factory AddGardensState.addBoder(AddGardensStateData data) = AddBoder;
  const factory AddGardensState.addCurentGarden(AddGardensStateData data) =
      AddGarden;
}
