import 'package:flutter/material.dart';

import 'components/body.dart';

class WalkReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WalkReportScreenState();
}

class _WalkReportScreenState extends State<WalkReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      body: WalkReportBody()
    );
  }
}
