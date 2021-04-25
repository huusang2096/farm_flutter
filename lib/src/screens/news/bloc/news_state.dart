import 'package:farmgate/src/model/news/category.dart';
import 'package:farmgate/src/model/news/news_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_state.freezed.dart';

@freezed
abstract class NewsStateData with _$NewsStateData {
  const factory NewsStateData(
      {int indexTab,
      List<Category> categorys,
      List<News> hotNews,
      DateTime timeUpdate,
      bool isLoading,
      int isCategory}) = Data;
}

// Union
@freezed
abstract class NewsState with _$NewsState {
  const factory NewsState.init(NewsStateData data) = Initial;
  const factory NewsState.changeIndex(NewsStateData data) = ChangeIndex;
  const factory NewsState.listCategory(NewsStateData data) = ListCategory;
  const factory NewsState.listHotNews(NewsStateData data) = ListHotNews;
  const factory NewsState.listNewsData(NewsStateData data) = ListNewsData;
  const factory NewsState.listUpdateData(NewsStateData data) = ListUpdateData;
  const factory NewsState.loadingData(NewsStateData data) = LoadingData;
}
