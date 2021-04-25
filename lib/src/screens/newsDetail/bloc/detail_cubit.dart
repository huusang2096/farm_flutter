import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/detail/commnet_post_response.dart';
import 'package:farmgate/src/model/detail/detail_news_response.dart';
import 'package:farmgate/src/model/news/category.dart';
import 'package:farmgate/src/model/news/news_model.dart';
import 'package:simplest/simplest.dart';

import 'detail_state.dart';

class DetailCubit extends BaseCubit<DetailState> {
  DetailCubit()
      : super(Initial(DataDetail(
            detail: null, postComment: null, isLoadCommnent: false, news: [])));

  getDetail(String slugPost) async {
    try {
      DetailNewsResponse response = await dataRepository.getPost(slugPost);
      if (response != null) {
        emit(DetailData(state.data.copyWith(detail: response)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }

  getCommentFacebook(String slugPost) async {
    try {
      PostCommentResponse response =
          await dataRepository.getCommentFacbook(slugPost);
      if (response != null) {
        emit(CommentFacebook(state.data.copyWith(postComment: response)));
      }
    } catch (e) {
      logger.e(e);
    }
  }

  getNews(Category category, slugPost, bool isVideo) async {
    try {
      var response;
      if (isVideo) {
        response = await dataRepository.getListVideo();
      } else if (category == null) {
        response = await dataRepository.getListHot();
      } else if (category.id == 0) {
        response = await dataRepository.getHomeNews(1);
      } else {
        response =
            await dataRepository.getNewCategoryResponse(category.slug, 1);
      }
      if (response != null) {
        List<News> listNews = response.data;
        News newCurrent = listNews
            .firstWhere((element) => element.slug == slugPost, orElse: () {
          return null;
        });
        if (newCurrent != null) {
          listNews.remove(newCurrent);
        }
        emit(LoadingComment(state.data.copyWith(news: listNews)));
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
