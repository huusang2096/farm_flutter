import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/news/news_model.dart';
import 'package:farmgate/src/model/share/share_response.dart';

import 'share_state.dart';

class ShareCubit extends BaseCubit<ShareState> {
  ShareCubit() : super(Initial(Data(listShares: [])));

  getListShare() async {
    try {
      List<News> listShares = [...state.data.listShares];

      ShareResponse response = await dataRepository.getShareExperiences();
      if (response != null) {
        listShares = response.data;
        emit(ListShare(state.data.copyWith(listShares: listShares)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }
}
