import 'package:flutter/material.dart';
import 'package:spn_flutter/models/route.dart';
import 'package:spn_flutter/models/walk_type.dart';
import 'package:spn_flutter/screens/quick_find/quick_find.dart';
import 'package:spn_flutter/screens/route_detail/components/arguments.dart';
import 'package:spn_flutter/screens/route_detail/route_detail_screen.dart';
import 'package:spn_flutter/screens/template_walks/template_walks_screen.dart';
import 'package:spn_flutter/widgets/walk_type_tile.dart';

class CreateWalkBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateWalkBodyState();
}

class _CreateWalkBodyState extends State<CreateWalkBody> {


  @override
  Widget build(BuildContext context) {
    var walkTypes = [
      WalkType(
          'Template walk',
          'Описание прогулки и ограничения, которые входят в эту прогулку',
          onTap: () {
            Navigator.of(context).pushNamed(TemplateWalksScreen.route);
          }
      ),
      WalkType(
          'Create walk',
          'Описание прогулки и ограничения, которые входят в эту прогулку Описание прогулки и ограничения',
          onTap: () {
            Navigator.of(context).pushNamed(RouteDetailScreen.route, arguments: RouteArguments(RouteModel(points: [], distance: 0, duration: 0)));
          }
      ),
      WalkType(
          'Find an Urgent place',
          'Описание прогулки и ограничения, которые входят в эту прогулку',
          onTap: () {
            Navigator.of(context).pushNamed(QuickFindScreen.route);
          }
      )
    ];

    return Container(
      child: ListView.builder(
          itemBuilder: (context, i) => WalkTypeTile(walkType: walkTypes[i]),
          itemCount: walkTypes.length),
    );
  }
}
