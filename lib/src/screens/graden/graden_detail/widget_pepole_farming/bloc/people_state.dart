part of 'people_cubit.dart';

@freezed
abstract class PeopleStateData with _$PeopleStateData {
  const factory PeopleStateData({
    @Default([]) List<Member> listMember,
    @Default(false) bool isLoading,
  }) = Data;
}

@freezed
abstract class PeopleState with _$PeopleState {
  const factory PeopleState.inital(Data data) = Initial;
  const factory PeopleState.loaded(Data data) = Loaded;
}
