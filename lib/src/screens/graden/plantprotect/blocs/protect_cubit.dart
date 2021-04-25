import 'dart:async';

import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/base_response.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:farmgate/src/model/graden/action_garden.dart';
import 'package:farmgate/src/model/graden/action_protect_request.dart';
import 'package:farmgate/src/model/plant_protect/plant_protection_types_response.dart';
import 'package:farmgate/src/model/plant_protect/plant_respone.dart';
import 'package:simplest/simplest.dart';

import 'protect_state.dart';

class ProtectCubit extends BaseCubit<ProtectState> {
  ProtectCubit()
      : super(ProtectInitial(Data(
            indexTab: 1,
            plantProtectionTypes: [],
            isSending: false,
            listsActionModel: [],
            timeUpdate: DateTime.now())));

  getListPlantProtect(PlantProtectionTypes plantProtectionTypes) async {
    try {
      PlantResponse response =
          await dataRepository.getPlantProtect(plantProtectionTypes.id);
      if (response != null) {
        plantProtectionTypes.plantProtects.clear();
        plantProtectionTypes.plantProtects.addAll(response.data);
        state.data.plantProtectionTypes[state.data.plantProtectionTypes
                .indexWhere(
                    (element) => element.id == plantProtectionTypes.id)] =
            plantProtectionTypes;
        emit(LoadedListPlant(state.data.copyWith(timeUpdate: DateTime.now())));
      }
    } catch (e) {
      handleAppError(e);
    }
  }

  getListPlanProtectType() async {
    try {
      PlantProtectionTypesResponse response =
          await dataRepository.getPlantProtectType();
      if (response != null) {
        List<PlantProtectionTypes> plantProtectionTypes = [];
        plantProtectionTypes.addAll(response.data);
        emit(LoadedListPlantType(
            state.data.copyWith(plantProtectionTypes: plantProtectionTypes)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }

  changeIndex(int index) {
    emit(ChangeIndex(state.data.copyWith(indexTab: index)));
  }

  addGardenPlantProtectionProducts(
      PlantProtect plantProtect, int gardenId, ActionGarden action) async {
    try {
      // Check data before upload.
      bool isVerifyData = true;
      state.data.listsActionModel.forEach((actionModel) {
        if (actionModel.inputData.isEmpty) {
          isVerifyData = false;
          snackbarService.showSnackbar(
              message: 'complete_des'.tr, duration: Duration(seconds: 2));
          return;
        }
      });

      if (isVerifyData) {
        emit(ShowLoading(state.data.copyWith(isSending: true)));
        state.data.listsActionModel
            .removeAt(state.data.listsActionModel.length - 1);
        ActionProtectRequest actionRequest = new ActionProtectRequest();
        actionRequest.id = action.id;
        actionRequest.name = action.name;
        actionRequest.image = action.image;
        actionRequest.actions = state.data.listsActionModel;
        actionRequest.plantProtectionProductId = plantProtect.id;
        BaseResponse response =
            await dataRepository.addPlantProtection(gardenId, actionRequest);
        if (response != null) {
          emit(ShowLoading(state.data.copyWith(isSending: false)));
          snackbarService.showSnackbar(
              message: 'add_product_done'
                  .tr
                  .trArgs(['${plantProtect.name ?? ''}', ' ']));
          new Timer(new Duration(seconds: 3), () async {
            navigator.pop();
          });
        } else {
          state.data.listsActionModel.add(new ActionModel(
              unitName: 'complete_des'.tr,
              inputType: "",
              inputData: "complete_des"));
          emit(ShowLoading(state.data.copyWith(isSending: false)));
          snackbarService.showSnackbar(message: 'add_action'.tr);
        }
      }
    } catch (e) {
      state.data.listsActionModel.add(new ActionModel(
          unitName: 'complete_des'.tr,
          inputType: "",
          inputData: "complete_des"));
      emit(ShowLoading(state.data.copyWith(isSending: false)));
      logger.e(e);
    }
  }

  void getListAction(ActionGarden action) async {
    if (state.data.listsActionModel.length > 0) {
      return;
    }
    try {
      ActionResponse response =
          await dataRepository.getListActionById(action.id);
      response.data.add(new ActionModel(
          unitName: 'complete_des'.tr,
          inputType: "",
          inputData: "complete_des"));
      if (response != null) {
        emit(LoadedListPlantAction(
            state.data.copyWith(listsActionModel: response.data)));
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
