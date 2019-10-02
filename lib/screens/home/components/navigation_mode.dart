import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spn_flutter/models/route.dart';
import 'package:spn_flutter/provider/route.dart';
import 'package:spn_flutter/screens/walk_report/route_complete.dart';
import 'package:spn_flutter/styles/text_styles.dart';

class NavigationMode extends StatefulWidget {
  RouteModel route;
  final Function() onEditPressed;
  double elapsedTime;
  double passedDistance;

  NavigationMode(
      {this.route, this.onEditPressed, this.elapsedTime, this.passedDistance});

  @override
  State<StatefulWidget> createState() => _NavigationModeState();
}

class _NavigationModeState extends State<NavigationMode> {
  var formatter = NumberFormat('###.#');
  var showPlaces = false;

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

  Widget _getTemplateHeader(RouteModel route) {
    var duration = route.duration ?? 0 / 60.0;
    var distance = route.distance ?? 0 / 1000.0;
    return Material(
        elevation: 2,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(4), topLeft: Radius.circular(4)),
        child: Stack(
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(right: 32),
                            child: Text(
                              'EDIT',
                              style: TextStyles.st12,
                            ),
                          ),
                          onTap: () => widget.onEditPressed()),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            '${(widget.elapsedTime / 60.0 / 60.0).floor()}:${(widget.elapsedTime / 60.0 % 60).floor()} h',
                            style: TextStyles.st16,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '${(duration / 60.0).floor()}:${(duration / 60.0 % 60).floor()} h',
                            style: TextStyles.st18,
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            '${formatter.format(widget.passedDistance)} km',
                            style: TextStyles.st16,
                          ),
                          Text(
                            '${formatter.format(distance)} km',
                            style: TextStyles.st18,
                          )
                        ],
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: GestureDetector(
                          child: Text(
                            "REPORT",
                            style: TextStyles.st12,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    WalkReportScreen(),
                                fullscreenDialog: true));
                          },
                        ))
                  ],
                )),
            Align(
                alignment: Alignment.topCenter,

                child: IconButton(
                  tooltip: "Click to ${showPlaces ? 'hide' : 'show'} list of places",
                  color: Colors.black54,
                  padding: EdgeInsets.all(0),
                  icon: Icon(showPlaces
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  size: 20,),
                  onPressed: () {
                    setState(() {
                      showPlaces = !showPlaces;
                    });
                  },
                ))
          ],
        ));
  }

  ListTile _getListItem(int index, RouteModel route) {
    if (index == route.points.length) return ListTile();
    var color = Colors.black54;
    var icon = 'A';
    var text = 'My Geolocation';
    var textStyle = TextStyles.st3;
    var onTap = () {};
    if (index == route.points.length + 2) {
      return ListTile();
    }
    if (index == route.points.length + 1) {
      icon = 'B';
    } else {
      if (index != 0) {
        icon = index > 0 ? '$index' : 'A';
        text = route.points[index - 1].title;
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

  @override
  Widget build(BuildContext context) {
    var routeProvider = Provider.of<RouteProvider>(context);
    return Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4))),
                margin: EdgeInsets.only(left: 16, right: 16),
                child: GestureDetector(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _getTemplateHeader(routeProvider.route),
                      showPlaces ? Container(height: 250,) : Container()
                    ],
                  ),
                  onVerticalDragEnd: (DragEndDetails details) {
                    print(details.velocity);
                    setState(() {
                      showPlaces =
                          details.velocity.pixelsPerSecond.direction < 0;
                    });
                  },
                ))),
      ],
    );
  }
}
