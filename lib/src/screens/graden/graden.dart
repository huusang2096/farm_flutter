import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/util.dart';
import 'package:farmgate/src/model/graden/graden_response.dart';
import 'package:farmgate/src/model/graden/polygon_garden.dart';
import 'package:farmgate/src/screens/graden/bloc/graden_state.dart';
import 'package:farmgate/src/screens/graden/widget/item_garden_widget.dart';
import 'package:farmgate/src/screens/graden/widget/map_pin_pill_widget.dart';
import 'package:farmgate/src/screens/shimmer/graden_simmer.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:farmgate/src/widgets/logo_widget.dart';
import 'package:farmgate/src/widgets/reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

import 'bloc/graden_cubit.dart';

class MyGradenScreen extends CubitWidget<GradenCubit, GradenState> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GoogleMapController _controller;
  BitmapDescriptor bitmapDescriptorSource, bitmapDescriptorDes;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<Polygon> polygons = [];
  MyGarden sourcePinInfo;

  static provider() {
    return BlocProvider(
      create: (context) => GradenCubit(),
      child: MyGradenScreen(),
    );
  }

  @override
  void listener(BuildContext context, GradenState state) {
    if (state is ListGraden) {
      // Add markers
      state.data.myGarden.forEach((myGarden) {
        addMarkerSource(myGarden, context);
        addPolygon(myGarden);
      });
    }
    super.listener(context, state);
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    super.afterFirstLayout(context);
    context.read<GradenCubit>().getMyGarden();
    bitmapDescriptorSource =
        await createBitmapDescriptor(context, "assets/images/tree.png");
  }

  Future<void> addMarkerSource(MyGarden myGarden, BuildContext context) async {
    if (myGarden == null) return;
    final MarkerId markerIdSource = MarkerId(myGarden.id.toString());
    final LatLng position = computeCentroid(myGarden.locationPolygon);

    //custom infowindow

    final Marker marker = Marker(
      markerId: markerIdSource,
      icon: bitmapDescriptorSource,
      position: LatLng(position.latitude, position.longitude),
      onTap: () {
        context.read<GradenCubit>().updatePinPillPosition(300, myGarden);
      },
    );
    markers[markerIdSource] = marker;
  }

  Future<void> addPolygon(MyGarden myGarden) async {
    if (myGarden == null) return;
    List<LatLng> polylineCoordinates = [];
    myGarden.locationPolygon.forEach((position) {
      polylineCoordinates
          .add(LatLng(position.lat.parseDouble(), position.lng.parseDouble()));
    });
    Polygon polygon = Polygon(
        polygonId: PolygonId('area'),
        points: polylineCoordinates,
        geodesic: true,
        strokeColor: Colors.blue,
        strokeWidth: 2,
        fillColor: Colors.blue.withOpacity(0.1),
        visible: true);
    polygons.add(polygon);
  }

  @override
  Widget builder(BuildContext context, GradenState state) {
    void _onRefresh() async {
      context.read<GradenCubit>().getMyGarden();
      _refreshController.refreshCompleted();
    }

    buildGoogleMap(BuildContext context, GradenState state) {
      return Stack(
        children: [
          GoogleMap(
            markers: Set<Marker>.of(markers.values),
            // markers: _markers,
            mapType: MapType.satellite,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(10.805318385490796, 106.69825758941059),
              zoom: 11.0,
            ),
            onMapCreated: (GoogleMapController controller) async {
              _controller = controller;
            },
            onTap: (LatLng location) {
              context.read<GradenCubit>().updatePinPillPosition(-500, null);
            },
            polygons: Set<Polygon>.of(polygons),
          ),
          state.data != null
              ? MapPinPillWidget(
                  pinPillPosition: state.data.pinPillPosition,
                  currentlySelectedPin: state.data.currentlySelectedPin)
              : SizedBox.shrink(),
        ],
      );
    }

    return AppProgressHUB(
      inAsyncCall: state.data.isLoadingScaffold,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: greyColor),
          title: LogoWidget(
            urlImg: Images.logoIcon,
            bottom: 0,
          ),
          elevation: 1.0,
          actions: <Widget>[
            IconButton(
                icon:
                    Icon(state.data.isGardenMap ? Icons.list : Icons.map_sharp),
                color: appIconColor,
                onPressed: () {
                  context.read<GradenCubit>().changeMapGarden();
                }),
          ],
        ),
        body: state.data.isGardenMap
            ? buildGoogleMap(context, state)
            : SmartRefresher(
                controller: _refreshController,
                header: ReloadWidget(),
                enablePullDown: true,
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                    child: state.data.myGarden.length == 0
                        ? GardenShimmer()
                        : ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              MyGarden myGarden =
                                  state.data.myGarden.elementAt(index);
                              return index == 0
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 12.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            navigator
                                                .pushNamed(
                                                    AppRoute.addGardenScreen)
                                                .then((value) => {
                                                      context
                                                          .read<GradenCubit>()
                                                          .getMyGarden()
                                                    });
                                          },
                                          child: DottedBorder(
                                            borderType: BorderType.RRect,
                                            radius: Radius.circular(12),
                                            color: Colors.grey,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              child: Container(
                                                height: 200,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.grey,
                                                    size: 70,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                    )
                                  : ItemGradenWidget(
                                      herotag: getRandomString(20),
                                      myGarden: myGarden);
                            },
                            itemCount: state.data.myGarden.length,
                            separatorBuilder: (context, _) =>
                                const SizedBox(height: 1.0),
                          ))),
      ),
    );
  }

  LatLng computeCentroid(List<LocationPolygon> points) {
    double latitude = 0;
    double longitude = 0;
    int n = points.length;

    points.forEach((point) {
      latitude += point.lat.parseDouble();
      longitude += point.lng.parseDouble();
    });
    return new LatLng(latitude / n, longitude / n);
  }
}
