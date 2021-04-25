import 'dart:async';

import 'package:farmgate/locator.dart';
import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/location_data.dart';
import 'package:farmgate/src/model/place_response.dart';
import 'package:farmgate/src/model/search_place_request.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simplest/simplest.dart';

part 'user_place_state.dart';

class UserPlaceCubit extends BaseCubit<UserPlaceState> {
  UserPlaceCubit() : super(UserStateInitial());
  bool autoRequestCheckOn = false;
  final locatorLocationService = locator<LocationService>();

  // ignore: cancel_subscriptions
  StreamSubscription streamSubscription;
  FirebaseDatabase database;

  @override
  close() {
    return super.close();
  }

  @override
  initData() async {
    await setCurrentLocation();
  }

  handleCreatedMap() async {
    await Future.delayed(Duration(milliseconds: 500), () {});
  }

  searchPlace(String query) async {
    try {
      emit(BookingChangeStatusSearch("SEARCH", state));
      final response = await dataRepository.searchPlace(
          language: language, region: region, key: apiKey, query: query);
      final status = response.status;
      List<Place> listPlace = Place.parseLocationList(response.toJson());

      emit(BookingSearchPlace(listPlace, status, state));
    } catch (e) {
      handleAppError(e);
    }
  }

  Future<void> changeMyLocation(LatLng tapPoint) async {
    final place = await getPlaceByLatLng(
        latitude: tapPoint.latitude, longitude: tapPoint.longitude);

    emit(BookingChangeMyLocation(place, state));
  }

  Future<void> changeAddPoint(LatLng tapPoint) async {
    List<LatLng> tapPoints = state.listBorder;
    tapPoints.add(tapPoint);
    print("POLYGON " + tapPoints.toString());
    emit(BorderGradenLocation(tapPoints, state));
  }

  Future<void> removePoint(MarkerId markerIdSource) async {
    List<LatLng> tapPoints = state.listBorder;

    tapPoints.removeWhere(
        (element) => element.latitude.toString() == markerIdSource.value);
    emit(RemoveBorderGradenLocation(tapPoints, state));
  }

  Future<void> clearAllPoint() async {
    List<LatLng> tapPoints = [];
    emit(RemoveAllBorderGradenLocation(tapPoints, state));
  }

  Future<void> setCurrentLocation() async {
    try {
      await locatorLocationService.fetchLocation(askPermission: true);
      Position position = locatorLocationService.position;
      final place = await getPlaceByLatLng(
          latitude: position.latitude, longitude: position.longitude);
      emit(BookingCurrentLocation(place, state, false));
    } catch (e) {
      handleAppError(e);
      //logger.e(e);
    }
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
      if (state.myPlace.lat != null) {
        final place = state.myPlace;
        return Place(
            name: place.name,
            formattedAddress: place.formattedAddress,
            lat: place.lat,
            lng: place.lng);
      }
      return Place();
    }
  }

  Future<void> changeMyLocationInSearchTap(Place place) async {
    emit(BookingChangeMyLocationInSearchTap(place, state));
  }

  handleTapGGMap(LatLng tapPoint) async {
    await Future.delayed(Duration(milliseconds: 300));
    await changeMyLocation(tapPoint);
  }

  changeMaptype(MapType mapType) async {
    print('Map Type: ' + mapType.index.toString());
    emit(ChangeMapType(mapType, state));
  }

  Future<void> changePoint(MarkerId markerIdSource, LatLng tapPointNew) async {
    List<LatLng> tapPoints = state.listBorder;
    int position = -1;

    tapPoints.forEach((element) {
      if (element.latitude.toString() == markerIdSource.value) {
        position = tapPoints.indexOf(element);
      }
    });
    if (position != -1) {
      tapPoints[position] = tapPointNew;
      emit(BorderGradenLocation(tapPoints, state));
    }
  }
}
