import 'package:flutter/material.dart';
import 'package:spn_flutter/screens/route_complete/components/appbar.dart';
import 'package:spn_flutter/screens/route_complete/components/body.dart';

class RouteCompleteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RouteCompleteScreenState();
}

class _RouteCompleteScreenState extends State<RouteCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Your walk is complete'),
        actions: <Widget>[
          MaterialButton(
            textColor: Colors.white,
            child: Text('DONE'),
            onPressed: () {},
          )
        ],
      ),
      body: RouteCompleteBody()
    );
  }
}
