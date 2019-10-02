import 'package:flutter/cupertino.dart';
import 'package:spn_flutter/data/Constants.dart';
import 'package:spn_flutter/data/db/database.dart';
import 'package:spn_flutter/data/db/models/category.dart';
import 'package:spn_flutter/models/route.dart';
import 'package:spn_flutter/models/walk_type.dart';
import 'package:spn_flutter/screens/route_detail/components/arguments.dart';
import 'package:spn_flutter/screens/template_route_detail/route_detail_screen.dart';
import 'package:spn_flutter/widgets/walk_type_tile.dart';

class TemplateWalkBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TemplateWalkBodyState();
}

class _TemplateWalkBodyState extends State<TemplateWalkBody> {

  List<List<Category>> matrix = [];

  @override
  void initState() {

    Floor.instance.database.then((db) {
      Constants.templateWalks.forEach((walk) {
        db.categoryDao.getCategoryByWalkType('%${walk.walkTypeId}%').then((categoryList) {
          matrix.add(categoryList);
          walk.categories = categoryList;

        });
        walk.distance = 0;
        walk.duration = 0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void walkOnTap(RouteModel walk) {
      Navigator.of(context).pushNamed(TemplateRouteDetailScreen.route,
          arguments: RouteArguments(walk));
    }

    var tiles = Constants.templateWalks.map((walk) {
      return WalkType(
        walk.title,
        walk.description,
        onTap: () => walkOnTap(walk),
      );
    }).toList();

    return ListView.builder(
      itemBuilder: (context, i) => WalkTypeTile(
        walkType: tiles[i],
      ),
      itemCount: tiles.length,
    );
  }
}
