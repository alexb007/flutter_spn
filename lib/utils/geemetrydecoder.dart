class GeometryDecoder {

  static List<List<double>> decodeGeometry(
      String encodedPath, {bool includeElevation = false}) {
    if (includeElevation) {
      return decodeGeometryORS(encodedPath);
    } else {
      return decodeGeometryDefault(encodedPath);
    }
  }

  static List<List<double>> decodeGeometryDefault(String encodedGeometry) {
    List<List<double>> geometry = [];
    int len = encodedGeometry.length;

    int index = 0;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int result = 1;
      int shift = 0;
      int b;
      do {
        b = encodedGeometry.codeUnitAt(index++) - 63 - 1;
        result += b << shift;
        shift += 5;
      } while (b >= 0x1f);
      lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      result = 1;
      shift = 0;
      do {
        b = encodedGeometry.codeUnitAt(index++) - 63 - 1;
        result += b << shift;
        shift += 5;
      } while (b >= 0x1f);
      lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      List<double> cood = [];
      try {
        cood.add(lat / 1E5);
        cood.add(lng / 1E5);
        geometry.add(cood);
      } on Exception catch (e) {
        print(e.toString());
      }
    }
    return geometry;
  }

  static List<List<double>> decodeGeometryORS(String encodedGeometry) {
    List<List<double>> geometry = [];
    int len = encodedGeometry.length;

    int index = 0;
    int lat = 0;
    int lng = 0;
    int ele = 0;

    while (index < len) {
      int result = 1;
      int shift = 0;
      int b;
      do {
        b = encodedGeometry.codeUnitAt(index++) - 63 - 1;
        result += b << shift;
        shift += 5;
      } while (b >= 0x1f);
      lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      result = 1;
      shift = 0;
      do {
        b = encodedGeometry.codeUnitAt(index++) - 63 - 1;
        result += b << shift;
        shift += 5;
      } while (b >= 0x1f);
      lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      result = 1;
      shift = 0;
      do {
        b = encodedGeometry.codeUnitAt(index++) - 63 - 1;
        result += b << shift;
        shift += 5;
      } while (b >= 0x1f);
      ele += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      List<double> cood = [];
      try {
        cood.add(lat / 1E5);
        cood.add(lng / 1E5);
        cood.add((ele / 100));
        geometry.add(cood);
      } on Exception catch (e) {
        print(e.toString());
      }
    }
    return geometry;
  }
}
