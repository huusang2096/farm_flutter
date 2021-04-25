import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/search/news_category_response.dart';
import 'package:farmgate/src/model/search/tag_response.dart';

import 'search_state.dart';

class SearchCubit extends BaseCubit<SearchState> {
  SearchCubit()
      : super(Initial(Data(
            statusSearch: "NORMAL",
            tags: [],
            news: [],
            tagSelect: new Tags(id: 0, name: "", slug: ""))));

  getListTag() async {
    try {
      TagsResponse response = await dataRepository.getTags();
      if (response != null) {
        emit(ListTags(state.data.copyWith(tags: response.data)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }

  clear() {
    emit(ListNews(state.data.copyWith(news: [])));
    emit(ListNews(state.data.copyWith(
        statusSearch: "NORMAL",
        tagSelect: new Tags(id: 0, name: "", slug: ""))));
  }

  getListNewbyTag(Tags tags) async {
    try {
      emit(ListNews(
          state.data.copyWith(statusSearch: "SEARCH", tagSelect: tags)));
      NewsByTagsResponse response = await dataRepository.getNewByTag(tags.slug);
      if (response != null) {
        if (response.data != null && response.data.length > 0) {
          emit(ListNews(state.data.copyWith(news: response.data)));
          emit(ListNews(state.data.copyWith(statusSearch: "OK")));
        } else {
          emit(ListNews(state.data.copyWith(news: [])));
          emit(ListNews(state.data.copyWith(statusSearch: "ZERO_RESULTS")));
        }
      }
    } catch (e) {
      handleAppError(e);
    }
  }
}
