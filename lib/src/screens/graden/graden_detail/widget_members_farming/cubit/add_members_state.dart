part of 'add_members_cubit.dart';

@freezed
abstract class AddMembersStateData with _$AddMembersStateData {
  const factory AddMembersStateData(
      {@Default(false) bool isLoading,
      @nullable File imgTemp,
      @nullable Member member,
      @Default([]) List<Member> listMemberAddNew,
      int idGarden,
      String status,
      @nullable String selectedGender}) = DataAddMember;
}

// Union
@freezed
abstract class AddMembersState with _$AddMembersState {
  const factory AddMembersState.init(DataAddMember data) = Initial;

  const factory AddMembersState.loading(DataAddMember data) = Loading;

  const factory AddMembersState.loaded(DataAddMember data) = Loaded;

  const factory AddMembersState.success(DataAddMember data) = Success;

  const factory AddMembersState.addSuccess(DataAddMember data) = AddSuccess;
}
