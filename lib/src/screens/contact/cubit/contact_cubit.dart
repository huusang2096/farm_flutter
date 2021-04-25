import 'package:farmgate/locator.dart';
import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/contact/contact_request.dart';
import 'package:farmgate/src/model/contact/contact_response.dart';
import 'package:farmgate/src/model/place_response.dart';
import 'package:farmgate/src/model/search_place_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simplest/simplest.dart';

part 'contact_state.dart';
part 'contact_cubit.freezed.dart';

class ContactCubit extends BaseCubit<ContactState> {
  final locatorLocationService = locator<LocationService>();
  ContactCubit() : super(Initial(Data()));

  void sendContact(String name, String content, String email,
      {String address, String subject, String phone}) async {
    ContactRequest request = ContactRequest();
    request.name = appPref.getUser().data.lastName ?? "";
    request.content = content;
    request.email = appPref.getUser().data.email ?? "customer@gmail.com";
    request.phone = appPref.getUser().data.phone ?? "";
    request.address = address ?? '';
    request.subject = 'send_contact'.tr;
    try {
      emit(Loading(state.data.copyWith(isLoading: true)));
      final response = await dataRepository.contact(request);
      showErrorSnakeBar(response.message);
      emit(SendContact(state.data));
    } catch (e) {
      handleAppError(e);
    }
    emit(Loading(state.data.copyWith(isLoading: false)));
  }

  placeChange(Place myPlace) {
    emit(PlaceChange(state.data.copyWith(myPlace: myPlace)));
  }

  Future<void> setCurrentLocation() async {
    try {
      emit(Loading(state.data.copyWith(isLoadingAddress: true)));
      await locatorLocationService.fetchLocation(askPermission: true);
      Position position = locatorLocationService.position;
      final place = await getPlaceByLatLng(
          latitude: position.latitude, longitude: position.longitude);
      emit(PlaceChange(state.data.copyWith(myPlace: place)));
    } catch (e) {
      handleAppError(e);
      //logger.e(e);
    }
    emit(Loading(state.data.copyWith(isLoadingAddress: false)));
  }

  Future<Place> getPlaceByLatLng({double latitude, double longitude}) async {
    try {
      String latLng = latitude.toString() + "," + longitude.toString();
      Place place = new Place();
      final searchPlaceRequest = new SearchPlaceRequest(
        key: apiKey,
        language: language,
        region: region,
        latLng: latLng,
      );
      final response =
          await dataRepository.searchPlaceByLatLng(searchPlaceRequest);

      final listResults = response.results ?? [];
      if (response.results.length > 0) {
        place.formattedAddress = listResults.first.formattedAddress ?? "";
        place.lat = latitude;
        place.lng = longitude;
        place.name = listResults.first.formattedAddress ?? "";
      } else {
        place.formattedAddress = "TP Hồ Chí Minh";
        place.lat = latitude;
        place.lng = longitude;
        place.name = "";
      }
      return place;
    } catch (e) {
      handleAppError(e);
      return Place();
    }
  }
}
