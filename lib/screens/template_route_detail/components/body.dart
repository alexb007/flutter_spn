import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:spn_flutter/models/marker.dart';
import 'package:spn_flutter/models/place.dart';
import 'package:spn_flutter/models/route.dart';
import 'package:spn_flutter/provider/route.dart';
import 'package:spn_flutter/screens/home/home_screen.dart';
import 'package:spn_flutter/screens/template_route_detail/utils/route_util.dart';
import 'package:spn_flutter/services/openroute/openrouteservice.dart';
import 'package:spn_flutter/services/overpass/overpass_api.dart';
import 'package:spn_flutter/utils/geemetrydecoder.dart';
import 'package:spn_flutter/widgets/buttons/bottom_action_button.dart';

import 'route_planner.dart';

class Body extends StatefulWidget {
  final RouteModel walkRoute;

  Body(this.walkRoute);

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // MapBox initialization
  MapboxMapController mapController;
  List<Symbol> symbols = List<Symbol>();
  List<Line> lines = [];
  List<RouteModel> routes = [];
  String _styleString = "mapbox://styles/alexb007/ck0vsyxyr0yoy1dp7vj0rfy3l";
  MyLocationTrackingMode _myLocationTrackingMode =
      MyLocationTrackingMode.Tracking;
  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(44.527947, 11.369936),
    zoom: 11.0,
  );

  // ProgressDialog
  ProgressDialog pr;

  var location = new Location();
  var loading = true;
  var loadingRoutes = true;
  List<PlaceOptions> nearbyPlaces = [];
  var progressString = "Loading places";


  var selectedRouteIndex = 0;

  @override
  void dispose() {
    mapController.removeListener(_onMapChanged);
    super.dispose();
  }

  Future<void> _extractMapInfo() {
    return null;
  }

  void _onMapChanged() {
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> checkLocationPermissions() async {
//    if (!(await location.hasPermission())) {
//      await location.requestPermission();
//    }
  }

  void onMapCreated(MapboxMapController controller) async {
    mapController = controller;

//      mapController.addListener(_onMapChanged);
    _extractMapInfo();
    pr.show();
    await _findNearbyPlaces();
  }

  Future _generateRoutes(int alternatives) async {
    var loc = await location.getLocation();
    for (var routeindex = 0; routeindex < alternatives; routeindex++) {
      var route = RouteModel(
        categories: widget.walkRoute.categories,
        title: widget.walkRoute.title,
        description: widget.walkRoute.description,
      );
      var indexes = List.generate(nearbyPlaces.length, (i) => i);
      indexes.shuffle();
      route.points = [];
      route.points.add(Marker(
        title: 'My geolocation',
        geometry: LatLng(loc.latitude, loc.longitude),
        type: MarkerTypes.MY_LOCATION,
      ));
      indexes.getRange(0, 2 + Random().nextInt(6)).forEach((index) {
        setState(() {
          route.points.add(
            Marker(
                title: nearbyPlaces[index].overpassNode.tags.name,
                geometry: LatLng(nearbyPlaces[index].overpassNode.lat,
                    nearbyPlaces[index].overpassNode.lon),
                address:
                "${nearbyPlaces[index].overpassNode.tags.addrStreet}",
                iconImage: "dr_${nearbyPlaces[index].category.code}"),
          );
        });
      });
      route.points.add(Marker(
          title: 'My geolocation',
          geometry: LatLng(loc.latitude, loc.longitude),
          type: MarkerTypes.DESTINATION,
          iconImage: "dr_finish"));
      var points = route.points.map((marker) {
        return [marker.geometry.longitude, marker.geometry.latitude];
      }).toList();
      var orsResponse = await OpenRouteService().getRoute(points);
      orsResponse.routes.forEach((routeData) {
        route.distance = routeData.summary.distance;
        route.duration = routeData.summary.duration;
        var geometry = GeometryDecoder.decodeGeometry(routeData.geometry);
        route.linesGeometry = geometry.map((way) {
          return LatLng(way[0], way[1]);
        }).toList();
      });
      mapController.moveCamera(
          CameraUpdate.newLatLng(LatLng(loc.latitude, loc.longitude)));
      setState(() {
        routes.add(route);
      });
    }
    await _showMarkers(routes.first);
    await _createRouteNavigation(routes.first);
    setState(() {
      loadingRoutes = false;
      pr.hide();
    });
  }


  Future _findNearbyPlaces() async {
    for (int i = 0; i < widget.walkRoute.categories.length; i++) {
      var category = widget.walkRoute.categories[i];
      var latLng = await location.getLocation();
      var tags = RouteUtil.getCategoryTags(category);
      if (tags != null && tags.length > 0) {
        var response = await OverpassAPI().getNodesByTags(tags,
            radius: 3000, latLng: LatLng(latLng.latitude, latLng.longitude));
        setState(() {
          response.elements.forEach((node) {
            nearbyPlaces.add(PlaceOptions(null, node.tags.name, category,
                overpassNode: node));
          });
        });
      }
    }
    await _generateRoutes(3);
  }

  Future _showMarkers(RouteModel route) async {
    route.points.forEach((point) {
      if (point.type != MarkerTypes.MY_LOCATION) {
        mapController
            .addSymbol(SymbolOptions(
            geometry: point.geometry, iconImage: point.iconImage))
            .then((symbol) {
          setState(() {
            symbols.add(symbol);
          });
        });
      }
    });
  }

  Future<void> _createRouteNavigation(RouteModel route) async {
    var line = mapController.addLine(
      LineOptions(
          geometry: route.linesGeometry,
          lineWidth: 8,
          lineOpacity: 0.7,
          lineColor: '#0000ff'),
    );
    line.then((line) {
      lines.add(line);
    });
  }



  @override
  Widget build(BuildContext context) {


    pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
      message: progressString,
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(

      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w700),
    );



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
          loadingRoutes
              ? Container()
              : Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: RoutePlanner(
                    routes: routes,
                    mapController: mapController,
                    onRouteSelected: (routeIndex) {
                      lines.forEach((line) {
                        mapController.removeLine(line);
                      });
                      lines = [];
                      symbols.forEach((symbol) {
                        mapController.removeSymbol(symbol);
                      });
                      symbols = [];
                      _showMarkers(routes[routeIndex]).then((res) {
                        _createRouteNavigation(routes[routeIndex])
                            .then((res) {});
                      });
                      setState(() {
                        selectedRouteIndex = routeIndex;
                      });
                    },
                  ),
                ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: BottomActionButton(
                text: 'CHOOSE AND CONTINUE',
                onPressed: () {
                  Provider.of<RouteProvider>(context).route =
                      routes[selectedRouteIndex];
                  Provider.of<RouteProvider>(context).routeState = 2;
                  Navigator.of(context).popUntil((route) => route.settings.name == HomeScreen.route);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
