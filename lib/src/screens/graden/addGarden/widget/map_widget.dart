import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/util.dart';
import 'package:farmgate/src/model/graden/polygon_garden.dart';
import 'package:farmgate/src/screens/graden/addGarden/bloc/add_garden_cubit.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController mapController;

  BitmapDescriptor bitmapDescriptorSource;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  List<Polygon> polygons = [];

  LatLng position;

  String acreageGarden = '0';

  @override
  Widget build(BuildContext context) {
    List<LocationPolygon> points =
        context.watch<AddGardenCubit>().state.data.list;
    addPolygon(points);
    return _buildBody(context: context);
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

  Future<void> _goToPosition(List<LocationPolygon> points) async {
    position = computeCentroid(points);
    if (mapController == null) return;
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: 14,
        ),
      ),
    );
  }

  Future<void> addPolygon(List<LocationPolygon> points) async {
    if (points == null || points.length == 0) return;
    List<LatLng> polylineCoordinates = [];
    points.forEach((position) {
      polylineCoordinates
          .add(LatLng(position.lat.parseDouble(), position.lng.parseDouble()));
    });
    acreageGarden = calculatePolygonArea(polylineCoordinates);
    Polygon polygon = Polygon(
        polygonId: PolygonId('area'),
        points: polylineCoordinates,
        geodesic: true,
        strokeColor: Colors.blue,
        strokeWidth: 2,
        fillColor: Colors.blue.withOpacity(0.1),
        visible: true);
    polygons.add(polygon);
    _goToPosition(points);
  }

  Widget _buildBody({BuildContext context}) {
    return Container(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.watch<AddGardenCubit>().state.data.list.length == 0
                ? InkWell(
                    onTap: () {
                      navigator
                          .pushNamed(AppRoute.gradenBoderScreen)
                          .then((value) => {
                                if (value != null)
                                  {
                                    context
                                        .read<AddGardenCubit>()
                                        .addBoder(value)
                                  }
                              });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: appIconColor)),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/add_google_map.svg',
                            width: 60,
                            height: 60,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'add_border_farm'.tr,
                            textAlign: TextAlign.center,
                            style: titleBar.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: appIconColor)),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          child: GoogleMap(
                            markers: Set<Marker>.of(markers.values),
                            mapType: MapType.hybrid,
                            myLocationButtonEnabled: false,
                            initialCameraPosition: CameraPosition(
                              target:
                                  LatLng(position.latitude, position.longitude),
                              zoom: 14.0,
                            ),
                            onMapCreated:
                                (GoogleMapController controller) async {
                              mapController = controller;
                            },
                            polygons: Set<Polygon>.of(polygons),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(8),
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: linearGradient),
                            child: Text(
                              '${acreageGarden} m\u00B2',
                              style: body1.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 10,
                          child: RawMaterialButton(
                            onPressed: () {
                              navigator
                                  .pushNamed(AppRoute.gradenBoderScreen)
                                  .then((value) => {
                                        if (value != null)
                                          {
                                            context
                                                .read<AddGardenCubit>()
                                                .addBoder(value)
                                          }
                                      });
                            },
                            elevation: 2.0,
                            fillColor: Colors.white,
                            child: Icon(Icons.edit,
                                size: 30.0, color: appIconColor),
                            padding: EdgeInsets.all(6.0),
                            shape: CircleBorder(),
                          ),
                        )
                      ],
                    ),
                  )
          ],
        ));
  }
}
