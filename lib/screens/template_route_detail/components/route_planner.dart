import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:spn_flutter/models/route.dart';
import 'package:spn_flutter/styles/text_styles.dart';
import 'package:spn_flutter/widgets/dialog/dialog.dart';

class RoutePlanner extends StatefulWidget {
  final List<RouteModel> routes;
  final MapboxMapController mapController;
  final Function(int routeIndex) onRouteSelected;

  RoutePlanner(
      {@required this.routes, this.mapController, this.onRouteSelected});

  @override
  State<StatefulWidget> createState() => _RoutePlannerState();
}

class _RoutePlannerState extends State<RoutePlanner> {
  var formatter = NumberFormat('###.#');

  @override
  void initState() {
//    _fromTimeString = _fromTime.format(context);
//    _toTimeString = (_toTime != null) ? _toTime.format(context) : 'Time';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _getLeadingIcon(color, icon) {
      return ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            splashColor: Colors.grey,
            child: SizedBox(
              height: 24,
              width: 24,
              child: Center(
                  child: Text(
                icon,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              )),
            ),
          ),
        ),
      );
    }

    Widget _getTemplateHeader(int routeIndex) {
      return Material(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Route ${routeIndex + 1}',
                        style: TextStyles.st10,
                      ),
                      Text(
                        '/ ${widget.routes.length}',
                        style: TextStyles.st11,
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      GestureDetector(
                        child: Text(
                          'SAVE ROUTE',
                          style: TextStyles.st12,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomDialog(
                                    text: 'Do you want to save the route?',
                                    positiveButtonText: 'Save',
                                    positiveOnTap: () {
                                      Navigator.of(context).pop();
                                      showDialog(
                                          context: context,
                                          builder: (context) => CustomDialog(
                                                text:
                                                    'Template "${widget.routes[routeIndex].title}" saved',
                                                positiveButtonText: 'OK',
                                                positiveOnTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ));
                                    },
                                    negativeButtonText: 'Cancel',
                                    negativeOnTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ));
                        },
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Duration',
                    style: TextStyles.st2,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    '${formatter.format(widget.routes[routeIndex].duration / 60.0 / 60.0)} h',
                    style: TextStyles.st1,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    'Distance',
                    style: TextStyles.st2,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    '${formatter.format(widget.routes[routeIndex].distance / 1000.0)} km',
                    style: TextStyles.st1,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    ListTile _getListItem(int routeIndex, int index) {
      if (index == widget.routes[routeIndex].points.length) return ListTile();
      var color = Colors.black54;
      var icon = 'A';
      var text = 'My Geolocation';
      var textStyle = TextStyles.st3;
      var onTap = () {};
      if (index == widget.routes[routeIndex].points.length - 1) {
        icon = 'B';
      } else {
        icon = index > 0 ? '$index' : 'A';
        text = widget.routes[routeIndex].points[index].title;
      }
      return ListTile(
        leading: _getLeadingIcon(color, icon),
        title: Text(
          "$text",
          style: textStyle,
        ),
        onTap: onTap,
        subtitle: Text(
          '',
          style: TextStyle(fontSize: 10),
        ),
      );
    }

    return AnimatedContainer(duration: Duration(seconds: 1),
      height: 350,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      alignment: Alignment.bottomCenter,
      child: Swiper(
        itemCount: widget.routes.length,
        itemBuilder: (context, routeIndex) => Container(
          width: 300,
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Column(
            children: <Widget>[
              _getTemplateHeader(routeIndex),
              Expanded(
                child: ListView.builder(
                    itemCount: widget.routes[routeIndex].points.length + 1,
                    itemBuilder: (context, i) => _getListItem(routeIndex, i)),
              ),
            ],
          ),
        ),
        onIndexChanged: (index) => widget.onRouteSelected(index),
      ),
    );
  }
}
