import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spn_flutter/screens/home/home_screen.dart';

import 'components/body.dart';

class SettingsScreen extends StatefulWidget {
  static final route = '/settings';

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter your settings'),
        actions: <Widget>[
          MaterialButton(
            child: Text('SKIP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () {
              SharedPreferences.getInstance().then((prefs) {
                prefs.setBool('first_run', false);
              });
              Navigator.of(context).pushReplacementNamed(HomeScreen.route);
            },
          )
        ],
      ),
      body: Body(),
    );
  }
}
