import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:spn_flutter/screens/create_walk/create_walk_screen.dart';
import 'package:spn_flutter/services/overpass/overpass_api.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var points = [
    [11.369936, 44.527947],
    [11.372401, 44.515898],
    [11.39569, 44.490932]
  ];
  String city = "Bologne";

  MapboxMapController mapController;

  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(44.527947, 11.369936),
    zoom: 11.0,
  );

  var location = new Location();

  String _styleString = "mapbox://styles/alexb007/cjzyj2spd0aun1cmohtwgps94";
  MyLocationTrackingMode _myLocationTrackingMode =
      MyLocationTrackingMode.Tracking;

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

  Future loadShops() async {
    var target = mapController.cameraPosition.target;
    var response = await OverpassAPI().getNodesByName(
        "shop",
        new LatLngBounds(
            southwest: LatLng(target.latitude - 0.1, target.longitude - 0.1),
            northeast: LatLng(target.latitude + 0.1, target.longitude + 0.1)));
    response.elements.forEach((element) {
      mapController.addSymbol(SymbolOptions(
          geometry: LatLng(element.lat, element.lon), iconImage: 'shop-11'));
    });
  }

  Future<void> checkLocationPermissions() async {
    if (!(await location.hasPermission())) {
      await location.requestPermission();
    }
  }

  @override
  void initState() {
    checkLocationPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onMapCreated(MapboxMapController controller) async {
      mapController = controller;

      mapController.addListener(_onMapChanged);
      _extractMapInfo();
      loadShops().then((result) {});
      setState(() {});
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

    return Material(
      child: Stack(
        children: <Widget>[
          map,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 16, bottom: 16),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          FloatingActionButton(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            mini: true,
                            onPressed: () {

                            },
                            child: Icon(Icons.location_searching),
                          )
                        ],
                      )),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      color: Colors.blueAccent,
                      child: Text(
                        'Find a place',
                        style: TextStyle(
                            decorationStyle: TextDecorationStyle.dotted,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                      onPressed: () async {
                        mapController.removeListener(_onMapChanged);
                        Navigator.of(context).pushNamed(CreateWalkScreen.route);
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
