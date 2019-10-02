import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spn_flutter/provider/route.dart';
import 'package:spn_flutter/styles/text_styles.dart';
import 'package:spn_flutter/widgets/buttons/bottom_action_button.dart';
import 'package:spn_flutter/widgets/dialog/dialog.dart';

class RouteDetail extends StatefulWidget {
  final Function() onCancel;
  final Function() onStart;

  RouteDetail({this.onCancel, this.onStart});

  @override
  State<StatefulWidget> createState() => _RouteDetailState();
}

class _RouteDetailState extends State<RouteDetail> {
  var formatter = NumberFormat('###.#');

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

  Widget _getTemplateHeader(routeProvider) {
    var duration = (routeProvider.route.duration ?? 0) / 60.0;
    var distance = (routeProvider.route.distance ?? 0) / 1000.0;
    print(duration);
    print(distance);
    return Material(
      elevation: 2,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      child: Text(
                        'CANCEL',
                        style: TextStyles.st12,
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => CustomDialog(
                                  text: 'Do you want to cancel a walk?',
                                  positiveButtonText: 'Yes',
                                  positiveOnTap: () {
                                    Navigator.of(context).pop();
                                    widget.onCancel();
                                  },
                                  negativeButtonText: 'No',
                                  negativeOnTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ));
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      '${(duration / 60.0).floor()}:${(duration % 60).floor()} h',
                      style: TextStyles.st16,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      '${formatter.format(distance)} km',
                      style: TextStyles.st16,
                    ),
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'Walk expects start',
                style: TextStyles.st17,
              ),
            ),
          )
        ],
      ),
    );
  }

  ListTile _getListItem(int index, RouteProvider routeProvider) {
    if (index == routeProvider.route.points.length) return ListTile();
    var color = Colors.black54;
    var icon = '${index + 1}';
    var text = routeProvider.route.points[index].title;
    var textStyle = TextStyles.st3;
    var onTap = () {};
    if (index == routeProvider.route.points.length + 1) {
      return ListTile();
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
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              margin: EdgeInsets.all(16),
              height: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _getTemplateHeader(routeProvider),
                  Expanded(
                    child: ListView.builder(
                        itemCount: routeProvider.route.points.length + 1,
                        itemBuilder: (context, i) =>
                            _getListItem(i, routeProvider)),
                  ),
                ],
              ),
            )),
        Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: BottomActionButton(
                    text: 'START',
                    onPressed: () => widget.onStart(),
                  ),
                )
              ],
            )),
      ],
    );
  }
}
