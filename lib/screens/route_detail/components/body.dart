import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:spn_flutter/models/route.dart';
import 'package:spn_flutter/screens/route_detail/components/route_planner.dart';
import 'package:spn_flutter/services/openroute/openrouteservice.dart';
import 'package:spn_flutter/services/overpass/overpass_api.dart';
import 'package:spn_flutter/utils/geemetrydecoder.dart';
import 'package:spn_flutter/widgets/buttons/bottom_action_button.dart';


class Body extends StatefulWidget {
  final RouteModel walkRoute;

  Body(this.walkRoute);

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  MapboxMapController mapController;
  List<Symbol> symbols = List<Symbol>();
  List<Line> lines = [];


  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(44.527947, 11.369936),
    zoom: 11.0,
  );

  var location = new Location();
  var loading = false;


  String _styleString = "mapbox://styles/alexb007/ck0vsyxyr0yoy1dp7vj0rfy3l";
  MyLocationTrackingMode _myLocationTrackingMode =
      MyLocationTrackingMode.Tracking;

  @override
  void dispose() {
    mapController.removeListener(_onMapChanged);
    super.dispose();
  }

  Future _extractMapInfo() {
    return null;
  }

  void _onMapChanged() {
    setState(() {
      _extractMapInfo();
    });
  }

  @override
  void initState() {
    checkLocationPermissions();

    super.initState();
  }

  Future<void> checkLocationPermissions() async {
    if (!(await location.hasPermission())) {
      await location.requestPermission();
    }
  }

  Future loadShops() async {
    var target = mapController.cameraPosition.target;
    var response = await OverpassAPI().getNodesByType(
        OverpassAPI.ATM,
        new LatLngBounds(
            southwest: LatLng(target.latitude - 0.1, target.longitude - 0.1),
            northeast: LatLng(target.latitude + 0.1, target.longitude + 0.1)));
    response.elements.forEach((element) {
      mapController.addSymbol(SymbolOptions(
          geometry: LatLng(element.lat, element.lon), iconImage: 'shop-11')).then((symbol) {
            symbols.add(symbol);
      });
    });
    mapController.moveCamera(
        CameraUpdate.newLatLng(mapController.cameraPosition.target));
  }

  @override
  Widget build(BuildContext context) {
    void onMapCreated(MapboxMapController controller) async {
      mapController = controller;

      mapController.addListener(_onMapChanged);
      _extractMapInfo();
      loadShops().then((response) {});
      var points = widget.walkRoute.points.map((marker) {
        return [marker.geometry.longitude, marker.geometry.latitude];
      }).toList();
      OpenRouteService().getRoute(points).then((response) {
        response.routes.forEach((route) {
          var geometry = GeometryDecoder.decodeGeometry(route.geometry);
          var line = mapController.addLine(
            LineOptions(
                geometry: geometry.map((way) {
                  return LatLng(way[0], way[1]);
                }).toList(),
                lineWidth: 8,
                lineOpacity: 0.7,
                lineColor: '#0000ff'),
          );
          line.then((line) {
            lines.add(line);
          });
        });
        mapController
            .moveCamera(CameraUpdate.newLatLng(LatLng(44.527947, 11.369936)));
      });
    }

    var map = MapboxMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: _kInitialPosition,
        trackCameraPosition: true,
        compassEnabled: false,
        styleString: _styleString,
        myLocationEnabled: true,
        onMapClick: (point, latLng) async {},
        myLocationTrackingMode: _myLocationTrackingMode,
        onCameraTrackingDismissed: () {
          this.setState(() {
            _myLocationTrackingMode = MyLocationTrackingMode.None;
          });
        });
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          map,
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: RoutePlanner(
                templateWalk: widget.walkRoute,
                mapController: mapController,
                canEdit: true,
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: BottomActionButton(
                text: 'CREATE A WALK',
                onPressed: () async {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
