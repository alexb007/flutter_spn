import 'package:flutter/material.dart';

import 'components/body.dart';

class LicenseScreen extends StatefulWidget {
  static const String route = '/license';

  @override
  State<StatefulWidget> createState() => _LicenseState();
}

class _LicenseState extends State<LicenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Body(),
    );
  }
}
