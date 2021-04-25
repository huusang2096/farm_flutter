part of 'manager_project_detail_cubit.dart';

@freezed
abstract class ManagerProjectDetailStateData
    with _$ManagerProjectDetailStateData {
  const factory ManagerProjectDetailStateData(
      {bool isLoading,
      List<HistoryTransaction> historyTransaction,
      Profile user}) = Data;
}

@freezed
abstract class ManagerProjectDetailState with _$ManagerProjectDetailState {
  const factory ManagerProjectDetailState.initial(Data data) = Initial;
  const factory ManagerProjectDetailState.loading(Data data) = Loading;
  const factory ManagerProjectDetailState.historys(Data data) = Historys;
  const factory ManagerProjectDetailState.getUser(Data data) = User;
}
