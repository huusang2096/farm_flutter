import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/news/news_model.dart';
import 'package:farmgate/src/model/news/video_response.dart';

import 'video_state.dart';

class VideoCubit extends BaseCubit<VideoState> {
  VideoCubit() : super(Initial(Data(listVideos: [])));

  getListVideo() async {
    try {
      List<News> listVideos = [...state.data.listVideos];
      VideoResponse response = await dataRepository.getListVideo();
      if (response != null) {
        listVideos = response.data;
        emit(ListVideo(state.data.copyWith(listVideos: listVideos)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }
}
