part of 'history_action_cubit.dart';

@freezed
abstract class HistoryActionStateData with _$HistoryActionStateData {
  const factory HistoryActionStateData({
    @nullable GardenHistoryActionResponse gardenHistoryActionResponse,
    @Default(false) bool isLoading,
    @Default([]) List<HistoryActionModel> shortListAction,
    @Default(0) int nextpage,
  }) = Data;
}

@freezed
abstract class HistoryActionState with _$HistoryActionState {
  const factory HistoryActionState.inital(Data data) = Initial;
  const factory HistoryActionState.loaded(Data data) = Loaded;
}
