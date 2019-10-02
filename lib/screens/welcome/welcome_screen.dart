import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spn_flutter/screens/license_agreement/license_agreement.dart';
import 'package:spn_flutter/widgets/intro_views/intro_views_flutter.dart';
import 'package:spn_flutter/widgets/intro_views/models/page_view_model.dart';

class WelcomeScreen extends StatefulWidget {
  static final String route = '/welcome';

  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final pages = [
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      title: Text('Welcome to PPA!'),
      body: Text(
        'This is a personal pedestrian assistant. Let\'s stroll!',
      ),
      mainImage: AssetImage(
        'assets/images/welcome1.png',
      ),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      iconColor: null,
      title: Text('Going for a walk?'),
      body: Column(
        children: <Widget>[
          Text(
            'Just select the type and category of walk, and the PPA will offer you the best options.',
          ),
        ],
      ),
      mainImage: AssetImage(
        'assets/images/welcome2.png',
      ),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      iconColor: null,
      title: Text('Limited in time?'),
      body: Column(
        children: <Widget>[
          Text(
              'Set the parameters of the duration of the walk and the PPA will '
              'do everything to make you always have time on time, walking '
              'through interesting places.'),
        ],
      ),
      mainImage: AssetImage(
        'assets/images/welcome3.png',
      ),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      iconColor: null,
      title: Text(
        'Planning a trip to another city or country?',
        textAlign: TextAlign.center,
      ),
      body: Column(
        children: <Widget>[
          Text(
              'PPA will help you to deal with this! Create and save your walks.'
              ' Start at your convenience!'),
        ],
      ),
      mainImage: AssetImage(
        'assets/images/welcome4.png',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroView(
      pages,
      onTapDoneButton: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LicenseScreen()));
      },
      showSkipButton: false,
      showNextButton: true,
      nextText: Text("NEXT"),
      doneText: Text(
        "LET'S START",
      ),
      fullTransition: 200,
      pageButtonsColor: Colors.white,
      pageButtonTextStyles: new TextStyle(
        // color: Colors.indigo,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Roboto",
      ),
    );
  }
}
