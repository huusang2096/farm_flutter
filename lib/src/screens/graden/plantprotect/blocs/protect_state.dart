import 'package:farmgate/src/model/graden/action.dart';
import 'package:farmgate/src/model/plant_protect/plant_protection_types_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'protect_state.freezed.dart';

@freezed
abstract class ProtectStateData with _$ProtectStateData {
  const factory ProtectStateData({
    bool isSending,
    int indexTab,
    List<PlantProtectionTypes> plantProtectionTypes,
    List<ActionModel> listsActionModel,
    DateTime timeUpdate,
  }) = Data;
}

@freezed
abstract class ProtectState with _$ProtectState {
  const factory ProtectState.initial(ProtectStateData data) = ProtectInitial;
  const factory ProtectState.loadedListPlant(ProtectStateData data) =
      LoadedListPlant;
  const factory ProtectState.loadedListPlantType(ProtectStateData data) =
      LoadedListPlantType;
  const factory ProtectState.loadedListPlantAction(ProtectStateData data) =
      LoadedListPlantAction;
  const factory ProtectState.showLoading(ProtectStateData data) = ShowLoading;
  const factory ProtectState.changeIndex(ProtectStateData data) = ChangeIndex;
}
