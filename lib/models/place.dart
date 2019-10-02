import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:spn_flutter/data/db/models/category.dart';
import 'package:spn_flutter/services/overpass/models/overpass.dart';

class PlaceOptions {
  int id;
  String title;
  Element overpassNode;
  Category category;

  PlaceOptions(this.id, this.title, this.category, {this.overpassNode});
}
