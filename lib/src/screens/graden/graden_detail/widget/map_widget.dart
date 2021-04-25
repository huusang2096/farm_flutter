import 'dart:async';

import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/util.dart';
import 'package:farmgate/src/model/graden/graden_response.dart';
import 'package:farmgate/src/model/graden/polygon_garden.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class MapWidget extends StatefulWidget {
  final MyGarden data;

  MapWidget(this.data);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget>
    with AutomaticKeepAliveClientMixin {
  GoogleMapController _controller;

  BitmapDescriptor bitmapDescriptorSource;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  List<Polygon> polygons = [];

  LatLng position;

  String acreageGarden = '0';

  @override
  void initState() {
    getImage(context);
    addMarkerSource(widget.data);
    addPolygon(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context: context);
  }

  Future<Widget> getImage(BuildContext context) async {
    bitmapDescriptorSource =
        await createBitmapDescriptor(context, "assets/images/sprout.png");
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

  Future<void> addMarkerSource(MyGarden myGarden) async {
    if (myGarden == null) return;
    final MarkerId markerIdSource = MarkerId(myGarden.id.toString());
    position = computeCentroid(myGarden.locationPolygon);
    final Marker marker = Marker(
        markerId: markerIdSource,
        icon: bitmapDescriptorSource,
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(
          title: myGarden.name,
          snippet: myGarden.description,
        ));
    markers[markerIdSource] = marker;
  }

  Future<void> addPolygon(MyGarden myGarden) async {
    if (myGarden == null) return;
    List<LatLng> polylineCoordinates = [];
    myGarden.locationPolygon.forEach((position) {
      polylineCoordinates
          .add(LatLng(position.lat.parseDouble(), position.lng.parseDouble()));
    });
    print(calculatePolygonArea(polylineCoordinates));
    acreageGarden = calculatePolygonArea(polylineCoordinates);
    Polygon polygon = Polygon(
        polygonId: PolygonId('area'),
        points: polylineCoordinates,
        geodesic: true,
        strokeColor: Colors.blue,
        strokeWidth: 2,
        fillColor: Colors.blue.withOpacity(0.3),
        visible: true);
    polygons.add(polygon);
  }

  Widget _buildBody({BuildContext context}) {
    return Container(
        height: 300,
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
              child: Text(
                'area'.tr,
                style: titleNew,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
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
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(position.latitude, position.longitude),
                        zoom: 14.0,
                      ),
                      onMapCreated: (GoogleMapController controller) async {
                        _controller = controller;
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
                ],
              ),
            )
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
