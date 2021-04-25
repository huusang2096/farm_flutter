import 'dart:io';
import 'dart:typed_data';

import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/base_response.dart';
import 'package:farmgate/src/model/user_type/user_type_model.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simplest/simplest.dart';

part 'user_type_cubit.freezed.dart';
part 'user_type_state.dart';

class UserTypeCubit extends BaseCubit<UserTypeState> {
  UserTypeCubit() : super(Initial(DataUserType(userTypeModel: null)));

  void changeUserType(UserTypeModel userTypeModel) async {
    // Check user type
    if (appPref.getUser().data.permission == userTypeModel.permistionID) {
      dialogService.showDialog(
        title: kAppName,
        description: 'you_are'.tr.trArgs([userTypeModel.userType.tr]),
      );
    } else {
      emit(ChangeTye(state.data.copyWith(userTypeModel: userTypeModel)));
    }
  }

  bool isShowID() {
    if (state.data.userTypeModel == null) {
      return false;
    }
    return state.data.userTypeModel.userType == "farmer" ||
        state.data.userTypeModel.userType == "farmer_4c" ||
        state.data.userTypeModel.userType == "manager" ||
        state.data.userTypeModel.userType == "host";
  }

  bool isShowBusinessLicense() {
    if (state.data.userTypeModel == null) {
      return false;
    }
    return state.data.userTypeModel.userType == "manager" ||
        state.data.userTypeModel.userType == "host";
  }

  void updateUserType(String numberId, String businessId) async {
    if (state.data.userTypeModel == null) {
      snackbarService.showSnackbar(message: 'please_select_usertype'.tr);
      return;
    }

    if (numberId.isEmpty && state.data.userTypeModel.permistionID != 2) {
      snackbarService.showSnackbar(message: 'input_id'.tr);
      return;
    }

    if (state.data.userTypeModel.permistionID == 4 ||
        state.data.userTypeModel.permistionID == 5) {
      if (businessId.isEmpty) {
        snackbarService.showSnackbar(message: 'input_business'.tr);
        return;
      }
    }

    try {
      emit(Loading(state.data.copyWith(isLoading: true)));
      BaseResponse response;
      if (state.data.userTypeModel.permistionID == 4 ||
          state.data.userTypeModel.permistionID == 5) {
        response = await dataRepository.updateUser(
            state.data.userTypeModel.permistionID, numberId, businessId,
            imageIDBefore: state.data.imgIDBefore,
            imageIDAfter: state.data.imgIDAfter,
            imageBusiness: state.data.imgBusiness);
      } else {
        response = await dataRepository.updateUserNoBusiness(
            state.data.userTypeModel.permistionID, numberId,
            imageIDBefore: state.data.imgIDBefore,
            imageIDAfter: state.data.imgIDAfter);
      }

      emit(Loading(state.data.copyWith(isLoading: false)));
      if (!response.error) {
        final dialogResponse = await dialogService.showDialog(
            title: kAppName, description: 'update_user_type'.tr);
        if (dialogResponse.confirmed) {
          navigator.pop();
          return;
        }
      } else {
        snackbarService.showSnackbar(message: 'update_failed'.tr);
      }
    } catch (e) {
      emit(Loading(state.data.copyWith(isLoading: false)));
      handleAppError(e);
    }
  }

  void submitUpdateImg(String file, bool isID, bool isBefore) async {
    try {
      File compressedFile =
          await FlutterNativeImage.compressImage(file, quality: 50);
      if (isID) {
        if (isBefore) {
          emit(UploadImage(state.data.copyWith(imgIDBefore: compressedFile)));
        } else {
          emit(UploadImage(state.data.copyWith(imgIDAfter: compressedFile)));
        }
      } else {
        emit(UploadImage(state.data.copyWith(imgBusiness: compressedFile)));
      }
    } catch (e) {
      handleAppError(e);
    }
  }
}
