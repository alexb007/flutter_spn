import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spn_flutter/screens/home/home_screen.dart';
import 'package:spn_flutter/screens/welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkFirstRun() async {
    var prefs = await SharedPreferences.getInstance();
    bool _firstRun = (prefs.getBool('first_run') ?? true);
    if (!_firstRun) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.route);
      return;
    }
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new WelcomeScreen()));
  }

  @override
  void initState() {
    new Timer(new Duration(milliseconds: 1000), () => checkFirstRun());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:[
              new Color(0xFF69C0FF),
              new Color(0xFF087ED2),
            ]
          )
        ),
        child: Center(
          child: SvgPicture.asset(
            "assets/images/splash.svg",
            semanticsLabel: 'SPN Logo',
            height: 180,
          ),
        ),
      ),
    );
  }
}
