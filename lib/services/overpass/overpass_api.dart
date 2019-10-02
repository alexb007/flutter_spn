import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:spn_flutter/services/overpass/models/overpass.dart';

class OverpassAPI {
  final String apiUrl = "http://overpass-api.de/api/interpreter";
  var client = http.Client();

  static const String ATM = 'atm';//['atm'];
  static const String CULTURE_EVENTS = 'arts_centre';  //['arts_centre', 'theatre'];
  static const String GREEN_AREAS = 'fountain';//['fountain',];
  static const String PLAYGROUNDS = 'casino';//['casino'];
  static const String STREET_FURNITURE = 'bench';//['bench'];

  Future performRequest(String query) async {
    print("$apiUrl?data=$query");
    return await client.get("$apiUrl?data=$query");
  }

  Future<OverpassResponse> getNodesByName(
      String name, LatLngBounds bounds) async {
    var query = '[out:json];'
        'node('
        '${bounds.southwest.latitude},'
        '${bounds.southwest.longitude},'
        '${bounds.northeast.latitude},'
        '${bounds.northeast.longitude})'
        '["$name"];'
        'out;';
    var response = await performRequest(query);
    var responseBody = utf8.decode(response.bodyBytes);
    return OverpassResponse.fromJson(json.decode(responseBody));
  }

  Future<OverpassResponse> getNodesByType(
      String type, LatLngBounds bounds) async {
    var query = '[out:json];'
        'area[name="Bologne"];'
        'node(area);'
        'node(around:5000)[amenity=$type]'
        'out;';

    var response = await performRequest(query);
    var responseBody = utf8.decode(response.bodyBytes);
    return OverpassResponse.fromJson(json.decode(responseBody));
  }

  Future<OverpassResponse> getNodesByTags(
      List<List<String>> types, {LatLngBounds bounds, int radius = 0, LatLng latLng}) async {
    var area = radius == 0 ? 'area' : 'around:$radius' + (latLng != null ? ',${latLng.latitude},${latLng.longitude}' : '');
    var params = types.map((tag) {
      return 't["${tag[0]}"] == "${tag[1]}"';
    }).toList().join(" || ");
    var query = '[out:json];'
        'node($area)(if: $params);'
        'out;';

    var response = await performRequest(query);
    var responseBody = utf8.decode(response.bodyBytes);
    return OverpassResponse.fromJson(json.decode(responseBody));
  }
}
