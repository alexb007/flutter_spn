import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spn_flutter/screens/create_walk/components/body.dart';

class CreateWalkScreen extends StatefulWidget {

  static final String route = '/createwalk';

  @override
  State<StatefulWidget> createState() => _CreateWalkScreenState();
}

class _CreateWalkScreenState extends State<CreateWalkScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create a walk',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: CreateWalkBody(),
    );
  }
}
