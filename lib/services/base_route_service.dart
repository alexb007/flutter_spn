import 'package:flutter/material.dart';

@optionalTypeArgs
abstract class BaseRouteAPIService<T extends dynamic> {
  Future<T> getRoute(List<List<double>> points);
}