import 'package:mapbox_gl/mapbox_gl.dart';

class Marker {
  String type;
  String title;
  LatLng geometry;
  String iconImage;
  String address;

  Marker({this.type, this.title, this.geometry, this.iconImage, this.address});
}

class MarkerTypes {
  static const String MY_LOCATION = 'my_location';
  static const String DESTINATION = 'destination';
  static const String SHOP = 'shop';
  static const String RESTAURANT = 'restaurant';
  static const String BUS_STATION = 'bus_station';
  static const String PARK = 'park';
  static const String WIFI_ZONE = 'wifi_zone';
}
