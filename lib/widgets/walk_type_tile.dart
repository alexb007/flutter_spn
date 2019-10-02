import 'package:flutter/material.dart';
import 'package:spn_flutter/models/walk_type.dart';

class WalkTypeTile extends StatelessWidget {
  final WalkType walkType;

  WalkTypeTile({this.walkType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => walkType.onTap(),
        child: Card(
            elevation: 0,
            child: Material(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            walkType.title,
                            style: TextStyle(
                                fontSize: 18, color: Colors.blueAccent),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            walkType.description,
                            maxLines: 3,
                            softWrap: true,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black45),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Align(
                      child: Icon(Icons.chevron_right),
                      alignment: Alignment.center,
                    ),
                  )
                ],
              ),
            )));
  }
}
