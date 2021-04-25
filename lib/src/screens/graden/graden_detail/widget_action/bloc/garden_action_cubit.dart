import 'dart:async';

import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/base_response.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:farmgate/src/model/graden/action_garden.dart';
import 'package:farmgate/src/model/graden/action_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simplest/simplest.dart';

part 'garden_action_cubit.freezed.dart';
part 'garden_action_state.dart';

class GardenActionCubit extends BaseCubit<GardenActionState> {
  GardenActionCubit()
      : super(Initial(Data(
            isShow: false, gardenId: 0, action: null, listsActionModel: [])));

  void getListAction(int gardenId, ActionGarden action) async {
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
        emit(ListAction(state.data.copyWith(
            gardenId: gardenId,
            listsActionModel: response.data,
            action: action)));
      }
    } catch (e) {
      logger.e(e);
    }
  }

  void addAction() async {
    try {
      // Check data before upload.
      emit(ShowUI(state.data.copyWith(isShow: true)));
      state.data.listsActionModel
          .removeAt(state.data.listsActionModel.length - 1);
      ActionRequest actionRequest = new ActionRequest();
      actionRequest.id = state.data.action.id;
      actionRequest.name = state.data.action.name;
      actionRequest.image = state.data.action.image;
      actionRequest.actions = state.data.listsActionModel;
      BaseResponse response = await dataRepository.addActionGarden(
          state.data.gardenId, actionRequest);
      if (response != null) {
        emit(ShowUI(state.data.copyWith(isShow: false)));
        snackbarService.showSnackbar(
            message: 'add_action'.tr, duration: Duration(seconds: 2));
        new Timer(new Duration(seconds: 3), () async {
          navigator.pop();
        });
      } else {
        state.data.listsActionModel.add(new ActionModel(
            unitName: 'complete_des'.tr,
            inputType: "",
            inputData: "complete_des"));
        emit(ShowUI(state.data.copyWith(isShow: false)));
        snackbarService.showSnackbar(message: 'add_action'.tr);
      }
    } catch (e) {
      emit(ShowUI(state.data.copyWith(isShow: false)));
      snackbarService.showSnackbar(
          message: 'add_action'.tr, duration: Duration(seconds: 2));
    }
  }
}
