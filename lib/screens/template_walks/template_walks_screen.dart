import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spn_flutter/screens/template_walks/components/body.dart';

class TemplateWalksScreen extends StatelessWidget {
  static final String route = '/templatewalks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Template walks'),
      ),
      body: TemplateWalkBody(),
    );
  }

}