import 'package:spn_flutter/data/db/models/category.dart';
import 'package:spn_flutter/models/route.dart';

class RouteUtil {
  static List<List<String>> getRouteTags(RouteModel walkRoute) {
    return walkRoute.categories
        .map((category) {
          return category.tags.split(",").map((tag) {
            return tag.split(':');
          }).toList();
        })
        .toList()
        .expand((i) => i)
        .toList()
        .where((e) => e[0].length > 0)
        .toList();
  }

  static List<List<String>> getCategoryTags(Category category) {
    if (category.tags == '')
      return [];
    return category.tags.split(',').map((tag) {
      return tag.split(':');
    }).toList();
  }
}
