part of 'pick_address_cubit.dart';

@freezed
abstract class PickAddressData with _$PickAddressData {
  const factory PickAddressData({
    @nullable ProfileResponse profileResponse,
    @Default('') String address,
    @nullable CityResponse cityResponse,
    @Default(false) bool isLoadingCity,
    @nullable City selectedCity,
    @nullable DistrictResponse districtResponse,
    @Default(false) bool isLoadingDistrict,
    @nullable District selectedDistrict,
    @nullable WardResponse wardResponse,
    @Default(false) bool isLoadingWard,
    @nullable Ward selectedWard,
  }) = DataAddress;
}

// Union
@freezed
abstract class PickAddressState with _$PickAddressState {
  const factory PickAddressState.init(DataAddress data) = Initial;
  const factory PickAddressState.loaded(DataAddress data) = Loaded;
  const factory PickAddressState.loading(DataAddress data) = Loading;
}
