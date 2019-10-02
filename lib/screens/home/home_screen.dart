import 'package:flutter/material.dart';
import 'package:spn_flutter/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  static final String route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeBody());
  }
}
