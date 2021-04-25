import 'package:farmgate/src/model/place_response.dart';
import 'package:farmgate/src/model/review/ImageSelect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_news_state.freezed.dart';

@freezed
abstract class AddNewsStateData with _$AddNewsStateData {
  const factory AddNewsStateData(
      {List<ImageSelect> imageSelects, Place myPlace, bool isLoading}) = Data;
}

@freezed
abstract class AddNewsState with _$AddNewsState {
  const factory AddNewsState.init(AddNewsStateData data) = Initial;
  const factory AddNewsState.addImage(AddNewsStateData data) = ImageChange;
  const factory AddNewsState.addPlace(AddNewsStateData data) = PlaceChange;
  const factory AddNewsState.addPost(AddNewsStateData data) = AddPost;
}
