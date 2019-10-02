import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
import 'package:spn_flutter/data/db/config/base.dart';
import 'package:spn_flutter/data/db/database.dart';
import 'package:spn_flutter/models/marker.dart';
import 'package:spn_flutter/models/route.dart';
import 'package:spn_flutter/provider/route.dart';
import 'package:spn_flutter/screens/create_walk/create_walk_screen.dart';
import 'package:spn_flutter/screens/home/components/idle_mode.dart';
import 'package:spn_flutter/screens/home/components/navigation_mode.dart';
import 'package:spn_flutter/screens/home/components/route_detail.dart';
import 'package:spn_flutter/services/overpass/overpass_api.dart';

class HomeBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String city = "Bologne";

  AppDatabase db;

  MapboxMapController mapController;

  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(44.527947, 11.369936),
    zoom: 11.0,
  );

  var location = new Location();
  var homeMode = 1; // 1 - idle, 2 - route detail, 3 - navigation

  String _styleString = "mapbox://styles/alexb007/ck0vsyxyr0yoy1dp7vj0rfy3l";
  MyLocationTrackingMode _myLocationTrackingMode =
      MyLocationTrackingMode.Tracking;

  var categoryIds = [1, 6, 10, 27, 36];

  @override
  void dispose() {
    mapController.removeListener(_onMapChanged);
    super.dispose();
  }

  void _extractMapInfo() {}

  void _onMapChanged() {
    setState(() {
      _extractMapInfo();
    });
  }

  Future loadPlaces() async {
    var curLoc = await location.getLocation();
    for (int catIndex = 0; catIndex < categoryIds.length; catIndex++) {
      var categoryChilds =
          await db.categoryDao.getCategoryChildren(categoryIds[catIndex]);
      var tags = categoryChilds
          .map((category) =>
              category.tags.split(",").map((tag) => tag.split(':')).toList())
          .toList()
          .expand((i) => i)
          .toList()
          .where((e) => e[0].length > 0)
          .toList();
      var response = await OverpassAPI().getNodesByTags(tags,
          radius: 15000, latLng: LatLng(curLoc.latitude, curLoc.longitude));
      var symbols = response.elements.map((element) {
        return SymbolOptions(
            geometry: LatLng(element.lat, element.lon),
            iconImage: "pd_${categoryChilds.first.code}");
      }).toList();

      mapController.addAllSymbol(symbols);
    }
  }

  Future<void> checkLocationPermissions() async {
    if (!(await location.hasPermission())) {
      await location.requestPermission();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void onMapCreated(MapboxMapController controller) async {
    mapController = controller;
    await checkLocationPermissions();
    db = await Floor.instance.database;

    await loadPlaces();
    _extractMapInfo();
  }

  @override
  Widget build(BuildContext context) {
    final MapboxMap map = MapboxMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: _kInitialPosition,
        trackCameraPosition: true,
        compassEnabled: false,
        styleString: _styleString,
        myLocationEnabled: true,
        onMapClick: (point, latLng) async {},
        myLocationTrackingMode: _myLocationTrackingMode,
        onCameraTrackingDismissed: () {
          setState(() {
            _myLocationTrackingMode = MyLocationTrackingMode.None;
          });
        });
    homeMode = Provider.of<RouteProvider>(context).routeState;
    return Material(
      child: Stack(
        children: <Widget>[
          map,
          homeMode == 1
              ? IdleMode(
                  mapController: mapController,
                )
              : homeMode == 2
                  ? RouteDetail(
                      onCancel: () {
                        Provider.of<RouteProvider>(context).routeState = 1;
                      },
                      onStart: () {
                        Provider.of<RouteProvider>(context).routeState = 3;
                      },
                    )
                  : NavigationMode(
                      elapsedTime: 0,
                      passedDistance: 0,
                    )
        ],
      ),
    );
  }
}
