part of 'user_place_cubit.dart';

class UserPlaceState {
  Place myPlace;
  List<Place> listPlace;
  String statusSearch;
  LocationData locationData;
  bool isLocation;
  List<LatLng> listBorder;
  MapType mapType;

  UserPlaceState(this.myPlace, this.listPlace, this.statusSearch,
      this.locationData, this.isLocation, this.listBorder, this.mapType);

  UserPlaceState.fromState(UserPlaceState state) {
    this.myPlace = state.myPlace;
    this.listPlace = state.listPlace;
    this.statusSearch = state.statusSearch;
    this.locationData = state.locationData;
    this.isLocation = state.isLocation;
    this.listBorder = state.listBorder;
    this.mapType = state.mapType;
  }

  UserPlaceState.fetchingRequest(UserPlaceState state, String statusCheck) {
    this.myPlace = state.myPlace;
    this.listPlace = state.listPlace;
    this.statusSearch = state.statusSearch;
    this.locationData = state.locationData;
    this.isLocation = state.isLocation;
    this.listBorder = state.listBorder;
    this.mapType = state.mapType;
  }

  UserPlaceState.copyWith(
      {bool isDisableDetailAddress,
      bool isDisablePanel,
      bool isDisableBooking,
      bool isDisableGGMap,
      bool isShowLoadingSearch,
      Place myPlace,
      List<Place> listPlace,
      String statusSearch,
      String statusCheck,
      int selectPayment,
      bool checkUseWallet,
      bool isLocation,
      UserPlaceState state,
      LocationData locationData,
      List<LatLng> listBorder,
      MapType mapType}) {
    this.myPlace = myPlace ?? state.myPlace;
    this.listPlace = listPlace ?? state.listPlace;
    this.statusSearch = statusSearch ?? state.statusSearch;
    this.locationData = locationData ?? state.locationData;
    this.isLocation = isLocation ?? state.isLocation;
    this.listBorder = listBorder ?? state.listBorder;
    this.mapType = mapType ?? state.mapType;
  }
}

class UserStateInitial extends UserPlaceState {
  UserStateInitial()
      : super(
            Place(
                name: "YourLocation",
                formattedAddress: "Location",
                lat: 10.851865034040681,
                lng: 106.62311443453213),
            null,
            null,
            null,
            true,
            [],
            MapType.satellite);
}

class BookingCurrentLocation extends UserPlaceState {
  BookingCurrentLocation(Place myPlace, UserPlaceState state, bool isLocation)
      : super.copyWith(
            myPlace: myPlace,
            listPlace: [],
            statusSearch: "NORMAL",
            state: state,
            isLocation: isLocation,
            listBorder: []);
}

class BookingChangeMyLocation extends UserPlaceState {
  BookingChangeMyLocation(Place fromPlace, UserPlaceState state)
      : super.copyWith(
            myPlace: fromPlace,
            listPlace: [],
            statusSearch: "NORMAL",
            listBorder: [],
            state: state);
}

class BorderGradenLocation extends UserPlaceState {
  BorderGradenLocation(List<LatLng> listBorder, UserPlaceState state)
      : super.copyWith(listBorder: listBorder, state: state);
}

class RemoveBorderGradenLocation extends UserPlaceState {
  RemoveBorderGradenLocation(List<LatLng> listBorder, UserPlaceState state)
      : super.copyWith(listBorder: listBorder, state: state);
}

class RemoveAllBorderGradenLocation extends UserPlaceState {
  RemoveAllBorderGradenLocation(List<LatLng> listBorder, UserPlaceState state)
      : super.copyWith(listBorder: listBorder, state: state);
}

class BookingSearchPlace extends UserPlaceState {
  BookingSearchPlace(
      List<Place> listPlace, String statusSearch, UserPlaceState state)
      : super.copyWith(
            listPlace: listPlace, statusSearch: statusSearch, state: state);
}

class BookingChangeStatusSearch extends UserPlaceState {
  BookingChangeStatusSearch(String statusSearch, UserPlaceState state)
      : super.copyWith(statusSearch: statusSearch, state: state);
}

class BookingChangeMyLocationInSearchTap extends UserPlaceState {
  BookingChangeMyLocationInSearchTap(Place myPlace, UserPlaceState state)
      : super.copyWith(myPlace: myPlace, state: state);
}

class ChangeMapType extends UserPlaceState {
  ChangeMapType(MapType mapType, UserPlaceState state)
      : super.copyWith(mapType: mapType, state: state);
}
