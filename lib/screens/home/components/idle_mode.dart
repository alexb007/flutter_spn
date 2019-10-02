import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:spn_flutter/screens/create_walk/create_walk_screen.dart';

class IdleMode extends StatefulWidget {

  MapboxMapController mapController;

  IdleMode({this.mapController});

  @override
  State<StatefulWidget> createState() => _IdleModeState();

}

class _IdleModeState extends State<IdleMode> {

  var city = 'Bologne';
  var formatter = NumberFormat('###.#');
  Location location = Location();


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.only(
                  left: 24, top: 56, right: 24, bottom: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Enter address",
                  hintStyle: TextStyle(
                    color: Colors.black26,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            MaterialButton(
                padding: EdgeInsets.all(8),
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                onPressed: () {
                  // TODO Change city button
                },
                child: Container(
                  width: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Text(
                        city,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.chevron_right),
                      )
                    ],
                  ),
                ))
          ],
        ),
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
                      onPressed: () async {
                        var myLoc = await location.getLocation();
                        widget.mapController.moveCamera(CameraUpdate.newLatLng(
                            LatLng(myLoc.latitude, myLoc.longitude)));
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
                  'Create a walk',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
                onPressed: () async {
                  Navigator.of(context).pushNamed(CreateWalkScreen.route);
                },
              ),
            )
          ],
        )
      ],
    );
  }

}