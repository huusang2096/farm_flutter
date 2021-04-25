import 'package:farmgate/src/model/news/news_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_state.freezed.dart';

@freezed
abstract class VideoStateData with _$VideoStateData {
  const factory VideoStateData({List<News> listVideos}) = Data;
}

// Union
@freezed
abstract class VideoState with _$VideoState {
  const factory VideoState.init(VideoStateData data) = Initial;
  const factory VideoState.listVideo(VideoStateData data) = ListVideo;
}
