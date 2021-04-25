import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/news/category.dart';
import 'package:farmgate/src/model/news/category_response.dart';
import 'package:farmgate/src/model/news/hot_response.dart';
import 'package:farmgate/src/model/news/news_category_response.dart';

import 'news_state.dart';

class NewsCubit extends BaseCubit<NewsState> {
  NewsCubit()
      : super(Initial(Data(
            indexTab: 2,
            categorys: [],
            hotNews: [],
            timeUpdate: DateTime.now(),
            isLoading: false,
            isCategory: -1)));

  changeIndex(int index) {
    emit(ChangeIndex(state.data.copyWith(indexTab: index)));
  }

  getListCategory() async {
    try {
      CategoryResponse response = await dataRepository.getListCategory();
      if (response != null) {
        List<Category> category = [];
        category.add(new Category(
            id: 0, name: 'home', description: '', slug: '', listNews: []));
        category.addAll(response.data);
        emit(ListCategory(state.data.copyWith(categorys: category)));
      }
    } catch (e) {
      //handleAppError(e);
    }
  }

  getListHotNews() async {
    try {
      HotResponse response = await dataRepository.getListHot();
      if (response != null) {
        emit(ListHotNews(state.data.copyWith(hotNews: response.data)));
      }
    } catch (e) {
      //handleAppError(e);
    }
  }

  getNews(Category category) async {
    try {
      NewsCategoryResponse response;
      emit(LoadingData(
          state.data.copyWith(isLoading: true, isCategory: category.id)));
      if (category.id == 0) {
        response = await dataRepository.getHomeNews(1);
      } else {
        response =
            await dataRepository.getNewCategoryResponse(category.slug, 1);
      }
      if (response != null) {
        int nextPage = response.links.next == null ? 0 : 2;
        category.nextPage = nextPage;
        category.listNews = response.data;
        state.data.categorys[state.data.categorys
            .indexWhere((element) => element.id == category.id)] = category;
        emit(ListNewsData(state.data.copyWith(
            timeUpdate: DateTime.now(), isLoading: false, isCategory: -1)));
      }
    } catch (e) {
      emit(LoadingData(state.data.copyWith(isLoading: false, isCategory: -1)));
    }
  }

  getMore(Category category) async {
    try {
      NewsCategoryResponse response;
      int page = category.nextPage;
      if (category.nextPage == 0) {
        return;
      }

      if (category.id == 0) {
        response = await dataRepository.getHomeNews(page);
      } else {
        response =
            await dataRepository.getNewCategoryResponse(category.slug, page);
      }
      if (response != null) {
        int nextPage = response.links.next == null ? 0 : page + 1;
        category.nextPage = nextPage;
        category.listNews.addAll(response.data);
        state.data.categorys[state.data.categorys
            .indexWhere((element) => element.id == category.id)] = category;
        emit(ListNewsData(state.data.copyWith(timeUpdate: DateTime.now())));
      }
    } catch (e) {
      //handleAppError(e);
    }
  }
}
