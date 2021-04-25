part of 'manager_project_cubit.dart';

@freezed
abstract class ManagerProjectStateData with _$ManagerProjectStateData {
  const factory ManagerProjectStateData(
      {bool isLoading, @nullable List<MyProject> myProjects}) = Data;
}

@freezed
abstract class ManagerProjectState with _$ManagerProjectState {
  const factory ManagerProjectState.initial(Data data) = Initial;
  const factory ManagerProjectState.loading(Data data) = Loading;
  const factory ManagerProjectState.loaded(Data data) = Loaded;
}
