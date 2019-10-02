import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:spn_flutter/models/route.dart';
import 'package:spn_flutter/styles/text_styles.dart';
import 'package:spn_flutter/widgets/dialog/category_dialog.dart';
import 'package:spn_flutter/widgets/dialog/dialog.dart';

class RoutePlanner extends StatefulWidget {
  final RouteModel templateWalk;
  final MapboxMapController mapController;
  final bool canEdit;

  RoutePlanner({this.templateWalk, this.mapController, this.canEdit = false});

  @override
  State<StatefulWidget> createState() => _RoutePlannerState();
}

class _RoutePlannerState extends State<RoutePlanner> {
  TimeOfDay _fromTime = TimeOfDay.now();
  TimeOfDay _toTime = null;

  String _fromTimeString = "2";
  String _toTimeString = "3";

  var formatter = NumberFormat('###.#');

  Future<void> _selectTime(BuildContext context, time) async {
    var timeObj = (time == 'from') ? _fromTime : _toTime;
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: (timeObj != null) ? timeObj : TimeOfDay.now());
    if (picked != null && picked != timeObj) {
      setState(() {
        if (time == 'from') {
          _fromTime = picked;
        }
        if (time == 'to') {
          _toTime = picked;
        }
      });
    }
  }

  @override
  void initState() {
//    _fromTimeString = _fromTime.format(context);
//    _toTimeString = (_toTime != null) ? _toTime.format(context) : 'Time';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _fromTimeString = _fromTime.format(context);
    _toTimeString = (_toTime != null) ? _toTime.format(context) : "Time";
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

    void _showCategories() {
      showBottomSheet(
          context: context,
          builder: (context) => BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: 10,
                sigmaX: 10,
              ),
              child: Material(
                child: Container(
                  color: Colors.white,
                  child: Wrap(
                    children: <Widget>[
                      ListTile(
                        title: Text('Choose from a category'),
                        onTap: () {
                          showBottomSheet(
                              context: context,
                              builder: (context) => CategoryDialog(
                                  mapController: widget.mapController));
                        },
                      ),
                      ListTile(
                        title: Text('Choose a place on the map'),
                        onTap: () {},
                      )
                    ],
                  ),
                ),
                elevation: 4.0,
              )));
    }

    Widget _getTemplateHeader() {
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
                        'Route 1',
                        style: TextStyles.st10,
                      ),
                      Text(
                        '/ 1',
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
                                                    'Template "${widget.templateWalk.title}" 41 saved',
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
                    '${formatter.format(widget.templateWalk.duration / 60.0 / 60.0)} h',
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
                    '${formatter.format(widget.templateWalk.distance / 1000.0)} km',
                    style: TextStyles.st1,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget _getCustomRouteHeader() {
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
                  Text(
                    'Today',
                    style: TextStyles.st1,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        'From',
                        style: TextStyles.st2,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        child: Text(
                          _fromTimeString,
                          style: TextStyles.st1,
                        ),
                        onTap: () => _selectTime(context, 'from'),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'to',
                        style: TextStyles.st2,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        child: Text(
                          _toTimeString,
                          style: TextStyles.st1,
                        ),
                        onTap: () => _selectTime(context, 'to'),
                      ),
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
                    '${widget.templateWalk.duration} h',
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
                    '${widget.templateWalk.distance} km',
                    style: TextStyles.st1,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    ListTile _getListItem(index) {
      if (index == widget.templateWalk.points.length + 3)
        return ListTile();
      var color = Colors.black54;
      var icon = 'A';
      var text = 'My Geolocation';
      var textStyle = TextStyles.st3;
      var onTap = () {};
      if (index == widget.templateWalk.points.length + 2) {
        icon = 'B';
      } else {
        if (widget.canEdit && index == widget.templateWalk.points.length + 1) {
          icon = '+';
          color = Color(0xFF2798E9);
          text = 'ADD PLACE';
          onTap = () {
            _showCategories();
          };
          textStyle = TextStyles.st4;
        } else if (index > 0) {
          icon = '$index';
          text = widget.templateWalk.points[index-1].title;
        }
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

    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      alignment: Alignment.bottomCenter,
      child: Column(
        children: <Widget>[
          widget.canEdit ? _getCustomRouteHeader() : _getTemplateHeader(),
          Expanded(
            child: ListView.builder(
                itemCount: widget.templateWalk.points.length + 4,
                itemBuilder: (context, i) => _getListItem(i)),
          ),
        ],
      ),
    );
  }
}
