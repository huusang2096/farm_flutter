import 'dart:async';

import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/util.dart';
import 'package:farmgate/src/model/graden/map_type.dart';
import 'package:farmgate/src/screens/location/cubit/user_place_cubit.dart';
import 'package:farmgate/src/screens/location/widget/detail_address_widget.dart';
import 'package:farmgate/src/screens/location/widget/maptype_item_widget.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:farmgate/src/widgets/rouned_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simplest/simplest.dart';

class UserPlaceScreen extends CubitWidget<UserPlaceCubit, UserPlaceState> {
  UserPlaceScreen();

  static provider() {
    return BlocProvider(
      create: (context) => UserPlaceCubit(),
      child: UserPlaceScreen(),
    );
  }

  GoogleMapController _controller;

  // for my drawn routes on the map
  List<LatLng> polylineCoordinates = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor bitmapDescriptorSource, bitmapDescriptorDes;

  @override
  void afterFirstLayout(BuildContext context) async {
    //set icon map;
    bitmapDescriptorSource =
        await createBitmapDescriptor(context, "assets/images/ic_marker_48.png");
    bitmapDescriptorDes =
        await createBitmapDescriptor(context, "assets/images/ic_marker_48.png");
  }

  @override
  void listener(BuildContext context, UserPlaceState state) async {
    if (state is BookingChangeMyLocationInSearchTap) {
      await addMarkerSource(state);
      _goToPosition(LatLng(state.myPlace.lat, state.myPlace.lng));
    }

    if (state is BookingChangeMyLocation) {
      await addMarkerSource(state);
    }

    if (state is BookingCurrentLocation) {
      await addMarkerSource(state);
      if (state.myPlace?.lat != null) {
        _goToPosition(LatLng(state.myPlace.lat, state.myPlace.lng));
      }
    }
    super.listener(context, state);
  }

  Future<void> addMarkerSource(UserPlaceState state) async {
    if (state.myPlace?.lat != null) {
      final MarkerId markerIdSource = MarkerId("sourcePin");
      final Marker marker = Marker(
        markerId: markerIdSource,
        icon: bitmapDescriptorSource,
        position: LatLng(state.myPlace.lat, state.myPlace.lng),
      );
      markers[markerIdSource] = marker;
    }
  }

  Future<void> _goToPosition(LatLng latLng) async {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          //target: LatLng(37.42796133580664, -122.085749655962),
          target: latLng,
          zoom: 16,
        ),
      ),
    );
  }

  @override
  Widget builder(BuildContext context, UserPlaceState state) {
    Size size = MediaQuery.of(context).size;

    buildGoogleMap() {
      return GoogleMap(
        onTap: (tapPoint) {
          context.read<UserPlaceCubit>().handleTapGGMap(tapPoint);
        },
        markers: Set<Marker>.of(markers.values),
        mapType: context.read<UserPlaceCubit>().state.mapType,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(context.watch<UserPlaceCubit>().state.myPlace.lat ?? 0,
              context.watch<UserPlaceCubit>().state.myPlace.lng ?? 0),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) async {
          _controller = controller;
          context.read<UserPlaceCubit>().handleCreatedMap();
        },
      );
    }

    return AppProgressHUB(
      inAsyncCall: state.isLocation,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: state.mapType == MapType.terrain ||
                      state.mapType == MapType.normal
                  ? Color(0xFF467A76)
                  : Colors.white),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              margin: EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  _showMapType(context);
                },
                child: SvgPicture.asset(
                  'assets/images/map.svg',
                  width: 30,
                  height: 30,
                  color: state.mapType == MapType.terrain ||
                          state.mapType == MapType.normal
                      ? appIconColor
                      : Colors.white,
                ),
              ),
            )
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop();
            return true;
          },
          child: Stack(
            children: [
              buildGoogleMap(),
              DetailAddress(
                size: size,
                state: state,
                onPressLocation: () async {
                  await context.read<UserPlaceCubit>().setCurrentLocation();
                },
                onPressAddress: () {
                  Navigator.of(context).pushNamed(AppRoute.searchPlaceScreen,
                      arguments: {'cubit': context.read<UserPlaceCubit>()});
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: Center(
                    child: RounedFlatButton(
                      onPress: () {
                        navigator.pop(state.myPlace);
                      },
                      child: Text(
                        'add_location'.tr,
                        style: textButton,
                      ),
                      color: Colors.white,
                      borderRadius: 30,
                      height: 50,
                      width: 160,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> _showMapType(BuildContext context) async {
    final cubit = context.read<UserPlaceCubit>();
    List<MapTypeModel> mapTypes = new MapTypeModel().getListMapType();
    await showModalBottomSheet(
        elevation: 10,
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext builder) {
          return StatefulBuilder(
            builder: (context, state) {
              return AnimatedPadding(
                padding: MediaQuery.of(context).viewInsets,
                duration: const Duration(milliseconds: 10),
                curve: Curves.decelerate,
                child: SingleChildScrollView(
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                          color: Colors.white),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  width: 60,
                                  height: 5,
                                ),
                                Container(
                                  width: 60,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 20, top: 20),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                      gradient: linearGradient,
                                    ),
                                    child:
                                        Icon(Icons.close, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text('change_maptype'.tr,
                                  style:
                                      titleNew.copyWith(color: appIconColor)),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 4,
                                        crossAxisSpacing: 4,
                                        childAspectRatio: 2.0),
                                itemCount: mapTypes.length,
                                itemBuilder: (context, index) {
                                  MapType mapType =
                                      mapTypes.elementAt(index).acitonType;
                                  return MapTypeItemWidget(
                                    icon: mapTypes.elementAt(index).image,
                                    mapTypeName:
                                        mapTypes.elementAt(index).title.tr,
                                    mapType:
                                        mapTypes.elementAt(index).acitonType,
                                    onSelectMapType: (mapType) async {
                                      await cubit.changeMaptype(
                                          mapTypes.elementAt(index).acitonType);
                                      navigator.pop();
                                    },
                                  );
                                },
                              ),
                            ),
                          ])),
                ),
              );
            },
          );
        });
  }
}
