import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/graden/garden_history_action_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'history_action_cubit.freezed.dart';
part 'history_action_state.dart';

class HistoryActionCubit extends BaseCubit<HistoryActionState> {
  HistoryActionCubit() : super(Initial(Data()));

  void getShortActionHistory(int gardenId) async {
    GardenHistoryActionResponse gardenHistoryActionResponse;
    try {
      emit(Loaded(state.data.copyWith(isLoading: true)));
      gardenHistoryActionResponse =
          await dataRepository.gardenHistoryAction(gardenId, 1);
      final shortListAction =
          gardenHistoryActionResponse.data.data.take(3).toList();
      emit(Loaded(state.data.copyWith(
          gardenHistoryActionResponse: gardenHistoryActionResponse,
          shortListAction: shortListAction,
          isLoading: false)));
    } catch (e) {
      handleAppError(e);
    }
  }

  void getAllActionList(int gardenId) async {
    try {
      GardenHistoryActionResponse gardenHistoryActionResponse;
      emit(Loaded(state.data.copyWith(isLoading: true)));

      gardenHistoryActionResponse =
          await dataRepository.gardenHistoryAction(gardenId, 1);

      if (gardenHistoryActionResponse != null) {
        int nextPage =
            gardenHistoryActionResponse.data.nextPageUrl == null ? 0 : 2;
        gardenHistoryActionResponse.data.to = nextPage;
        emit(Loaded(state.data.copyWith(
            gardenHistoryActionResponse: gardenHistoryActionResponse,
            isLoading: false)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }

  void getMorelActionList(int gardenId) async {
    try {
      emit(Loaded(state.data.copyWith(isLoading: true)));

      GardenHistoryActionResponse gardenHistoryActionResponseOld =
          state.data.gardenHistoryActionResponse;
      int page = gardenHistoryActionResponseOld.data.to;
      if (page == 0) {
        return;
      }

      GardenHistoryActionResponse gardenHistoryActionResponse =
          await dataRepository.gardenHistoryAction(gardenId, page);

      if (gardenHistoryActionResponse != null) {
        int nextPage =
            gardenHistoryActionResponse.data.nextPageUrl == null ? 0 : page + 1;
        gardenHistoryActionResponseOld.data.to = nextPage;
        gardenHistoryActionResponseOld.data.data
            .addAll(gardenHistoryActionResponse.data.data);
        emit(Loaded(state.data.copyWith(
            gardenHistoryActionResponse: gardenHistoryActionResponseOld,
            isLoading: false)));
      }
    } catch (e) {
      emit(Loaded(state.data.copyWith(isLoading: false)));
      handleAppError(e);
    }
  }
}
