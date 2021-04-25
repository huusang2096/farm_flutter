part of 'garden_action_cubit.dart';

@freezed
abstract class GardenActionStateData with _$GardenActionStateData {
  const factory GardenActionStateData(
      {bool isShow,
      List<ActionModel> listsActionModel,
      ActionGarden action,
      int gardenId}) = Data;
}

@freezed
abstract class GardenActionState with _$GardenActionState {
  const factory GardenActionState.inital(Data data) = Initial;
  const factory GardenActionState.show(Data data) = ShowUI;
  const factory GardenActionState.getListAction(Data data) = ListAction;
}
