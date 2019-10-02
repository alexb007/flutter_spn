import 'package:flutter/material.dart';

import 'components/body.dart';

class QuickFindScreen extends StatefulWidget {

  static final route = '/quickfind';

  @override
  State<StatefulWidget> createState() => _QuickFindState();
}

class _QuickFindState extends State<QuickFindScreen> {
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
