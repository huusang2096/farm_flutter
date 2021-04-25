import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/pick_address/city_response.dart';
import 'package:farmgate/src/model/pick_address/district_response.dart';
import 'package:farmgate/src/model/pick_address/ward_response.dart';
import 'package:farmgate/src/model/profile/profile_request.dart';
import 'package:farmgate/src/model/profile/profile_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simplest/simplest.dart';

part 'pick_address_cubit.freezed.dart';
part 'pick_address_state.dart';

class PickAddressCubit extends BaseCubit<PickAddressState> {
  PickAddressCubit(ProfileResponse profileResponse)
      : super(Initial(DataAddress(profileResponse: profileResponse)));

  Future<void> handleInitialData() async {
    if (state.data.profileResponse.data.cityId != null &&
        state.data.profileResponse.data.districtId != null &&
        state.data.profileResponse.data.wardId != null) {
      try {
        emit(Loading(state.data.copyWith(
            isLoadingCity: true,
            isLoadingDistrict: true,
            isLoadingWard: true)));

        final citys = await dataRepository.getCity();
        final selectedCity = citys.data.firstWhere((element) =>
            element.matp == state.data.profileResponse.data.cityId);

        final districts =
            await dataRepository.getDistrictInCity(selectedCity.matp);
        final selectedDistrict = districts.data.firstWhere((element) =>
            element.maqh == state.data.profileResponse.data.districtId);

        final wards =
            await dataRepository.getWardInDistrict(selectedDistrict.maqh);
        final selectedWard = wards.data.firstWhere((element) =>
            element.xaid == state.data.profileResponse.data.wardId);

        emit(Loaded(state.data.copyWith(
            selectedCity: selectedCity,
            selectedDistrict: selectedDistrict,
            selectedWard: selectedWard,
            cityResponse: citys,
            districtResponse: districts,
            wardResponse: wards)));

        await Future.delayed(Duration(milliseconds: 300));
        emit(Loaded(state.data
            .copyWith(isLoadingCity: false, isLoadingDistrict: false)));
      } catch (e) {
        handleAppError(e);
      }
    } else {
      getCitys();
    }
  }

  void getCitys() async {
    try {
      emit(Loading(state.data.copyWith(isLoadingCity: true)));
      final citys = await dataRepository.getCity();
      emit(Loaded(
          state.data.copyWith(cityResponse: citys, isLoadingCity: false)));
    } catch (e) {
      handleAppError(e);
    }
  }

  void getDistrict(String id) async {
    try {
      emit(Loading(state.data.copyWith(isLoadingDistrict: true)));
      final districts = await dataRepository.getDistrictInCity(id);
      emit(Loaded(state.data
          .copyWith(districtResponse: districts, isLoadingDistrict: false)));
    } catch (e) {
      handleAppError(e);
    }
  }

  void getWard(String id) async {
    try {
      emit(Loading(state.data.copyWith(isLoadingWard: true)));
      final wards = await dataRepository.getWardInDistrict(id);
      emit(Loaded(
          state.data.copyWith(wardResponse: wards, isLoadingWard: false)));
    } catch (e) {
      handleAppError(e);
    }
  }

  void changeSelectedCity(City newValue) {
    if (state.data.selectedCity == null) {
      emit(Loaded(state.data.copyWith(selectedCity: newValue)));
      getDistrict(newValue.matp);
    } else {
      if (newValue.matp != state.data.selectedCity.matp) {
        emit(Loaded(state.data.copyWith(
            selectedCity: newValue,
            districtResponse: null,
            selectedDistrict: null,
            wardResponse: null,
            selectedWard: null)));
        getDistrict(newValue.matp);
      }
    }
  }

  void changeSelectedDistrict(District newValue) {
    if (state.data.selectedDistrict == null) {
      emit(Loaded(state.data.copyWith(selectedDistrict: newValue)));
      getWard(newValue.maqh);
    } else {
      if (newValue.maqh != state.data.selectedDistrict.maqh) {
        emit(Loaded(state.data.copyWith(
            selectedDistrict: newValue,
            wardResponse: null,
            selectedWard: null)));
        getWard(newValue.maqh);
      }
    }
  }

  void changeSelectedWard(Ward newValue) {
    emit(Loaded(state.data.copyWith(selectedWard: newValue)));
  }

  void saveAddress(String value) {
    emit(Loaded(state.data.copyWith(address: value)));
  }

  void handleConfirmAddress() async {
    if (state.data.selectedWard == null ||
        state.data.selectedCity == null ||
        state.data.selectedDistrict == null) {
      snackbarService.showSnackbar(message: 'all_field_is_required'.tr);
    } else {
      ProfileRequest profileRequest = ProfileRequest(
          address: state.data.address,
          formatAddess: state.data.address +
              ', ' +
              (state.data.selectedWard?.name ?? '') +
              ', ' +
              (state.data.selectedDistrict?.name ?? '') +
              ', ' +
              (state.data.selectedCity?.name ?? ''),
          wardId: state.data.selectedWard.xaid,
          cityId: state.data.selectedCity.matp,
          districtId: state.data.selectedDistrict.maqh);
      navigator.pop({'profileRequest': profileRequest});
    }
  }
}
