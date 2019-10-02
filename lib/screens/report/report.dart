import 'package:flutter/material.dart';

import 'components/body.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReportState();
}

class _ReportState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick find a place'),
      ),
      body: Body(),
    );
  }
}
