import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spn_flutter/screens/home/home_screen.dart';
import 'package:spn_flutter/screens/route_detail/components/arguments.dart';

import 'components/body.dart';

class RouteDetailScreen extends StatelessWidget {
  static final String route = '/routedetail';

  @override
  Widget build(BuildContext context) {
    final RouteArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create a walk'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).popUntil(ModalRoute.withName(HomeScreen.route));
          },
        ),
      ),
      body: Body(args.walkRoute),
    );
  }

}