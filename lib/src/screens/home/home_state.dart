import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeStateData with _$HomeStateData {
  const factory HomeStateData({int indexTab}) = Data;
}

// Union
@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState.init(HomeStateData data) = Initial;
  const factory HomeState.changeTab(HomeStateData data) = ChangeTab;
  const factory HomeState.updateUser(HomeStateData data) = UpdateUser;
}
