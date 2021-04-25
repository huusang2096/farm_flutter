part of 'all_project_cubit.dart';

@freezed
abstract class AllProjectStateData with _$AllProjectStateData {
  const factory AllProjectStateData({
    bool isLoading,
    bool isAdd,
    AllProjectResponse allProjectResponse,
    DateTime timeUpdate,
    List<MemberPartner> members,
    Profile user,
  }) = Data;
}

@freezed
abstract class AllProjectState with _$AllProjectState {
  const factory AllProjectState.initial(Data data) = Initial;
  const factory AllProjectState.loading(Data data) = Loading;
  const factory AllProjectState.getAllProject(Data data) = GetAllProject;
  const factory AllProjectState.getMemberPartner(Data data) = GetMemberPartner;
}
