import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spn_flutter/models/route.dart';
import 'package:spn_flutter/provider/route.dart';
import 'package:spn_flutter/screens/create_walk/create_walk_screen.dart';
import 'package:spn_flutter/screens/home/home_screen.dart';
import 'package:spn_flutter/screens/license_agreement/license_agreement.dart';
import 'package:spn_flutter/screens/quick_find/quick_find.dart';
import 'package:spn_flutter/screens/route_detail/route_detail_screen.dart';
import 'package:spn_flutter/screens/settings/settings.dart';
import 'package:spn_flutter/screens/splash/splash_screen.dart';
import 'package:spn_flutter/screens/template_route_detail/route_detail_screen.dart';
import 'package:spn_flutter/screens/template_walks/template_walks_screen.dart';
import 'package:spn_flutter/screens/welcome/welcome_screen.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(SPNApp());
}

class SPNApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RouteProvider>(
        builder: (_) => RouteProvider(),
        child: Consumer<RouteProvider>(
            builder: (context, route, _) {
              return MaterialApp(
                title: 'SPN Project',
                theme: ThemeData(
                    primarySwatch: Colors.blue, fontFamily: 'Roboto'),
                home: SplashScreen(),
                routes: <String, WidgetBuilder>{
                  HomeScreen.route: (context) => HomeScreen(),
                  WelcomeScreen.route: (context) => WelcomeScreen(),
                  CreateWalkScreen.route: (context) => CreateWalkScreen(),
                  TemplateWalksScreen.route: (context) => TemplateWalksScreen(),
                  RouteDetailScreen.route: (context) => RouteDetailScreen(),
                  TemplateRouteDetailScreen.route: (context) =>
                      TemplateRouteDetailScreen(),
                  QuickFindScreen.route: (context) => QuickFindScreen(),
                  LicenseScreen.route: (context) => LicenseScreen(),
                  SettingsScreen.route: (context) => SettingsScreen(),
                },
              );
            }
        ));
  }
}
