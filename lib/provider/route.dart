import 'package:flutter/material.dart';
import 'package:spn_flutter/models/route.dart';

class RouteProvider extends ChangeNotifier {
  var _route = RouteModel();
  var _routeState = 1; // 1 - not set, 2 - set, 3 - started

  RouteModel get route => _route;
  int get routeState => _routeState;

  set route(RouteModel routeModel) {
    _route = routeModel;
    notifyListeners();
  }

  set routeState(int routeState) {
    _routeState = routeState;
    notifyListeners();
  }

}
