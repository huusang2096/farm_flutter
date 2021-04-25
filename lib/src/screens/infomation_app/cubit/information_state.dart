part of 'information_cubit.dart';

@freezed
abstract class InformationStateData with _$InformationStateData {
  const factory InformationStateData({List<Rule> rules}) = Data;
}

@freezed
abstract class InformationState with _$InformationState {
  const factory InformationState.initial(Data data) = Initial;
  const factory InformationState.listRule(Data data) = RuleData;
}
