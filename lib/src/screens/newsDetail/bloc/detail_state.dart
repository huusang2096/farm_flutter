import 'package:farmgate/src/model/detail/commnet_post_response.dart';
import 'package:farmgate/src/model/detail/detail_news_response.dart';
import 'package:farmgate/src/model/news/news_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_state.freezed.dart';

@freezed
abstract class DetailStateData with _$DetailStateData {
  const factory DetailStateData(
      {DetailNewsResponse detail,
      PostCommentResponse postComment,
      bool isLoadCommnent,
      List<News> news}) = DataDetail;
}

// Union
@freezed
abstract class DetailState with _$DetailState {
  const factory DetailState.init(DetailStateData data) = Initial;
  const factory DetailState.detail(DetailStateData data) = DetailData;
  const factory DetailState.postComment(DetailStateData data) = CommentFacebook;
  const factory DetailState.loadComment(DetailStateData data) = LoadingComment;
  const factory DetailState.loadNews(DetailStateData data) = LoadingOtherNews;
}
