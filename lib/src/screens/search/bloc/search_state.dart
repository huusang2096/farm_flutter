import 'package:farmgate/src/model/news/news_model.dart';
import 'package:farmgate/src/model/search/tag_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.freezed.dart';

@freezed
abstract class SearchStateData with _$SearchStateData {
  const factory SearchStateData(
      {String statusSearch,
      Tags tagSelect,
      List<Tags> tags,
      List<News> news}) = Data;
}

// Union
@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState.init(SearchStateData data) = Initial;
  const factory SearchState.tags(SearchStateData data) = ListTags;
  const factory SearchState.news(SearchStateData data) = ListNews;
}
