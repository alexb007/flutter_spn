import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:spn_flutter/models/category.dart';
import 'package:spn_flutter/models/marker.dart';
import 'package:spn_flutter/models/route.dart';
import 'package:spn_flutter/services/overpass/overpass_api.dart';
import 'package:spn_flutter/styles/text_styles.dart';

class PlaceSelector extends StatefulWidget {
  final Category category;
  final RouteModel route;
  final MapboxMapController mapController;

  PlaceSelector({this.category, this.route, this.mapController});

  @override
  State<StatefulWidget> createState() => _PlaceSelectorState();
}

class MarkerSelection {
  bool isSelected = false;
  Marker marker;

  MarkerSelection({this.isSelected, @required this.marker});
}

class _PlaceSelectorState extends State<PlaceSelector> {
  List<MarkerSelection> markers = [];
  List<MarkerSelection> selectedPoints = [];

  @override
  void initState() {
    var target = widget.mapController.cameraPosition.target;
    var bounds = new LatLngBounds(
        southwest: LatLng(target.latitude - 0.1, target.longitude - 0.1),
        northeast: LatLng(target.latitude + 0.1, target.longitude + 0.1));
    OverpassAPI().getNodesByName(widget.category.code, bounds).then((response) {
      response.elements.forEach((element) {
        markers.add(MarkerSelection(marker: Marker(title: element.tags.name)));
        widget.mapController.addSymbol(SymbolOptions(
            geometry: LatLng(element.lat, element.lon),
            iconImage: widget.category.symbol));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Wrap(
        children: <Widget>[
          AppBar(
            title: Text(
              widget.category.title,
              style: TextStyles.st5,
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            elevation: 1.0,
          ),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: markers.length,
                itemBuilder: (context, index) => ListTile(
                      leading: Checkbox(
                          value: markers[index].isSelected,
                          onChanged: (value) {
                            markers[index].isSelected = value;
                          }),
                      title: Text(markers[index].marker.title),
                    )),
          ),
          Divider(
            color: Colors.black54,
          )
        ],
      ),
    );
  }
}
