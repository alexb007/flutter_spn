import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:spn_flutter/data/db/models/category.dart';
import 'package:spn_flutter/models/marker.dart';

class RouteModel {
  String title;
  String description;
  int walkTypeId;
  List<Category> categories;
  List<Marker> points;
  List<LatLng> linesGeometry;
  double distance;
  double duration;

  RouteModel(
      {this.title,
      this.description,
      this.walkTypeId,
      this.categories = const [],
      this.points = const [],
      this.distance,
      this.duration,
      this.linesGeometry});


}
