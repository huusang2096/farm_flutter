import 'dart:io';

import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/profile/profile_request.dart';
import 'package:farmgate/src/model/profile/profile_request_img.dart';
import 'package:farmgate/src/model/profile/profile_response.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:simplest/simplest.dart';

part 'profile_state.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  bool checkIsLogin() {
    final check = appPref.token.isEmpty ? false : true;
    return check;
  }

  Future<void> getProfile() async {
    if (!checkIsLogin()) {
      return;
    }
    try {
      emit(state.copyWith(isLoading: true));
      ProfileResponse response = await dataRepository.getProfile();
      if (response != null) {
        await appPref.setUser(response);
        String userType = getUserType(response.data.permission);
        emit(GetProfileSuccessState(
            profileResponse: response, state: state, userType: userType));
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copyWith(isLoading: false));
  }

  bool isUseFarm() {
    int permission = state.profileResponse.data.permission;
    if ((permission == 2 ||
            permission == 3 ||
            permission == 4 ||
            permission == 5) &&
        state.profileResponse.data.status == "published") {
      return true;
    }
    return false;
  }

  bool isUse4c() {
    int permission = state.profileResponse.data.permission;
    if ((permission == 3 || permission == 4 || permission == 5) &&
        state.profileResponse.data.status == "published") {
      return true;
    }
    return false;
  }

  String getUserType(int permission) {
    if (permission == null || permission == 1) {
      return 'user_normal';
    } else if (permission == 2) {
      return 'farmer';
    } else if (permission == 3) {
      return 'farmer_4c';
    } else if (permission == 4) {
      return 'host';
    } else if (permission == 5) {
      return 'manager';
    }
    return 'user_normal';
  }

  void submitUpdate(
      {String address,
      String firstName,
      String lastName,
      String gender,
      DateTime dob,
      bool isPickDate}) async {
    final duration = Duration(milliseconds: 1500);
    if (gender.isEmpty) {
      snackbarService.showSnackbar(
          message: 'please_select_your_gender'.tr, duration: duration);
      return;
    }

    if (isPickDate) {
      snackbarService.showSnackbar(
          message: 'please_select_a_date_of_birth'.tr, duration: duration);
      return;
    }

    if (address.isEmpty) {
      snackbarService.showSnackbar(
          message: 'please_enter_your_address'.tr, duration: duration);
      return;
    }

    final checkChange = checkChangeProfile(firstName, lastName, gender, dob);
    if (!checkChange) {
      snackbarService.showSnackbar(message: 'edit_before_updating'.tr);
      return;
    }

    try {
      emit(state.copyWith(isLoading: true));
      final profileRequest = ProfileRequest(
          lastName: lastName,
          firstName: firstName,
          dob:
              '${dob.year}-${dob.month < 10 ? '0${dob.month}' : '${dob.month}'}-${dob.day < 10 ? '0${dob.day}' : '${dob.day}'}',
          gender: gender,
          phone: state.profileResponse.data.phone,
          address: state?.profileRequestt?.address,
          cityId: state?.profileRequestt?.cityId,
          wardId: state?.profileRequestt?.wardId,
          districtId: state?.profileRequestt?.districtId);

      print(profileRequest.toRawJson());
      final response = await dataRepository.updateProfile(profileRequest);

      if (!response.error) {
        await getProfile();
        snackbarService.showSnackbar(
            message: 'update_successful'.tr, duration: duration);
      } else {
        emit(state.copyWith(isLoading: false));
        snackbarService.showSnackbar(
            message: 'update_failed'.tr, duration: duration);
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      handleAppError(e);
    }
  }

  void submitUpdateImg(String file) async {
    try {
      emit(UploadImageState(isUpload: true, state: state, isLoading: true));
      File compressedFile = await FlutterNativeImage.compressImage(file,
          quality: 50, targetWidth: 600, targetHeight: 300);
      final uploadImage =
          await dataRepository.uploadAvatar(picture: compressedFile);
      if (uploadImage != null) {
        getProfile();
      }
      emit(UploadImageState(isUpload: false, state: state, isLoading: false));
    } catch (e) {
      emit(UploadImageState(isUpload: false, state: state, isLoading: false));
      handleAppError(e);
    }
  }

  void logout() async {
    try {
      final dialogResponse = await dialogService.showConfirmationDialog(
          title: appConfig.appName,
          description: 'are_you_sure_to_log_out'.tr,
          cancelTitle: 'cancel'.tr,
          confirmationTitle: 'ok'.tr);

      if (!dialogResponse.confirmed) {
        return;
      }

      emit(state.copyWith(isLoading: true));
      await dataRepository.logout();
      await appPref.logout();
      await dataRepository.loadAuthHeader();
      final newState = LogoutSuccessState(state: state);
      newState.profileResponse = null;
      emit(newState);
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copyWith(isLoading: false));
  }

  bool checkChangeProfile(
      String firstName, String lastName, String gender, DateTime dob) {
    final data = state.profileResponse.data;
    if (state.profileRequestt != null) {
      if (state.profileRequestt.address != data.addressFormat ||
          state.profileRequestt.cityId != data.cityId ||
          state.profileRequestt.districtId != data.districtId ||
          state.profileRequestt.wardId != data.wardId) {
        return true;
      }
    }
    if (firstName != data.firstName ||
        lastName != data.lastName ||
        gender != data.gender ||
        dob.difference(data.dob).inDays != 0) {
      return true;
    }
    return false;
  }

  void pickAddress() async {
    if (state.profileResponse != null) {
      ProfileResponse profileResponse = state.profileResponse;
      if (state.profileRequestt != null) {
        profileResponse = ProfileResponse(
            data: state.profileResponse.data.copyWith(
                addressFormat: state.profileRequestt.address,
                cityId: state.profileRequestt.cityId,
                districtId: state.profileRequestt.districtId,
                wardId: state.profileRequestt.wardId));
      }
      final map = await navigator.pushNamed(AppRoute.pickAddressScreen,
          arguments: {'profileResponse': profileResponse}) as Map;
      if (map != null) {
        final profileRequest = map['profileRequest'];
        emit(ProfileChangeAddressState(profileRequest, state));
      }
    }
  }
}
